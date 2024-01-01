


import 'package:alef_parents/Features/Schedule_page/domain/entity/appointment.dart';
import 'package:equatable/equatable.dart';

class Scheduled extends Equatable {
  final String message;
  final Appointment appointment;


  Scheduled(
      {required this.message,
      required this.appointment,
   
      });

  factory Scheduled.fromJson(Map<String, dynamic> json) {
    return Scheduled(
        message: json['message'],
        appointment: json['appointment'],
   
        );
  }

  @override
  List<Object?> get props => [message, appointment];
}