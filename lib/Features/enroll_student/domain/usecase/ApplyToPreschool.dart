import 'package:alef_parents/Features/enroll_student/domain/entity/Enrollment.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/Failure.dart';
import '../entity/Application.dart';
import '../entity/ApplicationRequest.dart';
import '../repository/Application_repository.dart';

class ApplyToPreschoolUseCase {
  final ApplicationRepository repository;

  ApplyToPreschoolUseCase({required this.repository});

  Future<Either<Failure, Enrollment>> call(ApplicationRequest request) async {
    return repository.applyToPreschool(request);
  }
}
