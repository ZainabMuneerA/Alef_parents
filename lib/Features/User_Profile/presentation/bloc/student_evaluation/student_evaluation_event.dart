part of 'student_evaluation_bloc.dart';

sealed class StudentEvaluationEvent extends Equatable {
  const StudentEvaluationEvent();

  @override
  List<Object> get props => [];
}
class GetStudentEvaluationEvent extends StudentEvaluationEvent {
  final int id;

  GetStudentEvaluationEvent({required this.id});

 @override
  List<Object> get props => [id];
}
