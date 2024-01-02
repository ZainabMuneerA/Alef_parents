import 'dart:convert';
import 'dart:io';

class ApplicationRequest {
  final String email;
  final int preschoolId;
  final String guardianType;
  final String studentName;
  final String guardianName;
  final int studentCPR;
  final String gender;
  final String grade;
  final String phone;
  final DateTime studentDOB;
  final String medicalHistory;
  final int createdBy;
  // Fields for file paths or other information related to the files
  final File personalPicturePath;
  final File certificateOfBirthPath;
  final File passportPath;

  ApplicationRequest({
    required this.email,
    required this.preschoolId,
    required this.guardianType,
    required this.studentName,
    required this.guardianName,
    required this.studentCPR,
    required this.gender,
    required this.grade,
    required this.phone,
    required this.studentDOB,
    required this.medicalHistory,
    required this.createdBy,
    required this.personalPicturePath,
    required this.certificateOfBirthPath,
    required this.passportPath,
  });

   Map<String, dynamic> toJson() {
    String base64String(File file) {
      List<int> fileBytes = file.readAsBytesSync();
      return base64Encode(fileBytes);
    }

    return {
      'email': email.toString(),
      'preschool_id': preschoolId,
      'guardian_type': guardianType.toString(),
      'student_name': studentName.toString(),
      'guardian_name': guardianName.toString(),
      'student_CPR': studentCPR,
      'gender': gender.toString(),
      'grade': grade.toString(),
      'phone': phone,
      'student_DOB': studentDOB.toIso8601String(),
      'medical_history': medicalHistory.toString(),
      'created_by': createdBy,
      'personal_picture': base64String(personalPicturePath),
      'certificate_of_birth': base64String(certificateOfBirthPath),
      'passport': base64String(passportPath),
    };
  }
   String toJsonString() {
    return jsonEncode(toJson());
  }
}