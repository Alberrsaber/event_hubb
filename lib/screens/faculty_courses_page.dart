import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FacultyCoursesScreen extends StatefulWidget {
  FacultyCoursesScreen({super.key});

  @override
  _FacultyCoursesScreenState createState() => _FacultyCoursesScreenState();
}

class _FacultyCoursesScreenState extends State<FacultyCoursesScreen> {
  // قائمة الدورات الافتراضية
  final List<CourseModel> courses = [
    CourseModel(
      name: "Advanced AI for Research",
      location: "Faculty of Computer Science",
      image:
          "https://images.unsplash.com/photo-1581090700227-1e8e99f04c9a",
      begDate: DateTime(2025, 5, 12),
    ),
    CourseModel(
      name: "Data Visualization & Analysis",
      location: "Faculty of Engineering",
      image:
          "https://images.unsplash.com/photo-1555066931-4365d14bab8c",
      begDate: DateTime(2025, 5, 20),
    ),
    CourseModel(
      name: "Cybersecurity for Postgraduates",
      location: "IT Department - Cairo Campus",
      image:
          "https://images.unsplash.com/photo-1607083206559-4eac6f3fa223",
      begDate: DateTime(2025, 6, 1),
    ),
    CourseModel(
      name: "Introduction to Quantum Computing",
      location: "Faculty of Computer Science",
      image:
          "https://images.unsplash.com/photo-1596495577880-b429b28911f4",
      begDate: DateTime(2025, 7, 15),
    ),
    CourseModel(
      name: "Deep Learning for Vision Systems",
      location: "Faculty of Engineering",
      image:
          "https://images.unsplash.com/photo-1615854968817-6de1187ab6b9",
      begDate: DateTime(2025, 8, 22),
    ),
    CourseModel(
      name: "Blockchain for Advanced Applications",
      location: "Faculty of Business",
      image:
          "https://images.unsplash.com/photo-1611561062527-58aab1ebad9f",
      begDate: DateTime(2025, 9, 5),
    ),
    CourseModel(
      name: "Robotics and AI Integration",
      location: "Faculty of Engineering",
      image:
          "https://images.unsplash.com/photo-1577989042752-388fc6bdf846",
      begDate: DateTime(2025, 10, 12),
    ),
    CourseModel(
      name: "Data Ethics and Privacy",
      location: "Faculty of Law",
      image:
          "https://images.unsplash.com/photo-1611861162671-0b318cfc2f8b",
      begDate: DateTime(2025, 11, 1),
    ),
    CourseModel(
      name: "Smart Cities and IoT",
      location: "Faculty of Engineering",
      image:
          "https://images.unsplash.com/photo-1593586791974-0bda022c79e4",
      begDate: DateTime(2025, 12, 18),
    ),
  ];

  // الشهر المحدد من قبل المستخدم
  DateTime selectedMonth = DateTime.now();
  // ترتيب الدورات
  bool isSortedAscending = true;

  // قائمة الأشهر للاختيار منها
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

  // الشهر الذي تم اختياره
  String selectedMonthString = DateFormat('MMMM').format(DateTime.now());

  // دالة لترتيب الدورات
  void _sortCourses() {
    setState(() {
      if (isSortedAscending) {
        courses.sort((a, b) => a.begDate.compareTo(b.begDate)); // ترتيب من الأقرب للأبعد
      } else {
        courses.sort((a, b) => b.begDate.compareTo(a.begDate)); // ترتيب من الأبعد للأقرب
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // تصفية الدورات حسب الشهر
    List<CourseModel> filteredCourses = courses.where((course) {
      return DateFormat('MMMM').format(course.begDate) == selectedMonthString &&
          course.begDate.year == selectedMonth.year;
    }).toList();

    // ترتيب الدورات حسب التفضيل
    _sortCourses();

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
          // Dropdown لاختيار الشهر
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedMonthString,
              onChanged: (String? newMonth) {
                setState(() {
                  selectedMonthString = newMonth!;
                  selectedMonth = DateTime(DateTime.now().year, months.indexOf(selectedMonthString) + 1, 1); // تعيين الشهر
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
          // زر التبديل بين ترتيب من الأقرب للأبعد أو العكس
          IconButton(
            icon: Icon(
              isSortedAscending ? Icons.arrow_upward : Icons.arrow_downward,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                isSortedAscending = !isSortedAscending;
                _sortCourses(); // إعادة ترتيب الدورات بعد التبديل
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
                    // هنا تقدر تضيف تفاصيل الكورس أو نافذة جديدة
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
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                          ),
                          child: Image.network(
                            course.image,
                            width: screenWidth * 0.32,
                            height: 140,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              width: screenWidth * 0.32,
                              height: 140,
                              color: Colors.grey[200],
                              child: const Icon(Icons.broken_image,
                                  size: 32, color: Colors.grey),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  DateFormat('MMM dd, yyyy').format(course.begDate),
                                  style: const TextStyle(
                                    color: Color(0xFF5568FE),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  course.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on_outlined,
                                        size: 16, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        course.location,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 13.5),
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

// نموذج الكورس
class CourseModel {
  final String name;
  final String location;
  final String image;
  final DateTime begDate;

  CourseModel({
    required this.name,
    required this.location,
    required this.image,
    required this.begDate,
  });
}
