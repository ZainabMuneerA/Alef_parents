


import 'package:alef_parents/Features/enroll_student/domain/repository/Application_repository.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart';

class CancelApplicationUseCase {
  final ApplicationRepository repository;

  CancelApplicationUseCase({required this.repository});

  Future<Either<Failure, String>> call(int id) async {
    return repository.cancelApplications(id);
  }
}
