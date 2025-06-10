import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_booking_app_ui/models/program_Model.dart';

class CourseController {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;


  // get all courses
  Stream<QuerySnapshot> getAllCourses() {
    return _firestore.collection('Courses').snapshots();
  }
// get course programs
Future<List<ProgramModel>> getAllProgram(String courseId) async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('CoursePrograms').where('courseId', isEqualTo: courseId).get();
      return querySnapshot.docs
          .map((doc) => ProgramModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      print("Error fetching programs: $e");
      return [];
    }
  }
  //
}