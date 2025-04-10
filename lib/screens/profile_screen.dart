import 'package:event_booking_app_ui/screens/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:event_booking_app_ui/my_theme.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class ProfileScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"name": "Sports", "color": Colors.red, "icon": Icons.sports_basketball},
    {"name": "Music", "color": Colors.orange, "icon": Icons.music_note},
    {"name": "Tech", "color": Colors.green, "icon": Icons.computer},
    {"name": "Art", "color": Colors.blue, "icon": Icons.brush},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
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
            const Text(
              "Ashfak Sayem",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
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
              children: categories
                  .map(
                    (cat) => Chip(
                      label: Text(
                        cat["name"],
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: cat["color"],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
