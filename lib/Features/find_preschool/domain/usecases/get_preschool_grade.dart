import 'package:alef_parents/Features/find_preschool/domain/repository/preschool_repository.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart';

class GetPreschoolGrades {
  final PreschoolRepository repository;

  GetPreschoolGrades({required this.repository});

  Future<Either<Failure, List<String>>> call(int id) async {
    return repository.getPreschoolGrades(id);
  }
}
