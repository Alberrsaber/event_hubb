import 'package:flutter/material.dart';
import 'package:event_booking_app_ui/my_theme.dart';

class CategoriesScreen extends StatelessWidget {
   CategoriesScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> _categories = [
    {"name": "Sports", "color": Colors.red, "icon": Icons.sports},
    {"name": "Music", "color": Colors.orange, "icon": Icons.music_note},
    {"name": "Tech", "color": Colors.green, "icon": Icons.computer},
    {"name": "Art", "color": Colors.blue, "icon": Icons.brush},
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            final category = _categories[index];
            return _buildCategoryCard(context, category);
          },
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, Map<String, dynamic> category) {
    return GestureDetector(
      onTap: () {
        // Navigate to events related to the selected category
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventsByCategoryScreen(category: category),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: category["color"],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: category["color"].withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            AnimatedScale(
              duration: const Duration(milliseconds: 300),
              scale: 1.2,
              child: Icon(
                category["icon"],
                color: Colors.white,
                size: 36,
              ),
            ),
            const SizedBox(width: 20),
            // Text
            Expanded(
              child: Text(
                category["name"],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventsByCategoryScreen extends StatelessWidget {
  final Map<String, dynamic> category;

   EventsByCategoryScreen({Key? key, required this.category}) : super(key: key);

  // This is just a mockup of events for the selected category.
  final List<Map<String, String>> _events = [
    {"title": "Football Championship", "location": "Stadium"},
    {"title": "Tech Conference", "location": "Conference Hall"},
    {"title": "Art Exhibition", "location": "Gallery"},
    {"title": "Rock Concert", "location": "Arena"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${category["name"]} Events'),
        backgroundColor: category["color"],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _events.length,
          itemBuilder: (context, index) {
            final event = _events[index];
            return _buildEventCard(event, context);
          },
        ),
      ),
    );
  }

  Widget _buildEventCard(Map<String, String> event, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        title: Text(event["title"]!),
        subtitle: Text(event["location"]!),
        onTap: () {
          // Handle event detail view
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Event: ${event["title"]}')),
          );
        },
      ),
    );
  }
}
