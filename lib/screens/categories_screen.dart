import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:event_booking_app_ui/controllers/category_controller.dart';
import 'package:event_booking_app_ui/models/category_model.dart';
import 'package:event_booking_app_ui/models/event_model.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final categoryController = Get.put(CategoryController());
  List<CategoryModel> categoriess = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    categoriess = await categoryController.getAllCategories();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 150,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: categoriess.length,
          itemBuilder: (context, index) {
            final category = categoriess[index];
            return _buildCategoryCard(context, category);
          },
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, CategoryModel category) {
    return GestureDetector(
      onTap: () {
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
        child: Column(
          children: [
            AnimatedScale(
              duration: const Duration(milliseconds: 300),
              scale: 1.2,
              child: Image.network(category.categoryImage),
            ),
            const SizedBox(width: 40),
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
  final CategoryModel category;

  EventsByCategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<EventsByCategoryScreen> createState() =>
      _EventsByCategoryScreenState();
}

class _EventsByCategoryScreenState extends State<EventsByCategoryScreen> {
  List<EventModel> eventss = [];

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    eventss = await CategoryController()
        .getEventByCategory(widget.category.categoryName);
    if (mounted) {
      setState(() {});
    }
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
        child: eventss.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: eventss.length,
                itemBuilder: (context, index) {
                  final event = eventss[index];
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Event: ${event.eventName}')),
          );
        },
      ),
    );
  }
}
