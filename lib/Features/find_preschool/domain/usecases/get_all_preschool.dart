import 'package:alef_parents/Features/find_preschool/domain/entity/preschool.dart';
import 'package:alef_parents/Features/find_preschool/domain/repository/preschool_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/Failure.dart';

class GetAllPreschoolsUseCase {
  final PreschoolRepository repository;

  GetAllPreschoolsUseCase({required this.repository});

  Future<Either<Failure, List<Preschool>>> call() async {
    return repository.getPreschools();
  }
}
