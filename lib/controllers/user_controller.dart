import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_booking_app_ui/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

class UserController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

//function to fetch user data once
  Future<UserModel?> fetchUserData() async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('Users').doc(currentUser?.uid).get();

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

//function to provide a Stream of user data updates
  Stream<UserModel?> get userStream {
    return _firestore
        .collection('Users')
        .doc(currentUser?.uid)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        return UserModel.fromMap(
            snapshot.data() as Map<String, dynamic>, snapshot.id);
      } else {
        return null;
      }
    });
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

//add favortie category
  Future<void> addinterest(String categoryId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final categoryRef = _firestore.collection('Categories').doc(categoryId);
    final categoryRefDoc = await categoryRef.get();
    final data = categoryRefDoc.data();

    if (data == null) return;

    List<dynamic> categoryFav = data['categoryFav'] ?? [];

    if (!categoryFav.contains(user.uid)) {
      categoryFav.add(user.uid);
    } else {}

    await categoryRef.update({'categoryFav': categoryFav});
  }

// update user data
  Future<void> updateUserData(UserModel updatedUser) async {
    try {
      await _firestore
          .collection('Users')
          .doc(updatedUser.userId)
          .update(updatedUser.toMap());
      print("User updated successfully");
    } catch (e) {
      print("Error updating user: $e");
    }
  }

// upload profile photo
  Future<String?> uploadProfileImage(File imageFile, String userId) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('$userId.jpg');
      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (e) {
      print("Image upload error: $e");
      return null;
    }
  }
  // send email 
  Future<void> sendEmail({
  required String name,
  required String subject,
  required String message,
}) async {
  const serviceId = 'service_kgf2jq7';
  const templateId = 'template_3q72lg7';
  const userId = '-GcndrGwz3Zj8YqpE';

  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  final response = await http.post(
    url,
    headers: {
      'origin': 'http://localhost',
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': userId,
      'template_params': {
        'name': name,
        'subject': subject,
        'message': message,
      },
    }),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to send email: ${response.body}');
  }
}
}
