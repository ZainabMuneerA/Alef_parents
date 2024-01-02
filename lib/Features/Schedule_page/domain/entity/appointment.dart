import 'package:equatable/equatable.dart';

class Appointment extends Equatable {
  final int id;
  final int applicationId;
  final String date;
  final int preschoolId;
  final String time;

  Appointment(
      {required this.id,
      required this.applicationId,
      required this.date,
      required this.preschoolId,
      required this.time});

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
        id: json['id'],
        applicationId: json['application_id'],
        date: json['date'],
        preschoolId: json['preschool_id'],
        time: json['time']);
  }

  @override
  List<Object?> get props => [id, applicationId, date, preschoolId, time];
}





//  "appointment": {
//         "id": 15,
//         "application_id": 64,
//         "date": "2023-12-03T00:00:00.000Z",
//         "preschool_id": 2,
//         "time": "08:00",
//         "updatedAt": "2023-12-02T20:03:06.225Z",
//         "createdAt": "2023-12-02T20:03:06.225Z"
//     }