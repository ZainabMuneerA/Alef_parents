


import 'package:alef_parents/Features/Schedule_page/domain/entity/appointment.dart';

class AppointmentModel extends Appointment {
  AppointmentModel({
     required super.id,
    required super.applicationId,
    required super.date,
    required super.preschoolId,
    required super.time
  });

factory AppointmentModel.fromJson(Map<String, dynamic> json) {
  return AppointmentModel(
    id: json['id'],
    applicationId: json['application_id'],
    date: json['date'],
    preschoolId: json['preschool_id'],
    time: json['time'],

  );
}


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'application_id': applicationId,
      'date': date,
      'preschool_id': preschoolId,
      'time': time,
    
    };
  }
}