part of 'attendance_bloc.dart';

sealed class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object> get props => [];
}

final class AttendanceInitial extends AttendanceState {}
final class LoadingAttendance extends AttendanceState {}


final class LoadedAttendance extends AttendanceState {
  final List<Attendance> attendace;

  const LoadedAttendance({required this.attendace});

  @override
  List<Object> get props => [attendace];
}

final class LoadedAttendanceStatus extends AttendanceState {
  final AttendanceStatus attendace;

  const LoadedAttendanceStatus({required this.attendace});

  @override
  List<Object> get props => [attendace];
}

final class ErrorAttendance extends AttendanceState {
  final String message;

  const ErrorAttendance({required this.message});

  @override
  List<Object> get props => [message];
}
