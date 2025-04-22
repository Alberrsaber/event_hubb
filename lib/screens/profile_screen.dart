import 'package:event_booking_app_ui/controllers/category_controller.dart';
import 'package:event_booking_app_ui/controllers/user_controller.dart';
import 'package:event_booking_app_ui/models/category_model.dart';
import 'package:event_booking_app_ui/models/user_model.dart';
import 'package:event_booking_app_ui/screens/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:event_booking_app_ui/my_theme.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  
  var usercontroller = Get.put(UserController());
  var categorycontroller = Get.put(CategoryController());
  List<CategoryModel> categories = [];
  UserModel? currentUser;

  @override
  void initState() {
    super.initState();
    fetchFavCategories();
    fetchUserData();
  }

  Future<void> fetchFavCategories() async {
    categories = await categorycontroller.getCategoriesFav();
    setState(() {});
  }

  Future<void> fetchUserData() async {
    currentUser = await usercontroller.fetchUserData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  "https://i.imgur.com/BoN9kdC.png", // Replace with real image
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              currentUser?.userName == null ? "" : currentUser!.userName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),

            // Edit Profile button
            OutlinedButton.icon(
              onPressed: () {Get.to(() =>EditProfileScreen());},
              icon: const Icon(Icons.edit, color: MyTheme.primaryColor),
              label: const Text(
                'Edit Profile',
                style: TextStyle(
                    color: MyTheme.primaryColor, fontWeight: FontWeight.w500),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: MyTheme.primaryColor, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 14),
              ),
            ),

            const SizedBox(height: 30),

            // About Me section
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "About Me",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Enjoy your favorite dish and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase.",
              style: TextStyle(fontSize: 15, color: Colors.black87),
            ),
            const SizedBox(height: 30),

            // Interests Section
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Interests",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
  spacing: 12,
  runSpacing: 12,
  children: categories.map((cat) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Color(cat.categoryColor),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(cat.categoryColor).withOpacity(0.3),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(cat.categoryImage),
          const SizedBox(width: 8),
          Text(
            cat.categoryName,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }).toList(),
),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
