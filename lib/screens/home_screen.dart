import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_booking_app_ui/controllers/event_controller.dart';
import 'package:event_booking_app_ui/controllers/user_controller.dart';
import 'package:event_booking_app_ui/models/user_model.dart';
import 'package:event_booking_app_ui/screens/events_screen.dart';
import 'package:event_booking_app_ui/screens/faculty_courses_page.dart';
import 'package:flutter/material.dart';
import 'package:event_booking_app_ui/my_theme.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import 'calendar_screen.dart';
import 'categories_screen.dart';
import 'profile_screen.dart';
import 'contact_us_screen.dart';
import 'helps_faqs_screen.dart';
import 'search_screen.dart';
import 'settings_screen.dart';
import 'explore_screen.dart';
import 'notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

UserModel? usser;

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool hasNotifications = false;

  final List<Widget> facultyScreens = [
    ExploreScreen(),
    CalendarScreen(),
    FacultyCoursesScreen(),
    CategoriesScreen(),
    ProfileScreen(),
  ];

  final List<Widget> studentScreens = [
    ExploreScreen(),
    CalendarScreen(),
    CategoriesScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToDrawerScreen(Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  void _signOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Sign Out"),
        content: Text("Are you sure you want to sign out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              try {
                AuthController().signOut(context);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error signing out: $e")),
                );
              }
            },
            child: Text("Sign Out"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<UserModel?>(
        stream: UserController().userStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
          } else {
            final UserModel? user = snapshot.data;
            final bool isStudent = user?.userQualification == 'Student';

            final currentScreens = isStudent ? studentScreens : facultyScreens;
            if (_selectedIndex >= currentScreens.length) {
  _selectedIndex = 0; // Reset to prevent RangeError
}

            return Scaffold(
              drawer: Drawer(
                child: Column(
                  children: [
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(color: Color(0xFF4A43EC)),
                      accountName: Text(user?.userName ?? "Please edit your profile"),
                      accountEmail: Text(user?.userEmail ?? ""),
                      currentAccountPicture: CircleAvatar(
                        backgroundImage: NetworkImage(user?.userImage ??
                            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
                      ),
                    ),
                    ListTile(
                      leading: Image.asset("assets/navigation/bookmark_n.png", width: 24, height: 24),
                      title: Text("Bookmarks"),
                      onTap: () {
                        Get.to(() => EventsPage(
                            getEventStream: EventController().getBookmarks()));
                      },
                    ),
                    ListTile(
                      leading: Image.asset("assets/navigation/mail_n.png", width: 24, height: 24),
                      title: Text("Contact Us"),
                      onTap: () => _navigateToDrawerScreen(ContactScreen()),
                    ),
                    ListTile(
                      leading: Image.asset("assets/navigation/settings_n.png", width: 24, height: 24),
                      title: Text("Settings"),
                      onTap: () => _navigateToDrawerScreen(SettingsScreen()),
                    ),
                    ListTile(
                      leading: Image.asset("assets/navigation/helps_n.png", width: 24, height: 24),
                      title: Text("Helps & FAQs"),
                      onTap: () => _navigateToDrawerScreen(HelpsScreen()),
                    ),
                    ListTile(
                      leading: Image.asset("assets/navigation/signout_n.png", width: 24, height: 24),
                      title: Text("Sign Out"),
                      onTap: () => _signOut(context),
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: MyTheme.primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Builder(
                              builder: (context) => IconButton(
                                icon: Image.asset('assets/icons/navigation_icon.png',
                                    width: 30, height: 30),
                                onPressed: () => Scaffold.of(context).openDrawer(),
                              ),
                            ),
                            Image.asset('assets/images/white_logo.png', height: 50),
                            Stack(
                              children: [
                                IconButton(
                                  icon: Image.asset(
                                      'assets/icons/notifcations_bell.png',
                                      width: 30,
                                      height: 30),
                                  onPressed: () => Get.to(() => NotificationScreen()),
                                ),
                                if (hasNotifications)
                                  Positioned(
                                    right: 8,
                                    top: 8,
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            Get.to(() => SearchPage());
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: Color(0xFF5669FF),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Row(
                              children: [
                                Image.asset('assets/icons/search_icon.png',
                                    width: 20, height: 20),
                                SizedBox(width: 12),
                                Text(
                                  'Search...',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: currentScreens[_selectedIndex]),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _selectedIndex,
                selectedItemColor: Color(0xFF4A43EC),
                unselectedItemColor: Colors.grey,
                onTap: _onItemTapped,
                items: [
                  BottomNavigationBarItem(
                    icon: Image.asset('assets/icons/compass.png', width: 24, height: 24),
                    label: 'Explore',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset('assets/icons/calendar.png', width: 24, height: 24),
                    label: 'Calendar',
                  ),
                  if (!isStudent)
                    BottomNavigationBarItem(
                      icon: Icon(Icons.school),
                      label: 'Faculty',
                    ),
                  BottomNavigationBarItem(
                    icon: Image.asset('assets/icons/categories_icon.png',
                        width: 24, height: 24),
                    label: 'Categories',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset('assets/icons/profile.png', width: 24, height: 24),
                    label: 'Profile',
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
