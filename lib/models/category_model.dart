class CategoryModel {
  final String categoryId;
  final String categoryName;
  final String categoryImage;
  final String categoryQualification;

  CategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
    required this.categoryQualification,
  });
  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'categoryImage': categoryImage,
      'categoryQualification': categoryQualification,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> data, String documentId) {
    return CategoryModel(
      categoryId: data['categoryId'] ?? '',
      categoryName: data['categoryName'] ?? '',
      categoryImage: data['categoryImage'] ?? '',
      categoryQualification: data['categoryQualification'] ?? '',
    );
  }
}
