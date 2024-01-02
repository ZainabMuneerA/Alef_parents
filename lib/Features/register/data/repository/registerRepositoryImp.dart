



import 'package:alef_parents/Features/register/domain/entity/register.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/Network/network_info.dart';
import '../../../../core/error/Exception.dart';
import '../../../../core/error/Failure.dart';
import '../../domain/repository/registration_repository.dart';
import '../datasource/RegisterDatasource.dart';

class RegisterRepositoryImp implements RegisterRepository {
  final RegisterDataSource dataSource;
  final NetworkInfo networkInfo;

  RegisterRepositoryImp(
    {required this.dataSource,
     required this.networkInfo});

  
  @override
  Future<Either<Failure, Register>> register(String email, String name, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final register = await dataSource.register(email, name, password);
        return Right(register);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
