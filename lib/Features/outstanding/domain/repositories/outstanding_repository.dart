


import 'package:alef_parents/Features/outstanding/domain/entities/bill.dart';
import 'package:alef_parents/Features/outstanding/domain/entities/outstanding.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart';

abstract class OutstandingRepository {
  Future<Either<Failure, List<Outstanding>>> getOutstanding(
    int studentId,
  );

Future<Either<Failure, Bill>> upadteOutstanding(
    int paymentId,
  );
}