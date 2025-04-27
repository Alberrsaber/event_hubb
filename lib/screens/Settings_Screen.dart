import 'package:event_booking_app_ui/main.dart';
import 'package:event_booking_app_ui/screens/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';  
import 'resset_password_screen.dart';


class SettingsScreen extends StatelessWidget {
  final ThemeController themeController = Get.find();  // Get the theme controller

  void _navigateToEditProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfileScreen()),
    );
  }

  void _navigateToResetPassword(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: Text('Edit Profile'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => _navigateToEditProfile(context),
            ),
            Divider(),

            ListTile(
              title: Text('Change Password'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => _navigateToResetPassword(context),
            ),
            Divider(),

            SwitchListTile(
              title: Text('Push Notifications'),
              value: true,
              onChanged: (value) {
                // Handle push notification toggle
              },
              activeColor: Colors.blue,
            ),
            Divider(),

            ListTile(
              title: Text('Language Selection'),
              subtitle: Text('English'), // You can change this dynamically
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () async {
                String? selectedLang = await showDialog<String>(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: Text('Select Language'),
                      children: [
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, 'English');
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                'icons/flags/png/gb.png',
                                package: 'country_icons',
                                width: 24,
                              ),
                              SizedBox(width: 10),
                              Text('English'),
                            ],
                          ),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, 'Arabic');
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                'icons/flags/png/sa.png',
                                package: 'country_icons',
                                width: 24,
                              ),
                              SizedBox(width: 10),
                              Text('Arabic'),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
                // Handle selectedLang value here (use GetX localization)
                if (selectedLang != null) {
                  // Set the language dynamically
                  // For example, you can use Get.updateLocale() for dynamic language change
                  Get.updateLocale(Locale(selectedLang == 'Arabic' ? 'ar' : 'en'));
                }
              },
            ),
            Divider(),

            // Dark Mode Toggle with GetX
            Obx(() {
              return SwitchListTile(
                title: Text('Dark Mode'),
                value: themeController.isDarkMode.value,
                onChanged: (value) {
                  themeController.toggleTheme();
                },
                activeColor: Colors.blue,
              );
            }),
          ],
        ),
      ),
    );
  }
}
