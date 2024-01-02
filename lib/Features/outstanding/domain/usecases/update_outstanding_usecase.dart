import 'package:alef_parents/Features/outstanding/domain/entities/bill.dart';
import 'package:alef_parents/Features/outstanding/domain/repositories/outstanding_repository.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart';

class UpadteOutstandingUsecase {
  final OutstandingRepository outstandingRepository;

  UpadteOutstandingUsecase({required this.outstandingRepository});

  Future<Either<Failure, Bill>> call(int paymentId) {
    return outstandingRepository.upadteOutstanding(paymentId);
  }
}
