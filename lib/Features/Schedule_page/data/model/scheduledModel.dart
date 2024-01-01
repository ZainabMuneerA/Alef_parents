

import 'package:alef_parents/Features/Schedule_page/domain/entity/appointment.dart';
import 'package:alef_parents/Features/Schedule_page/domain/entity/scheduled.dart';

class ScheduledModel extends Scheduled {
  ScheduledModel({
    required super.message,
    required super.appointment,
  });

factory ScheduledModel.fromJson(Map<String, dynamic> json) {
  return ScheduledModel(
    message: json['message'],
    appointment: Appointment.fromJson(json['appointment']),
  );
}


  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'appointment': appointment,
    };
  }
}
