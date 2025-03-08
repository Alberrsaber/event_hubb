import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../my_theme.dart';

class EventItem extends StatelessWidget {
  final EventModel eventModel;

  const EventItem({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eventModel.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.location_on, color: MyTheme.grey, size: 16),
                const SizedBox(width: 5),
                Text(eventModel.address, style: const TextStyle(color: MyTheme.grey)),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.people, color: MyTheme.customBlue, size: 16),
                const SizedBox(width: 5),
                Text("${eventModel.going} Attending"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
