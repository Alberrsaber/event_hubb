import 'dart:math';
import 'package:event_booking_app_ui/controllers/category_controller.dart';
import 'package:event_booking_app_ui/controllers/event_controller.dart';
import 'package:event_booking_app_ui/models/category_model.dart';
import 'package:event_booking_app_ui/screens/events_screen.dart';
import 'package:event_booking_app_ui/widgets/streambuilderwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreScreen extends StatefulWidget {
  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<CategoryModel> categoriess = [];

  @override
  void initState() {
    super.initState();
    fetchFavCategories();
  }

  Future<void> fetchFavCategories() async {
    categoriess = await CategoryController().getCategoriesFav();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: screenHeight * 0.075,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: categoriess.map((category) {
                return CategoryChip(category);
              }).toList(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Streambuilderwidget(getEventStream:  EventController().getAllEvents(), getAllEventStream: EventController().getAllEvents(), title: "Top Topic",),
          SizedBox(
            height: 10,
          ),
          // Upcoming Events Section
          Streambuilderwidget(
            title: "Upcoming events",
            getEventStream: EventController().getEvents(),
            getAllEventStream: EventController().getEvents(),
          ),
          SizedBox(
            height: 10,
          ),
            SizedBox(
            height: 10,
          ),
          Streambuilderwidget(
            title: "For You ",
            getEventStream: EventController().getForYouEvents(categoriess),
            getAllEventStream: EventController().getForYouEvents(categoriess),

          ),
          Streambuilderwidget(
            title: "Past events",
            getEventStream: EventController().getpastEvents(),
            getAllEventStream: EventController().getpastEvents(),

          ),
        

          // Category Filters
        ],
      ),
    );
  }
}



// Category Chip Widget
class CategoryChip extends StatelessWidget {
  final CategoryModel category;
  CategoryChip(this.category);

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final color = Color.fromARGB(
      255, // fully opaque
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
    return InkWell(
      onTap: () {
        Get.to(() => EventsPage(
              getEventStream:
                  EventController().getEventsbyCategory(category.categoryName),
            ));
      },
      child: Container(
        margin: EdgeInsets.only(
          right: 4,
          top: 4,
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Image.network(category.categoryImage),
            SizedBox(width: 6),
            Text(
              category.categoryName,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
