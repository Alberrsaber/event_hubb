import 'package:event_booking_app_ui/main.dart';
import 'package:event_booking_app_ui/screens/Auth/resset_password_screen.dart';
import 'package:event_booking_app_ui/screens/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:event_booking_app_ui/generated/l10n.dart';

class SettingsScreen extends StatelessWidget {
  final ThemeController themeController = Get.find();

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
    // Use S.of(context) for localization
    final translations = S.of(context);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(translations.settings)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: Text(translations.edit_profile),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => _navigateToEditProfile(context),
            ),
            const Divider(),

            

            Obx(() {
              return SwitchListTile(
                title: Text(translations.push_notifications),
                value: themeController.isNotificationsEnabled.value,
                onChanged: (value) {
                  themeController.toggleNotifications(value);
                },
                activeColor: Colors.blue,
              );
            }),
            const Divider(),

            ListTile(
              title: Text(translations.language_selection),
              subtitle: Text(themeController.selectedLanguage.value == 'en' 
                  ? translations.english 
                  : translations.arabic),
              trailing: Obx(() {
                return DropdownButton<String>(
                  value: themeController.selectedLanguage.value,
                  icon: const Icon(Icons.arrow_drop_down),
                  underline: const SizedBox(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      themeController.setLanguage(newValue);
                    }
                  },
                  items: <String>['en', 'ar']
                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value == 'en' ? translations.english : translations.arabic),
                      );
                    }).toList(),
                );
              }),
            ),
            const Divider(),

            Obx(() {
              return SwitchListTile(
                title: Text(translations.dark_mode),
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