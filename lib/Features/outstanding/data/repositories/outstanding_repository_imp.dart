import 'package:alef_parents/Features/outstanding/data/datasources/outstanding_datasource.dart';
import 'package:alef_parents/Features/outstanding/domain/entities/bill.dart';
import 'package:alef_parents/Features/outstanding/domain/entities/outstanding.dart';
import 'package:alef_parents/Features/outstanding/domain/repositories/outstanding_repository.dart';
import 'package:alef_parents/core/Network/network_info.dart';
import 'package:alef_parents/core/error/Exception.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart';

class OutstandingRepositoryImp implements OutstandingRepository {
  final OutstandingDatasource outstandingDatasource;
  final NetworkInfo networkInfo;

  OutstandingRepositoryImp(
      {required this.outstandingDatasource, required this.networkInfo});

  @override
  Future<Either<Failure, List<Outstanding>>> getOutstanding(
      int studentId) async {
    if (await networkInfo.isConnected) {
      try {
        final outstanding = await outstandingDatasource.getOutstanding(
          studentId,
        );
        return Right(outstanding);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Bill>> upadteOutstanding(int paymentId) async {
    if (await networkInfo.isConnected) {
      try {
        final outstanding =
            await outstandingDatasource.updateOutstanding(paymentId);
        return Right(outstanding);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
