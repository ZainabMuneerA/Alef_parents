import 'dart:typed_data';

// import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:alef_parents/Features/User_Profile/domain/usecase/get_studnet_evaluation.dart';
import 'package:alef_parents/core/error/Exception.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:alef_parents/core/error/map_failure_to_msg.dart';
import 'package:alef_parents/core/widget/dialog_widget.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'student_evaluation_event.dart';
part 'student_evaluation_state.dart';

class StudentEvaluationBloc
    extends Bloc<StudentEvaluationEvent, StudentEvaluationState> {
  final GetStudentEvaluationUseCase getStudentEvaluationUseCase;
  StudentEvaluationBloc({
    required this.getStudentEvaluationUseCase,
  }) : super(StudentEvaluationInitial()) {
    on<StudentEvaluationEvent>((event, emit) async {
      if (event is GetStudentEvaluationEvent) {
        emit(LoadingStudentEvaluation());
        try {
          final failureOrStudent = await getStudentEvaluationUseCase(event.id);
          emit(_mapFailureOrStudentToState(failureOrStudent));
        } on NoDataYetException catch (e) {
          
           emit(NoDataState(message: e.message));
          // Handle the case where evaluation data has not been issued yet
        } catch (error) {
          emit(
              ErrorStudentEvaluationState(message: "An Error occured: $error"));
        }
      }
    });
  }
}

StudentEvaluationState _mapFailureOrStudentToState(
    Either<Failure, Uint8List> either) {
  return either.fold(
    (failure) =>
        ErrorStudentEvaluationState(message: mapFailureToMessage(failure)),
    (pdf) => LoadedEvaluationStudentState(pdf: pdf),
  );
}
