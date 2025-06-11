import 'package:event_booking_app_ui/controllers/course_controller.dart';
import 'package:event_booking_app_ui/models/course_model.dart';
import 'package:event_booking_app_ui/screens/course_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:event_booking_app_ui/generated/l10n.dart';

class FacultyCoursesScreen extends StatefulWidget {
  const FacultyCoursesScreen({super.key});

  @override
  _FacultyCoursesScreenState createState() => _FacultyCoursesScreenState();
}

class _FacultyCoursesScreenState extends State<FacultyCoursesScreen> {
  final CourseController _courseController = CourseController();
  List<CourseModel> courses = [];

  DateTime selectedMonth = DateTime.now();
  bool isSortedAscending = true;

  static const List<String> englishMonths = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  List<String> localizedMonths = [];

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  void _loadCourses() {
    _courseController.getAllCourses().listen((querySnapshot) {
      setState(() {
        courses = querySnapshot.docs.map((doc) {
          return CourseModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
      });
    });
  }

  void _sortCourses(List<CourseModel> coursesList) {
    if (isSortedAscending) {
      coursesList.sort((a, b) => a.courseDate.compareTo(b.courseDate));
    } else {
      coursesList.sort((a, b) => b.courseDate.compareTo(a.courseDate));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context); // Moved inside build method
    localizedMonths = [
      l10n.january,
      l10n.february,
      l10n.march,
      l10n.april,
      l10n.may,
      l10n.june,
      l10n.july,
      l10n.august,
      l10n.september,
      l10n.october,
      l10n.november,
      l10n.december,
    ];

    // Get English month name for filtering
    final englishMonth = englishMonths[selectedMonth.month - 1];

    // Filter and sort only once
    List<CourseModel> filteredCourses = courses
        .where((course) => course.courseDate == englishMonth)
        .toList();

    _sortCourses(filteredCourses);

    final currentLocalizedMonth = localizedMonths[selectedMonth.month - 1];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          l10n.faculty_courses,
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: currentLocalizedMonth,
              onChanged: (String? newLocalizedMonth) {
                if (newLocalizedMonth != null) {
                  final monthIndex = localizedMonths.indexOf(newLocalizedMonth);
                  if (monthIndex != -1) {
                    setState(() {
                      selectedMonth = DateTime(
                        DateTime.now().year,
                        monthIndex + 1,
                        1,
                      );
                    });
                  }
                }
              },
              items: localizedMonths.map<DropdownMenuItem<String>>((String month) {
                return DropdownMenuItem<String>(
                  value: month,
                  child: Text(month),
                );
              }).toList(),
            ),
          ),
          IconButton(
            icon: Icon(
              isSortedAscending ? Icons.arrow_upward : Icons.arrow_downward,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                isSortedAscending = !isSortedAscending;
              });
            },
          ),
        ],
      ),
      body: filteredCourses.isEmpty
          ? Center(child: Text(l10n.no_courses_available))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredCourses.length,
              itemBuilder: (context, index) {
                final course = filteredCourses[index];
                return _buildCourseCard(course);
              },
            ),
    );
  }

  Widget _buildCourseCard(CourseModel course) {
    return InkWell(
      onTap: () => Get.to(() => CourseDetailsScreen(course: course)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  course.courseName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  course.courseDes,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 92, 91, 91),
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
