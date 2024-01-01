



import 'package:alef_parents/Features/User_Profile/domain/entity/student.dart';
import 'package:alef_parents/Features/User_Profile/domain/repository/student_repository.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart';

class GetStudentUseCase {
  final StudentRepository repository;

  GetStudentUseCase({required this.repository});

  Future<Either<Failure, List<Student>>> call(int userId, ) async {
    return repository.getStudent(userId,);
  }
}