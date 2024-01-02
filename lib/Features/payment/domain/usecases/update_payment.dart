import 'package:alef_parents/Features/payment/domain/entity/paid.dart';
import 'package:alef_parents/Features/payment/domain/repository/fees_repository.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart';

class PaidFeesUseCase {
  final FeesRepository repository;

  PaidFeesUseCase({required this.repository});

  Future<Either<Failure, Paid>> call(int paymentId) async {
    return repository.paidFees(paymentId);
  }
}
