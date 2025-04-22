import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_booking_app_ui/controllers/event_controller.dart';
import 'package:event_booking_app_ui/controllers/user_controller.dart';
import 'package:event_booking_app_ui/models/user_model.dart';
import 'package:event_booking_app_ui/screens/events_screen.dart';
import 'package:event_booking_app_ui/screens/faculty_courses_page.dart';
import 'package:flutter/material.dart';
import 'package:event_booking_app_ui/my_theme.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../controllers/auth_controller.dart';
import 'calendar_screen.dart';
import 'categories_screen.dart';
import 'profile_screen.dart';
import 'bookmark_screen.dart';
import 'contact_us_screen.dart';
import 'helps_faqs_screen.dart';
import 'search_Screen.dart';
import 'settings_screen.dart';
import 'profile_screen.dart';
import 'explore_screen.dart';
import 'notification_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

var controller = Get.put(AuthController());
var usercontroller = Get.put(UserController());
var eventcontroller = Get.put(EventController());
UserModel? usser;
String? searchName;

String userEmail = FirebaseAuth.instance.currentUser!.email.toString();

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool hasNotifications = false;

  @override
  void initState() {
    super.initState();
    checkNotifications();
    fetchUserDataAndSetState();
  }

  Future<void> fetchUserDataAndSetState() async {
    UserModel? currentUser = await usercontroller
        .fetchUserData(FirebaseAuth.instance.currentUser!.uid);

    setState(() {
      usser = currentUser;
    });
  }

  void checkNotifications() async {
    // Example: Fetch notifications from Firebase Firestore
    var notifications = await FirebaseFirestore.instance
        .collection('notifications')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get();

    setState(() {
      hasNotifications = notifications.docs.isNotEmpty;
    });
  }

  final List<Widget> _screens = [
    ExploreScreen(),
    CalendarScreen(),
    FacultyCoursesScreen(),
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
                controller.SignOut(context);
                // Redirect to login screen
              } catch (e) {
                print("Sign out error: $e"); // Debugging
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
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF4A43EC), // Updated to main app color
                ),
                accountName:
                    Text(usser?.userName == null ? "" : usser!.userEmail),
                accountEmail: Text(usser?.userName == null
                    ? "Please edit your profile"
                    : usser!.userName),
                currentAccountPicture: CircleAvatar(
                  backgroundImage:
                      AssetImage("assets/navigation/profile_pic.png"),
                ),
              ),
              ListTile(
                leading: Image.asset("assets/navigation/bookmark_n.png",
                    width: 24, height: 24),
                title: Text("Bookmarks"),
                onTap: () {
                  Get.to(() => EventsPage(
                        getEventStream: eventcontroller.getBookmarks(),
                      ));
                },
              ),
              ListTile(
                leading: Image.asset("assets/navigation/mail_n.png",
                    width: 24, height: 24),
                title: Text("Contact Us"),
                onTap: () => _navigateToDrawerScreen(ContactScreen()),
              ),
              ListTile(
                leading: Image.asset("assets/navigation/settings_n.png",
                    width: 24, height: 24),
                title: Text("Settings"),
                onTap: () => _navigateToDrawerScreen(SettingsScreen()),
              ),
              ListTile(
                leading: Image.asset("assets/navigation/helps_n.png",
                    width: 24, height: 24),
                title: Text("Helps & FAQs"),
                onTap: () => _navigateToDrawerScreen(HelpsScreen()),
              ),
              ListTile(
                leading: Image.asset("assets/navigation/signout_n.png",
                    width: 24, height: 24),
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
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: Image.asset('assets/images/white_logo.png',
                            fit: BoxFit.contain),
                      ),
                      Stack(
                        children: [
                          IconButton(
                            icon: Image.asset(
                                'assets/icons/notifcations_bell.png',
                                width: 30,
                                height: 30),
                            onPressed: () {
                              Get.to(() => NotificationScreen());
                            },
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Color(0xFF5669FF), // Search background color
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      onTap: () {
                        Get.to(() => SearchPage());
                      },
                      onChanged: (value) {
                        setState(() {
                          searchName = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Image.asset('assets/icons/search_icon.png',
                            width: 20, height: 20),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _screens[_selectedIndex], // Display selected screen
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFF4A43EC), // Updated to main app color
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/compass.png',
                  width: 24, height: 24),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/calendar.png',
                  width: 24, height: 24),
              label: 'Calendar',
            ),
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
              icon: Image.asset('assets/icons/profile.png',
                  width: 24, height: 24),
              label: 'Profile',
            ),
            
          ],
        ),
      ),
    );
  }
}
