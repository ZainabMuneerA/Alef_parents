import 'package:alef_parents/Features/User_Profile/domain/entity/student.dart';

class StudentModel extends Student {
  StudentModel(
      {required super.id,
      required super.preschoolId,
      required super.name,
      required super.grade,
      required super.userID,
      required super.classID
      });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'],
      preschoolId: json['preschool_id'],
      name: json['student_name'],
      grade: json['grade'],
      userID: json['user_id'],
      classID: json['class_id']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': id,
      'createdUser': preschoolId,
      'student_name': name,
      'grade': grade,
      'user_id': userID,
      'class_id': classID
    };
  }
}
