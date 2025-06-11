import 'dart:math';
import 'package:event_booking_app_ui/controllers/category_controller.dart';
import 'package:event_booking_app_ui/controllers/event_controller.dart';
import 'package:event_booking_app_ui/models/category_model.dart';
import 'package:event_booking_app_ui/screens/events_screen.dart';
import 'package:event_booking_app_ui/widgets/streambuilderwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:event_booking_app_ui/generated/l10n.dart';

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
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          SizedBox(
            height: screenHeight * 0.075,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: categoriess.map((category) {
                return CategoryChip(category);
              }).toList(),
            ),
          ),
          const SizedBox(height: 10),
          Streambuilderwidget(
            getEventStream: EventController().getAllEvents(),
            getAllEventStream: EventController().getAllEvents(),
            title: l10n.top_topics,
          ),
          const SizedBox(height: 10),
          Streambuilderwidget(
            title: l10n.upcoming_events,
            getEventStream: EventController().getEvents(),
            getAllEventStream: EventController().getEvents(),
          ),
          const SizedBox(height: 10),
          Streambuilderwidget(
            title: l10n.for_you,
            getEventStream: EventController().getForYouEvents(categoriess),
            getAllEventStream: EventController().getForYouEvents(categoriess),
          ),
          Streambuilderwidget(
            title: l10n.past_events,
            getEventStream: EventController().getpastEvents(),
            getAllEventStream: EventController().getpastEvents(),
          ),
        ],
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final CategoryModel category;
  CategoryChip(this.category);

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final color = Color.fromARGB(
      255,
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
        margin: const EdgeInsets.only(right: 4, top: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Image.network(category.categoryImage),
            const SizedBox(width: 6),
            Text(
              category.categoryName,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}