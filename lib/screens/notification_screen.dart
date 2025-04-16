import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Static data for notifications
  final List<NotificationItem> _notifications = [
    NotificationItem(
      sponsorName: 'David Silbia',
      eventName: 'Concert at Royal Hall',
      eventDate: DateTime.now().add(const Duration(days: 3)),
      action: 'invited you to an event',
      time: DateTime.now(),
      hasActions: true,
    ),
    NotificationItem(
      sponsorName: 'Joan Baker',
      eventName: 'Jazz Night in London',
      eventDate: DateTime.now().add(const Duration(days: 5)),
      action: 'invited you to a virtual evening',
      time: DateTime.now().subtract(const Duration(minutes: 20)),
      hasActions: true,
    ),
    NotificationItem(
      sponsorName: 'Jennifer Fritz',
      eventName: 'International Kids Safe Conference',
      eventDate: DateTime.now().add(const Duration(days: 1)),
      action: 'invited you to attend an international conference',
      time: DateTime.now().subtract(const Duration(days: 1, hours: 6, minutes: 50)),
      hasActions: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
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
    return GestureDetector(
      onTap: () {
        // Handle tap if needed
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Avatar with slight animation
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    notification.sponsorName.substring(0, 1),
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
                              text: notification.sponsorName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(text: ' ${notification.action}'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          '${notification.eventName} - ${DateFormat('EEE, MMM d, yyyy').format(notification.eventDate)}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF555555),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Time with animation
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF999999),
                  ),
                  child: Text(
                    _formatTime(notification.time),
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
                    OutlinedButton.icon(
                      onPressed: () {
                        // View event details action
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFE0E0E0)),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // Larger radius
                        ),
                      ),
                      icon: const Icon(Icons.event, color: Color(0xFF333333)),
                      label: const Text(
                        'View Event',
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Register action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4A43EC), // Primary color
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // Larger radius
                        ),
                      ),
                      icon: const Icon(Icons.check, color: Colors.white),
                      label: const Text(
                        'Register',
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
  final String sponsorName;
  final String eventName;
  final DateTime eventDate;
  final String action;
  final DateTime time;
  final bool hasActions;

  NotificationItem({
    required this.sponsorName,
    required this.eventName,
    required this.eventDate,
    required this.action,
    required this.time,
    this.hasActions = false,
  });
}
