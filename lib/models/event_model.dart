import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String eventId;
  final String eventName;
  final String eventDes;
  final DateTime eventBegDate;
  final DateTime eventEndDate;
  final String eventImage;
  final String eventSponser;
  final String eventLocation;
  final String eventMaxAttendees;
  final String eventCategory;
  final String eventStatus;
  final List<String> eventBookmarks ;

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
    required this.eventBookmarks,
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
      'eventBookmarks': eventBookmarks,
    };
  }

  // Create EventModel from Firestore Map
factory EventModel.fromMap(Map<String, dynamic> data, String documentId) {
  return EventModel(
    eventId: documentId,
    eventName: data['eventName'] ?? '',
    eventDes: data['eventDes'] ?? '',
    eventBegDate: _convertToDate(data['eventBegDate']),
    eventEndDate: _convertToDate(data['eventEndDate']),
    eventImage: data['eventImage'] ?? '',
    eventSponser: data['eventSponser'] ?? '',
    eventLocation: data['eventLocation'] ?? '',
    eventMaxAttendees: data['eventMaxAttendees'] ?? '',
    eventCategory: data['eventCategory'] ?? '',
    eventStatus: data['eventStatus'] ?? '',
    eventBookmarks: List<String>.from(data['eventBookmarks'] ?? []),
  );
}

 static  DateTime _convertToDate(dynamic value) {
  if (value is Timestamp) {
    return value.toDate();
  } else if (value is String) {
    return DateTime.tryParse(value) ?? DateTime.now();
  } else {
    return DateTime.now();
  }
}

}
