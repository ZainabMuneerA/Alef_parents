part of 'student_evaluation_bloc.dart';

sealed class StudentEvaluationState extends Equatable {
  const StudentEvaluationState();

  @override
  List<Object> get props => [];
}

final class StudentEvaluationInitial extends StudentEvaluationState {}

final class LoadingStudentEvaluation extends StudentEvaluationState {}

class LoadedEvaluationStudentState extends StudentEvaluationState {
  final Uint8List pdf;

  LoadedEvaluationStudentState({required this.pdf});

  @override
  List<Object> get props => [pdf];
}

class ErrorStudentEvaluationState extends StudentEvaluationState {
  final String message;

  ErrorStudentEvaluationState({required this.message});

  @override
  List<Object> get props => [message];
}

class NoDataState extends StudentEvaluationState {
  final String message;

  NoDataState({required this.message});

  @override
  List<Object> get props => [message];
}
