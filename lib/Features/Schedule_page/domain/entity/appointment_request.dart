class AppointmentRequest {
  final int application_id;
  final String date;
  final int preschool_id;
  final String time;

  AppointmentRequest({
    required this.application_id,
    required this.date,
    required this.preschool_id,
    required this.time
    
  });

  Map<String, dynamic> toJson() {
    return {
      'application_id': application_id,
      'date': date,
      'preschool_id': preschool_id,
      'time': time
    };
  }
}
