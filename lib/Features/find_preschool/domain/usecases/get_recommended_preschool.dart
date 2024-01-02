import 'package:alef_parents/Features/find_preschool/domain/entity/preschool.dart';
import 'package:alef_parents/Features/find_preschool/domain/repository/preschool_repository.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart';

class GetRecommendedPreschoolUseCase {
  final PreschoolRepository repository;

  GetRecommendedPreschoolUseCase({required this.repository});

  Future<Either<Failure, List<Preschool>>> call() async {
    return repository.getRecommendedPreschools();
  }
}
