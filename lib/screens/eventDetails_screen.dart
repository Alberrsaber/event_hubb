import 'package:event_booking_app_ui/models/event_model.dart';
import 'package:event_booking_app_ui/controllers/event_controller.dart';
import 'package:event_booking_app_ui/screens/ticket_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:event_booking_app_ui/generated/l10n.dart';

class EventDetails extends StatefulWidget {
  final EventModel event;
  const EventDetails({super.key, required this.event});

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  late bool isBookmarked;
  final currentUser = FirebaseAuth.instance.currentUser;
  final l10n = S.of(Get.context!);

  @override
  void initState() {
    super.initState();
    isBookmarked = widget.event.eventBookmarks.contains(currentUser?.uid);
  }

  void _toggleBookmark() async {
    await EventController().toggleBookmark(widget.event.eventId);
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          // Event image and buttons
          Stack(
            children: [
              SizedBox(
                width: screenWidth,
                height: screenHeight * 0.42,
                child: Hero(
                  tag: event.eventImage,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(28),
                      bottomRight: Radius.circular(28),
                    ),
                    child: Image.network(
                      event.eventImage,
                      fit: BoxFit.fill,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.broken_image,
                              size: 40, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _circleIconButton(context, Icons.arrow_back, () {
                        Navigator.of(context).pop();
                      }),
                      _circleIconButton(
                        context,
                        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                        _toggleBookmark,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Event content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.eventName,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(height: 8),
                  Divider(color: Theme.of(context).dividerColor),
                  const SizedBox(height: 20),
                  _infoRow(
                    icon: Icons.calendar_month_rounded,
                    title: DateFormat('MMM dd, yyyy').format(event.eventDates[0]),
                    subtitle:
                        '${DateFormat('EEEE, h:mm a').format(event.eventDates[0])} - ${DateFormat('h:mm a').format(event.eventDates.last)}',
                  ),
                  const SizedBox(height: 16),
                  _infoRow(
                    icon: Icons.location_on_rounded,
                    title: event.eventLocation,
                    subtitle: l10n.location,
                  ),
                  const SizedBox(height: 16),
                  _infoRow(
                    icon: Icons.account_circle_rounded,
                    title: event.eventSponser,
                    subtitle: l10n.organizer,
                  ),
                  const SizedBox(height: 30),
                  Text(l10n.about,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(height: 12),
                  Text(
                    event.eventDes,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.6),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom CTA
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context).cardColor
              : Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: ElevatedButton(
          onPressed: event.eventDates.last.isBefore(DateTime.now())
              ? null // disables the button
              : () {
                  Get.to(() => TicketScreen(event: event));
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: event.eventDates.last.isBefore(DateTime.now())
                ? Colors.grey // disabled color
                : const Color(0xFF5568FE),
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: Text(
            event.eventDates.last.isBefore(DateTime.now())
                ? l10n.event_ended.toUpperCase()
                : l10n.book_ticket.toUpperCase(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _circleIconButton(
      BuildContext context, IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.black45,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blueAccent.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 24, color: Colors.blueAccent),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  )),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }
}