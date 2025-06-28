import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String eventId;
  final String eventName;
  final String eventDes;
  final List<DateTime> eventDates;
  final String eventImage;
  final String eventSponser;
  final String eventLocation;
  final String eventMaxAttendees;
  final int eventAttendees;
  final String eventCategory;
  final String eventStatus;
  final List<String> eventBookmarks;

  EventModel({
    required this.eventId,
    required this.eventName,
    required this.eventDes,
    required this.eventDates,
    required this.eventImage,
    required this.eventSponser,
    required this.eventLocation,
    required this.eventMaxAttendees,
    required this.eventCategory,
    required this.eventStatus,
    required this.eventBookmarks,
    required this.eventAttendees,
  });

  Map<String, dynamic> toMap() {
    return {
      'eventName': eventName,
      'eventDes': eventDes,
      'eventDates': eventDates.map((date) => Timestamp.fromDate(date)).toList(),
      'eventImage': eventImage,
      'eventSponser': eventSponser,
      'eventLocation': eventLocation,
      'eventMaxAttendees': eventMaxAttendees,
      'eventCategory': eventCategory,
      'eventStatus': eventStatus,
      'eventBookmarks': eventBookmarks,
      'eventAttendees': eventAttendees,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> data, String documentId) {
    return EventModel(
      eventId: documentId,
      eventName: data['eventName'] ?? '',
      eventDes: data['eventDes'] ?? '',
      eventDates: _convertToDateList(data['eventDates']),
      eventImage: data['eventImage'] ?? '',
      eventSponser: data['eventSponser'] ?? '',
      eventLocation: data['eventLocation'] ?? '',
      eventMaxAttendees: data['eventMaxAttendees'] ?? '',
      eventCategory: data['eventCategory'] ?? '',
      eventStatus: data['eventStatus'] ?? '',
      eventAttendees: data['eventAttendees'] ?? 0,
      eventBookmarks: List<String>.from(data['eventBookmarks'] ?? []),
    );
  }

  static List<DateTime> _convertToDateList(dynamic value) {
    if (value is List) {
      return value.map((item) {
        if (item is Timestamp) return item.toDate();
        if (item is String) return DateTime.tryParse(item) ?? DateTime.now();
        return DateTime.now();
      }).toList();
    }
    return [];
  }
}
