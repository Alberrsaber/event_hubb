import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  final List<Map<String, String>> events = [
    {
      "date": "10\nJUNE",
      "title": "International Band Mu...",
      "location": "36 Guild Street London, UK",
      "image": "assets/images/event1.png",
    },
    {
      "date": "10\nJUNE",
      "title": "Jo Malone London’s...",
      "location": "Radius Gallery San Francisco",
      "image": "assets/images/event2.png",
    },
  ];

  final List<Map<String, dynamic>> categories = [
    {"name": "Sports", "color": Colors.red, "icon": Icons.sports_basketball},
    {"name": "Music", "color": Colors.orange, "icon": Icons.music_note},
    {"name": "Tech", "color": Colors.green, "icon": Icons.computer},
    {"name": "Art", "color": Colors.blue, "icon": Icons.brush},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Upcoming Events Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Upcoming Events",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("See All >"),
                ),
              ],
            ),
            SizedBox(
              height: 220, // Event card height
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return EventCard(events[index]);
                },
              ),
            ),

            SizedBox(height: 20),

            // Category Filters
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: categories.map((category) {
                  return CategoryChip(category);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Event Card Widget
class EventCard extends StatelessWidget {
  final Map<String, String> event;
  EventCard(this.event);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              event["image"]!,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event["date"]!,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
                SizedBox(height: 5),
                Text(
                  event["title"]!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 2, // Allows wrapping instead of overflow
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: Colors.grey),
                    SizedBox(width: 4),
                    Expanded( // Prevents text overflow
                      child: Text(
                        event["location"]!,
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                        maxLines: 1, 
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// Category Chip Widget
class CategoryChip extends StatelessWidget {
  final Map<String, dynamic> category;
  CategoryChip(this.category);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: category["color"],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(category["icon"], color: Colors.white, size: 16),
          SizedBox(width: 6),
          Text(
            category["name"],
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
