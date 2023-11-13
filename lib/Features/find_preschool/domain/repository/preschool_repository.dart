import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart';

import '../entity/preschool.dart';

abstract class PreschoolRepository {
  //usecases
  Future<Either<Failure, List<Preschool>>> getPreschools();
 
   Future<Either<Failure, List<Preschool>>> getPreschoolByName(String name);
  Future<Either<Failure, Preschool>> getPreschoolById(int id);
}

