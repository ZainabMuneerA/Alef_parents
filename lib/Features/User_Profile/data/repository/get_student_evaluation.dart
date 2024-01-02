



import 'dart:typed_data';

import 'package:alef_parents/Features/User_Profile/data/datasource/student_evaluation_datasource.dart';
import 'package:alef_parents/Features/User_Profile/domain/repository/student_evaluation_repsitory.dart';
import 'package:alef_parents/core/Network/network_info.dart';
import 'package:alef_parents/core/error/Exception.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart';

class StudentEvaluationRepositoryImp implements StudentEvaluationRepository {
  final StudentEvaluationDataSource dataSource;
  final NetworkInfo networkInfo;

  StudentEvaluationRepositoryImp(
    {required this.dataSource,
     required this.networkInfo});

  
  @override
  Future<Either<Failure, Uint8List>> getStudentEvaluation(int id,) async {
    if (await networkInfo.isConnected) {
      try {
        final student = await dataSource.getStudentEvaluation(id);
        return Right(student);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}