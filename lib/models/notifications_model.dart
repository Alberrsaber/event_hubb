import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationsModel {
  final String NotificationsId;
  final String NotificationsTitle;
  final String NotificationsBody;
  final DateTime NotificationTime;
  final String userId;

  NotificationsModel(
      {required this.NotificationsId,
      required this.NotificationsTitle,
      required this.NotificationsBody,
      required this.NotificationTime,
      required this.userId});

      Map <String, dynamic> toMap() {
        return {
          'NotificationsId': NotificationsId,
          'NotificationsTitle': NotificationsTitle,
          'NotificationsBody': NotificationsBody,
          'NotificationTime': Timestamp.fromDate(NotificationTime),
          'userId': userId,
        };
      }

  factory NotificationsModel.fromMap(
      Map<String, dynamic> data, String documentId) {
        return NotificationsModel(
          NotificationsId: documentId,
          NotificationsTitle: data['notificationsTitle'] ?? '',
          NotificationsBody: data['notificationsBody'] ?? '',
          NotificationTime: _convertToDate(data['NotificationTime']),
          userId: data['userId'] ?? '',
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
