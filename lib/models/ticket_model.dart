import 'package:cloud_firestore/cloud_firestore.dart';

class TicketModel {
  final String ticketId;
  final String userId;
  final String eventId;
  final String eventName;
  final String eventImage;
  final DateTime eventBegDate;
  final String eventLocation;
  final String orderId;
  final String seat;

  TicketModel({
    required this.ticketId,
    required this.userId,
    required this.eventId,
    required this.eventName,
    required this.eventImage,
    required this.eventBegDate,
    required this.eventLocation,
    required this.orderId,
    required this.seat,
  });

  Map<String, dynamic> toMap() {
    return {
      'ticketId': ticketId,
      'userId': userId,
      'eventId': eventId,
      'eventName': eventName,
      'eventImage': eventImage,
      'eventBegDate': eventBegDate,
      'eventLocation': eventLocation,
      'orderId': orderId,
      'seat': seat,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
