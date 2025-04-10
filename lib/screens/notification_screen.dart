import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<NotificationItem> _notifications = [
    NotificationItem(
      userName: 'David Silbia',
      action: 'Invite Jo Malone',
      description: "London's Mother's",
      time: DateTime.now(),
      hasActions: true,
    ),
    
    NotificationItem(
      userName: 'Joan Baker',
      action: 'Invite A virtual Evening of Smooth Jazz',
      time: DateTime.now().subtract(const Duration(minutes: 20)),
      hasActions: true,
    ),
    
    
    NotificationItem(
      userName: 'Jennifer Fritz',
      action: 'Invite you International Kids Safe',
      time: DateTime.now().subtract(const Duration(days: 1, hours: 6, minutes: 50)),
      hasActions: true,
    ),
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notification',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _notifications.length,
        separatorBuilder: (context, index) => const Divider(height: 1, thickness: 1),
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return _NotificationTile(notification: notification);
        },
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final NotificationItem notification;

  const _NotificationTile({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Avatar
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: Text(
                  notification.userName.substring(0, 1),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Notification Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF333333),
                          height: 1.4,
                        ),
                        children: [
                          TextSpan(
                            text: notification.userName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: ' ${notification.action}'),
                        ],
                      ),
                    ),
                    if (notification.description != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          notification.description!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // Time
              Text(
                _formatTime(notification.time),
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF999999),
                ),
              ),
            ],
          ),
          // Action Buttons
          if (notification.hasActions)
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 52),
              child: Row(
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFE0E0E0)),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text(
                      'Reject',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4285F4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text(
                      'Accept',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

String _formatTime(DateTime time) {
  final now = DateTime.now();
  final difference = now.difference(time);

  if (difference.inMinutes < 1) return 'Just now';
  if (difference.inHours < 1) return '${difference.inMinutes} min ago';
  if (difference.inDays < 1) return '${difference.inHours} hr ago';
  if (difference.inDays == 1) return 'Yesterday';
  if (difference.inDays < 7) return DateFormat('EEE, h:mm a').format(time);
  return DateFormat('MMM d').format(time);
}

class NotificationItem {
  final String userName;
  final String action;
  final DateTime time;
  final String? description;
  final bool hasActions;

  NotificationItem({
    required this.userName,
    required this.action,
    required this.time,
    this.description,
    this.hasActions = false,
  });
}