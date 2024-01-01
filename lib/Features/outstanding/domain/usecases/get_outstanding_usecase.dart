import 'package:alef_parents/Features/outstanding/domain/entities/outstanding.dart';
import 'package:alef_parents/Features/outstanding/domain/repositories/outstanding_repository.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart';

class GetOutstandingUsecase {
  final OutstandingRepository outstandingRepository;

  GetOutstandingUsecase({required this.outstandingRepository});

  Future<Either<Failure, List<Outstanding>>> call(int studentId) {
    return outstandingRepository.getOutstanding(studentId);
  }
}
