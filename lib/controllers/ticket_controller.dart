import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_booking_app_ui/models/event_model.dart';
import 'package:event_booking_app_ui/models/ticket_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class TicketController {
  Future<void> saveTicket(EventModel event, orderId, seat) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final ticketId = const Uuid().v4();
    final ticket = TicketModel(
      ticketId: ticketId,
      userId: uid,
      eventId: event.eventId,
      eventName: event.eventName,
      eventImage: event.eventImage,
      eventBegDate: event.eventBegDate,
      eventLocation: event.eventLocation,
      orderId: orderId,
      seat: seat, // or dynamically assigned
    );
  await  incrementEventAttendees(event.eventId);

    await FirebaseFirestore.instance
        .collection('Tickets')
        .doc(ticketId)
        .set(ticket.toMap());
  }


// generate ticketId
  String generateOrderId() {
    final now = DateTime.now();
    final formattedDate = "${now.year}${now.month}${now.day}";
    final randomStr = DateTime.now()
        .millisecondsSinceEpoch
        .remainder(100000)
        .toString()
        .padLeft(5, '0');
    return "ORD$formattedDate$randomStr"; // Example: ORD2025051343872
  }

  // generateSeatNumber
  Future<String> generateSeatNumber(String eventid) async {
    final eventSnapshot = await FirebaseFirestore.instance
        .collection('Events')
        .doc(eventid)
        .get();
    if (!eventSnapshot.exists) {
      throw Exception("Event not found");
    }

    final data = eventSnapshot.data();
    int currentAttendees =
        int.tryParse(data?['eventAttendees']?.toString() ?? '0') ?? 0;

    int nextSeatNumber = currentAttendees + 1;
    return "A$nextSeatNumber";
  }
  
  // save ticket image
  Future<void> saveTicketPhoto(
      GlobalKey repaintBoundaryKey, BuildContext context) async {
    try {
      bool isPermitted = await requestPermission();
      if (!isPermitted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Storage permission denied")),
        );
        return;
      }

      RenderRepaintBoundary boundary = repaintBoundaryKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);

      if (byteData != null) {
        Uint8List pngBytes = byteData.buffer.asUint8List();

        final result = await ImageGallerySaverPlus.saveImage(pngBytes);
        if (result['isSuccess'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Ticket saved to gallery")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to save ticket")),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving ticket: $e")),
      );
    }
  }

  Future<bool> requestPermission() async {
    var status = await Permission.storage.request();
    return status.isGranted;
  }

  Future<String?> shareTicketPhoto(
      GlobalKey repaintBoundaryKey, BuildContext context) async {
    try {
      // Ask for permission
      var status = await Permission.storage.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Storage permission denied")),
        );
        return null;
      }

      RenderRepaintBoundary boundary = repaintBoundaryKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);

      if (byteData != null) {
        Uint8List pngBytes = byteData.buffer.asUint8List();

        // Save to temp directory for sharing
        final tempDir = await getTemporaryDirectory();
        final file = await File(
                '${tempDir.path}/ticket_${DateTime.now().millisecondsSinceEpoch}.png')
            .create();
        await file.writeAsBytes(pngBytes);

        // Also save to gallery
        await ImageGallerySaverPlus.saveImage(pngBytes);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Ticket saved to gallery")),
        );
        return file.path;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving ticket: $e")),
      );
    }
    return null;
  }

  // get my tickets
  Stream<QuerySnapshot> getMyTickets() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      throw Exception("User not authenticated");
    }
    return FirebaseFirestore.instance
        .collection('Tickets')
        .where('userId', isEqualTo: uid)
        .snapshots();
  }
  // increment EventAttende
  Future<void> incrementEventAttendees(String eventId) async {
  final eventRef = FirebaseFirestore.instance.collection('Events').doc(eventId);

  await eventRef.update({
    'eventAttendees': FieldValue.increment(1),
  });
}

// check if user booked event
Future<bool> hasUserBookedEvent(String eventId) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return false;

  final snapshot = await FirebaseFirestore.instance
      .collection('Tickets')
      .where('userId', isEqualTo: user.uid)
      .where('eventId', isEqualTo: eventId)
      .limit(1)
      .get();

  return snapshot.docs.isNotEmpty;
}
}
