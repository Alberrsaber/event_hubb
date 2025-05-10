import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_booking_app_ui/models/event_model.dart';
import 'package:event_booking_app_ui/models/ticket_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';


class TicketController {
Future<void> saveTicket(EventModel event) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return;

  final ticketId = const Uuid().v4();
  final orderId = 'ORD-${DateTime.now().millisecondsSinceEpoch}';

  final ticket = TicketModel(
    ticketId: ticketId,
    userId: uid,
    eventId: event.eventId,
    eventName: event.eventName,
    eventImage: event.eventImage,
    eventBegDate: event.eventBegDate,
    eventLocation: event.eventLocation,
    orderId: orderId,
    seat: 'A21', // or dynamically assigned
  );

  await FirebaseFirestore.instance
      .collection('Users')
      .doc(uid)
      .collection('tickets')
      .doc(ticketId)
      .set(ticket.toMap());
}
}