import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/category_model.dart';

class CategoryController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
}
