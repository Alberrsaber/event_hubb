import 'package:event_booking_app_ui/controllers/category_controller.dart';
import 'package:event_booking_app_ui/models/category_model.dart';
import 'package:event_booking_app_ui/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:event_booking_app_ui/my_theme.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final List<Map<String, dynamic>> _categories = [
    {"name": "Sports", "color": Colors.red, "icon": Icons.sports},
    {"name": "Music", "color": Colors.orange, "icon": Icons.music_note},
    {"name": "Tech", "color": Colors.green, "icon": Icons.computer},
    {"name": "Art", "color": Colors.blue, "icon": Icons.brush},
  ];

  var categoryController = Get.put(CategoryController());

  List<CategoryModel> categoriess = [];

  Future<void> fetchCategories() async {
    categoriess = await categoryController.getAllCategories();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: categoriess.length,
          itemBuilder: (context, index) {
            CategoryModel category = categoriess[index];
            return _buildCategoryCard(context, category);
          },
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, CategoryModel category) {
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
          color: Color(category.categoryColor),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Color(category.categoryColor).withOpacity(0.3),
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
              child: Image.network(category.categoryImage),
            ),
            const SizedBox(width: 20),
            // Text
            Expanded(
              child: Text(
                category.categoryName,
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

class EventsByCategoryScreen extends StatefulWidget {
  CategoryModel category;

  EventsByCategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<EventsByCategoryScreen> createState() => _EventsByCategoryScreenState();
}



class _EventsByCategoryScreenState extends State<EventsByCategoryScreen> {
  // This is just a mockup of events for the selected category.
  final List<Map<String, String>> _events = [
    {"title": "Football Championship", "location": "Stadium"},
    {"title": "Tech Conference", "location": "Conference Hall"},
    {"title": "Art Exhibition", "location": "Gallery"},
    {"title": "Rock Concert", "location": "Arena"},
  ];
  List<EventModel> eventss = [];
  @override
void initState() {
  super.initState();
  fetchCategories();
}
  Future<void> fetchCategories() async {
   eventss =
      await CategoryController().getEventByCategory(widget.category.categoryName);
      setState(() {});
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category.categoryName} Events'),
        backgroundColor: Color(widget.category.categoryColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: eventss.length,
          itemBuilder: (context, index) {
            EventModel event = eventss[index];
            return _buildEventCard(event, context);
          },
        ),
      ),
    );
  }

  Widget _buildEventCard(EventModel event, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        title: Text(event.eventName),
        subtitle: Text(event.eventLocation),
        onTap: () {
          // Handle event detail view
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Event: ${event.eventName}')),
          );
        },
      ),
    );
  }
}
