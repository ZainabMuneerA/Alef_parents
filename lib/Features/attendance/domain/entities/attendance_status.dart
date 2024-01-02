
import 'package:equatable/equatable.dart';

class AttendanceStatus extends Equatable {

  final int absent;
  final int present;

  const AttendanceStatus({required this.absent, required this.present});


  @override
  List<Object?> get props => [absent, present];
}