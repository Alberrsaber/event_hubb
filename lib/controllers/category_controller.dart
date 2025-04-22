import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_booking_app_ui/models/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../models/category_model.dart';

class CategoryController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser;
  
// get category by name
  Future<CategoryModel?> getCategoryByName(String categoryName) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Categories')
          .where('name', isEqualTo: categoryName)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return CategoryModel.fromMap(querySnapshot.docs.first.data() as Map<String, dynamic>, querySnapshot.docs.first.id);
      } else {
        print("No category found with name: $categoryName");
        return null;
      }
    } catch (e) {
      print("Error fetching category: $e");
      return null;
    }
  }

// get all categories
Future<List<CategoryModel>> getAllCategories() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('Categories').get();
          

      return querySnapshot.docs
          .map((doc) => CategoryModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      print("Error fetching categories: $e");
      return [];
    }
  }
   // get event by name
  Future<List<EventModel>> getEventByCategory(String categoryName) async {
  try {
    QuerySnapshot querySnapshot = await _firestore
        .collection('Events')
        .where('eventCategory', isEqualTo: categoryName)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.map((doc) {
        return EventModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } else {
      print("No category found with name: $categoryName");
      return [];
    }
  } catch (e) {
    print("Error fetching category: $e");
    return [];
  }
}
// Get user favauite categories
Future<List<CategoryModel>> getCategoriesFav() async {
  try {
    QuerySnapshot querySnapshot = await _firestore
        .collection('Categories').where('categoryFav', arrayContains: currentUser?.uid).get();
      return querySnapshot.docs
          .map((doc) => CategoryModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();    
  }
  catch(e){
    print("Error fetching category: $e");
    return [];

  }
}

}
