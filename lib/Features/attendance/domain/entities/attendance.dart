

import 'package:equatable/equatable.dart';

class Attendance extends Equatable {
  final String status;
  final String date;

  const Attendance({required this.status, required this.date});


  @override
  List<Object?> get props => [status, date];
}