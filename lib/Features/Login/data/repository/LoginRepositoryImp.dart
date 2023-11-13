import 'package:alef_parents/Features/Login/data/datasource/LoginDatasource.dart';
import 'package:alef_parents/Features/Login/domain/entity/login.dart';
import 'package:alef_parents/Features/Login/domain/repository/login_repository.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/Network/network_info.dart';
import '../../../../core/error/Exception.dart';

class LoginRepositoryImp implements LoginRepository {
  final LoginDataSource loginDataSource;
  final NetworkInfo networkInfo;

  LoginRepositoryImp(
    {required this.loginDataSource,
     required this.networkInfo});

  
  @override
  Future<Either<Failure, Login>> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final preschool = await loginDataSource.login(email, password);
        return Right(preschool);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
