import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_booking_app_ui/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> fetchUserData(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('Users').doc(userId).get();

      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      } else {
        print("User  not found");
        return null;
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }
}