import 'package:event_booking_app_ui/controllers/course_controller.dart';
import 'package:event_booking_app_ui/models/course_model.dart';
import 'package:event_booking_app_ui/screens/course_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class FacultyCoursesScreen extends StatefulWidget {
  FacultyCoursesScreen({super.key});

  @override
  _FacultyCoursesScreenState createState() => _FacultyCoursesScreenState();
}

class _FacultyCoursesScreenState extends State<FacultyCoursesScreen> {
  final CourseController _courseController = CourseController();
  List<CourseModel> courses = [];

  DateTime selectedMonth = DateTime.now();
  bool isSortedAscending = true;

  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  String selectedMonthString = DateFormat('MMMM').format(DateTime.now());

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
    setState(() {
      if (isSortedAscending) {
        coursesList.sort((a, b) => a.courseDate.compareTo(b.courseDate));
      } else {
        coursesList.sort((a, b) => b.courseDate.compareTo(a.courseDate));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Filter courses by selected month
    List<CourseModel> filteredCourses = courses.where((course) {
      return course.courseDate == selectedMonthString;
    }).toList();

    // Sort the filtered courses
    _sortCourses(filteredCourses);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Faculty Courses',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedMonthString,
              onChanged: (String? newMonth) {
                setState(() {
                  selectedMonthString = newMonth!;
                  selectedMonth = DateTime(DateTime.now().year,
                      months.indexOf(selectedMonthString) + 1, 1);
                });
              },
              items: months.map<DropdownMenuItem<String>>((String month) {
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
                _sortCourses(filteredCourses);
              });
            },
          ),
        ],
      ),
      body: filteredCourses.isEmpty
          ? Center(child: Text('No courses available for this month.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredCourses.length,
              itemBuilder: (context, index) {
                final course = filteredCourses[index];

                return InkWell(
                  onTap: () {
                    Get.to(() => CourseDetailsScreen(course: course,));
                  },
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
                    child: Row(
                      children: [
                        Expanded(
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
                                Row(
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          course
                                              .courseDes, // Using description as location
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 92, 91, 91),
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
