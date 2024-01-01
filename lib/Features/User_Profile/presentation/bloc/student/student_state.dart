part of 'student_bloc.dart';

sealed class StudentState extends Equatable {
  const StudentState();
  
  @override
  List<Object> get props => [];
}

final class StudentInitial extends StudentState {}


class LoadingStudentState extends StudentState {}

class LoadedStudentState extends StudentState {
  final List<Student> student;

  LoadedStudentState({required this.student});

  @override
  List<Object> get props => [Student];
}

class ErrorStudentState extends StudentState {
  final String message;

  ErrorStudentState({required this.message});

  @override
  List<Object> get props => [message];
}
