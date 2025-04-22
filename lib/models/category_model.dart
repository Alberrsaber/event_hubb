class CategoryModel {
  final String categoryId;
  final String categoryName;
  final int categoryColor;
  final String categoryImage;
  final List<String> categoryFaculties;
  final List<String> categoryFav;

  CategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
    required this.categoryColor,
    required this.categoryFaculties,
    required this.categoryFav,
  });
  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'categoryImage': categoryImage,
      'categoryColor': categoryColor,
      'categoryFaculties': categoryFaculties,
      'categoryFav': categoryFav,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> data, String documentId) {
    return CategoryModel(
      categoryId: data['categoryId'] ?? '',
      categoryName: data['categoryName'] ?? '',
      categoryImage: data['categoryImage'] ?? '',
      categoryColor: data['categoryColor'] ?? '',
      categoryFaculties: List<String>.from(data['categoryFaculties'] ?? []),
      categoryFav: List<String>.from(data['categoryFav'] ?? []),
    );
  }
}
