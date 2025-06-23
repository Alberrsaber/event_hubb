import 'package:event_booking_app_ui/controllers/category_controller.dart';
import 'package:event_booking_app_ui/controllers/event_controller.dart';
import 'package:event_booking_app_ui/controllers/user_controller.dart';
import 'package:event_booking_app_ui/models/category_model.dart';
import 'package:event_booking_app_ui/models/user_model.dart';
import 'package:event_booking_app_ui/screens/Auth/changepassword_screen.dart';
import 'package:event_booking_app_ui/screens/Settings_Screen.dart';
import 'package:event_booking_app_ui/screens/allmytickets_Screen.dart';
import 'package:event_booking_app_ui/screens/bookmarks_screen.dart';
import 'package:event_booking_app_ui/screens/edit_profile_screen.dart';
import 'package:event_booking_app_ui/my_theme.dart';
import 'package:event_booking_app_ui/screens/events_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:event_booking_app_ui/generated/l10n.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<CategoryModel> categories = [];
  UserModel? currentUser;
  final l10n = S.of(Get.context!);

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    currentUser = await UserController().fetchUserData();
    categories = await CategoryController().getCategoriesFav();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.textTheme.bodyLarge?.color,
        elevation: 0,
        centerTitle: true,
        title: Text(
          l10n.my_profile,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
        ),
      ),
      body: currentUser == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileHeader(theme),
                  const SizedBox(height: 30),
                  _buildEditButton(),
                  const SizedBox(height: 30),
                  _buildOptionsList(),
                ],
              ),
            ),
    );
  }

  Widget _buildProfileHeader(ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              currentUser!.userImage,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentUser!.userName,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                currentUser!.userEmail ?? '',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEditButton() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () => Get.to(() => EditProfileScreen()),
        icon: const Icon(Icons.edit, size: 18),
        label: Text(l10n.edit_profile),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: MyTheme.primaryColor,
          backgroundColor: MyTheme.primaryColor.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildOptionsList() {
    return Column(
      children: [
        ProfileOptionTile(
          title: l10n.change_password,
          onTap: () {
            Get.to(() => ChangePasswordScreen());
          },
        ),
        const SizedBox(height: 20),
        ProfileOptionTile(
          title: l10n.my_tickets,
          onTap: () {
            Get.to(() => AllMyTicketsPage());
          },
        ),
        const SizedBox(height: 20),
        ProfileOptionTile(
          title: l10n.bookmarks,
          onTap: () {
            Get.to(() => BookMarksScreen());
          },
        ),
        const SizedBox(height: 20),
        ProfileOptionTile(
          title: l10n.settings,
          onTap: () {
            Get.to(() => SettingsScreen());
          },
        ),
      ],
    );
  }
}

class ProfileOptionTile extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final IconData trailingIcon;

  const ProfileOptionTile({
    Key? key,
    required this.title,
    this.onTap,
    this.trailingIcon = Icons.arrow_forward_ios_rounded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
        decoration: BoxDecoration(
          color: isDark ? theme.cardColor : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isDark
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Icon(
              trailingIcon,
              size: 18,
              color: MyTheme.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}