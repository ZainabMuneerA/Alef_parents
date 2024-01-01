

import 'package:alef_parents/Features/attendance/domain/entities/attendance_status.dart';

class AttendanceStatusModel extends AttendanceStatus {
  const AttendanceStatusModel({
    required super.absent,
    required super.present,
  });

factory AttendanceStatusModel.fromJson(Map<String, dynamic> json) {
  return AttendanceStatusModel(
    absent: json['Absent'],
    present: json['Present'],
  );
}


  Map<String, dynamic> toJson() {
    return {
      'Absent': absent,
      'Present': present,
    };
  }
}