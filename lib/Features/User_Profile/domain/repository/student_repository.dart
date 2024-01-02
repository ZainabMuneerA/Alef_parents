


import 'package:alef_parents/Features/User_Profile/domain/entity/student.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart';

abstract class StudentRepository {

  //usecases
  Future<Either<Failure, List<Student>>> getStudent(int userId, );

}
