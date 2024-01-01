import 'package:alef_parents/Features/payment/data/datasource/fees_datasource.dart';
import 'package:alef_parents/Features/payment/domain/entity/paid.dart';
import 'package:alef_parents/Features/payment/domain/entity/fees.dart';
import 'package:alef_parents/Features/payment/domain/repository/fees_repository.dart';
import 'package:alef_parents/core/Network/network_info.dart';
import 'package:alef_parents/core/error/Exception.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart';


class FeesRepositoryImp implements FeesRepository {
  final FeesDataSourceImp dataSource;
  final NetworkInfo networkInfo;

  FeesRepositoryImp(
    {required this.dataSource,
     required this.networkInfo});

  @override
  Future<Either<Failure, List<Fees>>> getFees(int studentId) async{
     if (await networkInfo.isConnected) {
      try {
        final fees = await dataSource.getFees(studentId);
        return Right(fees);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Paid>> paidFees(int paymentId) async{
    if (await networkInfo.isConnected) {
      try {
        final paid = await dataSource.paidFees(paymentId);
        return Right(paid);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}