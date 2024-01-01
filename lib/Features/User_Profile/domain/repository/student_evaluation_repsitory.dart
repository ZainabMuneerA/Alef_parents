import 'dart:typed_data';

import 'package:alef_parents/Features/User_Profile/domain/entity/student_evaluation.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart';

abstract class StudentEvaluationRepository {

  //usecases
  Future<Either<Failure, Uint8List>> getStudentEvaluation(int id, );

}