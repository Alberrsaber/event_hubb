class UserModel {
  final String userId;
  final String userName;
  final String userEmail;
  final String userPassword;
  final String userPhone;
  final String userImage;
  final String userQualification;
  final String userSpecialty;



  UserModel({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userImage,
    required this.userPassword,
    required this.userPhone,
    required this.userQualification,
    required this.userSpecialty,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'userImage': userImage,
      'userPassword': userPassword,
      'userPhone': userPhone,
      'userQualification': userQualification,
      'userSpecialty': userSpecialty,
    };
  }

  // Extract a User from a Map.
  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UserModel(
      userId: documentId,
      userName: data['userName'] ?? '',
      userEmail: data['userEmail'] ?? '',
      userImage: data['userImage'] ?? '',
      userPassword: data['userPassword'] ?? '',
      userPhone: data['userPhone'] ?? '',
      userQualification: data['userQualification'] ?? '',
      userSpecialty: data['userSpecialty'] ?? '',  
    );
  }
}