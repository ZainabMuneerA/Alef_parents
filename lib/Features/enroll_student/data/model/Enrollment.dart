import 'package:alef_parents/Features/enroll_student/data/model/ApplicationModel.dart';

import '../../domain/entity/Enrollment.dart';

class EnrollmentModel extends Enrollment {
  EnrollmentModel({
    required super.message, 
  required super.application
  });

  factory EnrollmentModel.fromJson(Map<String, dynamic> json) {
    return EnrollmentModel(
        message: json['message'],
         application: json['application'] != null
          ? ApplicationModel.fromJson(json['application'])
          : ApplicationModel(id: 0, studentName: '', status: ''),
          
          
          
          );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message, 
    'application': application
    };
  }
}
