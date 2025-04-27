import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_booking_app_ui/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserController  {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   final currentUser = FirebaseAuth.instance.currentUser;

  Future<UserModel?> fetchUserData() async {
    try {
      DocumentSnapshot doc = await _firestore.collection('Users').doc(currentUser?.uid).get();

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
// add to faviort category
  Future<void> addCategoryFav(String userSpecialty, String userId) async {
  final querySnapshot = await _firestore
      .collection('Categories')
      .where('categoryFaculties', arrayContains: userSpecialty)
      .get();

  for (var doc in querySnapshot.docs) {
    await doc.reference.set({
      'categoryFav': FieldValue.arrayUnion([userId])
    }, SetOptions(merge: true));
  }
} 



}