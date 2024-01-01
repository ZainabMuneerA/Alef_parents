import '../../domain/entity/EnrollmentStatus.dart';
import 'preschooNameModel.dart';

class EnrollmentStatusModel extends EnrollmentStatus {
  EnrollmentStatusModel(
      {required super.studentName,
      required super.enrollmentStatus,
      required super.preschool});

  factory EnrollmentStatusModel.fromJson(Map<String, dynamic> json) {
    return EnrollmentStatusModel(
      studentName: json['student_name'],
      enrollmentStatus: json['status'],
      preschool: json['Preschool'] != null
          ? PreschoolNameModel.fromJson(json['Preschool'])
          : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'student_name': studentName,
      'status': enrollmentStatus,
      'Preschool': preschool?.toJson(),
    };
  }
}
