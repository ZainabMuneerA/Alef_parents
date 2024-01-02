import 'package:alef_parents/Features/enroll_student/domain/entity/Application.dart';
import 'package:alef_parents/Features/find_preschool/data/model/preschool_model.dart';

class ApplicationModel extends Application {
  ApplicationModel({
    required super.id,
    required super.studentName,
    required super.status,
  });

  factory ApplicationModel.fromJson(Map<String, dynamic> json) {
    return ApplicationModel(
        id: json['id'],
        studentName: json['student_name'],
        status: json['status']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_name': studentName,
      'status': status,
    };
  }
}
