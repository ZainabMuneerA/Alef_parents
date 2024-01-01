

import 'package:dartz/dartz.dart';

import '../../../../core/Network/network_info.dart';
import '../../../../core/error/Exception.dart';
import '../../../../core/error/Failure.dart';
import '../../domain/entity/setToken.dart';
import '../../domain/repository/SetTokenRepository.dart';
import '../datasource/SetTokenDataSource.dart';

class SetTokenRepositoryImp implements SetTokenRepository {
  final SetTokenDataSource dataSource;
  final NetworkInfo networkInfo;

  SetTokenRepositoryImp(
    {required this.dataSource,
     required this.networkInfo});

  
  @override
  Future<Either<Failure, void>> setToken(String uid, String token,) async {
    if (await networkInfo.isConnected) {
      try {
        final setToken = dataSource.setToken(uid, token);
        return  Right(null);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}