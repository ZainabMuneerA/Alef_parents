import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart';

import '../entity/preschool.dart';

abstract class PreschoolRepository {
  //usecases
  Future<Either<Failure, List<Preschool>>> getPreschools();

  Future<Either<Failure, List<Preschool>>> getPreschoolByName(
    String? name,
    int? age,
    String? area,
    double? latitude,
    double? longitude,
  );
  Future<Either<Failure, Preschool>> getPreschoolById(int id);

  Future<Either<Failure, List<Preschool>>> getRecommendedPreschools();

  Future<Either<Failure, List<String>>> getPreschoolGrades(int id);
}
