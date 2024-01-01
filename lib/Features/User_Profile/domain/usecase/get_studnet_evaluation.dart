

import 'dart:typed_data';

import 'package:alef_parents/Features/User_Profile/domain/entity/student_evaluation.dart';
import 'package:alef_parents/Features/User_Profile/domain/repository/student_evaluation_repsitory.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart';

class GetStudentEvaluationUseCase {
  final StudentEvaluationRepository repository;

  GetStudentEvaluationUseCase({required this.repository});

  Future<Either<Failure, Uint8List>> call(int id, ) async {
    return repository.getStudentEvaluation(id);
  }
}