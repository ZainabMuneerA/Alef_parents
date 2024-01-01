import 'package:alef_parents/Features/enroll_student/data/datasource/GuardianTypeRemoteData.dart';
import 'package:alef_parents/Features/enroll_student/domain/entity/guardianType.dart';
import 'package:alef_parents/Features/enroll_student/domain/repository/guardianType_repository.dart';
import 'package:alef_parents/core/Network/network_info.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/Exception.dart';

class GuardianTypeRepositoryImp implements GuardianTypeRepository {
  final GuardianDataSource guardianDataSource;
  final NetworkInfo networkInfo;

  GuardianTypeRepositoryImp({
    required this.guardianDataSource, 
    required this.networkInfo});

 
  @override
  Future<Either<Failure, List<GuardianType>>> Guardain()async {
    if (await networkInfo.isConnected) {
      try {
        final guardianType = await guardianDataSource.guardianType();

        return Right(guardianType);

      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
  }

