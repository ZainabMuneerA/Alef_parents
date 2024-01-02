part of 'attendance_bloc.dart';

sealed class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object> get props => [];
}

class GetAttendanceByStudentId extends AttendanceEvent{
  final int studentId;

  const GetAttendanceByStudentId({required this.studentId});
 @override
  List<Object> get props => [studentId];
}

class GetAttendanceStatus extends AttendanceEvent{
  final int studentId;

  const GetAttendanceStatus({required this.studentId});
 @override
  List<Object> get props => [studentId];
}