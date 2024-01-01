part of 'student_bloc.dart';

sealed class StudentEvent extends Equatable {
  const StudentEvent();

  @override
  List<Object> get props => [];
}

class GetStudentEvent extends StudentEvent {
  final int userId;

  GetStudentEvent({required this.userId});

 @override
  List<Object> get props => [userId];
}
