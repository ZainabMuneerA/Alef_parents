

import 'package:dartz/dartz.dart';

import '../../../../core/error/Failure.dart';
import '../entity/preschool.dart';
import '../repository/preschool_repository.dart';

class GetPreschoolByNameUseCase {
  final PreschoolRepository repository;

  GetPreschoolByNameUseCase({required this.repository});

  Future<Either<Failure, List<Preschool>>> call(String? name,
  int? age,
  String? area,
  double? latitude,
  double? longitude,) async {
    return repository.getPreschoolByName(name, age, area, latitude, longitude);
  }
}