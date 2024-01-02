

import 'package:alef_parents/Features/payment/domain/entity/fees.dart';
import 'package:alef_parents/Features/payment/domain/repository/fees_repository.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart';




class GetFeesUseCase {
  final FeesRepository repository;

  GetFeesUseCase({required this.repository});

  Future<Either<Failure, List<Fees>>> call(int studentId) async {
    return repository.getFees(studentId,);
  }
}