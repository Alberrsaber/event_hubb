class ProgramModel {
  final String programId;
  final String courseId;
  final String programName;
  final String programTime;
  final String programType;
  final String programLocation;
  final List<String> programDate;
  ProgramModel(
      {required this.programId,
      required this.courseId,
      required this.programName,
      required this.programTime,
      required this.programType,
      required this.programLocation,
      required this.programDate});

  Map<String, dynamic> toMap() {
    return {
      'programId': programId,
      'courseId': courseId,
      'programName': programName,
      'programTime': programTime,
      'programType': programType,
      'programLocation': programLocation,
      'programDate': programDate,
    };
  }

  factory ProgramModel.fromMap(Map<String, dynamic> data, String documentId) {
    return ProgramModel(
      programId: documentId,
      courseId: data['courseId'] ?? '',
      programName: data['programName'] ?? '',
      programTime: data['programTime'] ?? '',
      programType: data['programType'] ?? '',
      programLocation: data['programLocation'] ?? '',
      programDate: List<String>.from(data['programDate'] ?? []),
    );  
  }
}
