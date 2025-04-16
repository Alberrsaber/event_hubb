import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String eventId;
  final String eventName;
  final String eventDes;
  final String eventBegDate;
  final String eventEndDate;
  final String eventImage;
  final String eventSponser;
  final String eventLocation;
  final String eventMaxAttendees;
  final String eventCategory;
  final String eventStatus;

  EventModel({
    required this.eventId,
    required this.eventName,
    required this.eventDes,
    required this.eventBegDate,
    required this.eventEndDate,
    required this.eventImage,
    required this.eventSponser,
    required this.eventLocation,
    required this.eventMaxAttendees,
    required this.eventCategory,
    required this.eventStatus,
  });

  // Convert EventModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'eventName': eventName,
      'eventDes': eventDes,
      'eventBegDate': Timestamp.fromDate(eventBegDate), // Convert DateTime to Timestamp
      'eventEndDate': Timestamp.fromDate(eventEndDate),
      'eventImage': eventImage,
      'eventSponser': eventSponser,
      'eventLocation': eventLocation,
      'eventMaxAttendees': eventMaxAttendees,
      'eventCategory': eventCategory,
      'eventStatus': eventStatus,
    };
  }

  // Extract an EventModel from a Map.
  factory EventModel.fromMap(Map<String, dynamic> data, String documentId) {
    return EventModel(
      eventId: documentId,
      eventName: data['eventName'] ?? '', // Provide default value if null
      eventDes: data['eventDes'] ?? '',
      eventBegDate: data['eventBegDate'] ?? '',
      eventEndDate: data['eventEndDate'] ?? '',
      eventImage: data['eventImage'] ?? '',
      eventSponser: data['eventSponser'] ?? '',
      eventLocation: data['eventLocation'] ?? '',
      eventMaxAttendees: data['eventMaxAttendees'] ?? '',
      eventCategory: data['eventCategory'] ?? '',
      eventStatus: data['eventStatus'] ?? '',
    );
  }
}