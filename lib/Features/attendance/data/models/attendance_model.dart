

import 'package:alef_parents/Features/attendance/domain/entities/attendance.dart';

class AttendanceModel extends Attendance {
  AttendanceModel({
    required super.status,
    required super.date,
  });

factory AttendanceModel.fromJson(Map<String, dynamic> json) {
  return AttendanceModel(
    status: json['attendance_status'],
    date: json['date'],
  );
}


  Map<String, dynamic> toJson() {
    return {
      'attendance_status': status,
      'date': date,
    };
  }
}