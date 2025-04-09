import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_booking_app_ui/controllers/event_controller.dart';
import 'package:event_booking_app_ui/models/event_model.dart';
import 'package:event_booking_app_ui/screens/eventDetails_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreScreen extends StatelessWidget {
  var eventController = Get.put(EventController());

  final List<Map<String, dynamic>> categories = [
    {"name": "Sports", "color": Colors.red, "icon": Icons.sports_basketball},
    {"name": "Music", "color": Colors.orange, "icon": Icons.music_note},
    {"name": "Tech", "color": Colors.green, "icon": Icons.computer},
    {"name": "Art", "color": Colors.blue, "icon": Icons.brush},
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
                    SizedBox(height: 15,),
          SizedBox(
            height: screenHeight * 0.06,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: categories.map((category) {
                return CategoryChip(category);
              }).toList(),
            ),
          ),
          SizedBox(height: 10,),
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
            height: screenHeight * 0.6,
            width: screenWidth, // Event card height
            child: StreamBuilder<QuerySnapshot>(
              stream: eventController.getEvents(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No events found'));
                } else {
                  List<EventModel> events = snapshot.data!.docs.map((doc) {
                    return EventModel.fromMap(
                        doc.data() as Map<String, dynamic>, doc.id);
                  }).toList();
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      EventModel event = events[index];
                      return EventCard(event);
                    },
                  );
                }
              },
            ),
          ),
      
          // Category Filters
        ],
      ),
    );
  }
}

// Event Card Widget
class EventCard extends StatelessWidget {
  EventModel event;
  EventCard(this.event);

  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: (){
        Get.to(() => EventDetails(event: event,));
      },
      child: Container(
        width: screenWidth * 0.9,
        margin: EdgeInsets.only(right: 6, left: 6,bottom: 20,),
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
              child: Image.network(
                event.eventImage,
                height: screenWidth * 0.5,
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
                    event.eventBegDate,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  SizedBox(height: 5),
                  Text(
                    event.eventName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 2, // Allows wrapping instead of overflow
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 14, color: Colors.grey),
                      SizedBox(width: 4),
                      Expanded(
                        // Prevents text overflow
                        child: Text(
                          event.eventLocation,
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
      margin: EdgeInsets.only(right: 4,top: 4,),
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
