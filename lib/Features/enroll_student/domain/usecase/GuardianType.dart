

import 'package:dartz/dartz.dart';

import '../../../../core/error/Failure.dart';
import '../entity/guardianType.dart';
import '../repository/guardianType_repository.dart';

class GuardianTypeUseCase {
  final GuardianTypeRepository repository;

  GuardianTypeUseCase({required this.repository});

  Future<Either<Failure, List<GuardianType>>> call() async {
    return repository.Guardain();
  }
}