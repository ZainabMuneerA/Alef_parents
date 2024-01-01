import 'package:dartz/dartz.dart';

import '../../../../core/error/Failure.dart';
import '../entity/EnrollmentStatus.dart';
import '../repository/Application_repository.dart';

class GetApplicationUseCase {
  final ApplicationRepository repository;

  GetApplicationUseCase({required this.repository});

  Future<Either<Failure, List<EnrollmentStatus>>> call(int id) async {
    return repository.getApplications(id);
  }
}
