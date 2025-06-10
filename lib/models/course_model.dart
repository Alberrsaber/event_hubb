class CourseModel {
  final String courseDate;
  final String courseDes;
  final String courseId;
  final String courseName;
  final List<String> courseNotes;

  CourseModel({
    required this.courseDate,
    required this.courseDes,
    required this.courseId,
    required this.courseName,
    required this.courseNotes,
  });

  // Convert model to JSON for Firestore
  Map<String, dynamic> toMap() {
    return {
      'courseDate': courseDate, // Firestore can store DateTime directly
      'courseDes': courseDes,
      'courseId': courseId,
      'courseName': courseName,
      'courseNotes': courseNotes,
    };
  }

  // Create model from Firestore Map
  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      courseDate: map['courseDate']?? '', // Convert Timestamp to DateTime
      courseDes: map['courseDes'] ?? '',
      courseId: map['courseId'] ?? '',
      courseName: map['courseName'] ?? '',
      courseNotes: List<String>.from(map['courseNotes'] ?? []),
    );
  }

  // Helper method to create a copy with updated values
  CourseModel copyWith({
    String? courseDate,
    String? courseDes,
    String? courseId,
    String? courseName,
    List<String>? courseNotes,
  }) {
    return CourseModel(
      courseDate: courseDate ?? this.courseDate,
      courseDes: courseDes ?? this.courseDes,
      courseId: courseId ?? this.courseId,
      courseName: courseName ?? this.courseName,
      courseNotes: courseNotes ?? this.courseNotes,
    );
  }
}