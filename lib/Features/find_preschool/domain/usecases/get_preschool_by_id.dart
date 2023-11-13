import 'package:dartz/dartz.dart';

import '../../../../core/error/Failure.dart';
import '../entity/preschool.dart';
import '../repository/preschool_repository.dart';

class GetPreschoolByIdUseCase {
  final PreschoolRepository repository;

  GetPreschoolByIdUseCase({required this.repository});

  Future<Either<Failure, Preschool>> call(int id) async {
    return repository.getPreschoolById(id);
  }
}
