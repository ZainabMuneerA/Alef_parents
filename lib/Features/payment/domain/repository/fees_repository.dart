

import 'package:alef_parents/Features/payment/domain/entity/paid.dart';
import 'package:alef_parents/Features/payment/domain/entity/fees.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart';

abstract class FeesRepository {
  //usecases
  Future<Either<Failure, List<Fees>>> getFees(
    int studentId,
  );

  Future<Either<Failure, Paid>> paidFees(int paymentId);
}
