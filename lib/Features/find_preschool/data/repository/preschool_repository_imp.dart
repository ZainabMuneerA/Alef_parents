import 'package:alef_parents/Features/find_preschool/data/datasources/preschool_remote_datasource.dart';
import 'package:alef_parents/Features/find_preschool/domain/entity/preschool.dart';
import 'package:alef_parents/Features/find_preschool/domain/repository/preschool_repository.dart';
import 'package:alef_parents/core/Network/network_info.dart';
import 'package:alef_parents/core/error/Exception.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart';

import '../datasources/preschool_local_datasource.dart';

typedef Future<List<Preschool>> SearchByIdOrName();

class PreschoolRepositoryImp implements PreschoolRepository {
  final PreschoolRemoteDataSource preschoolRemoteDataSource;
  final PreschoolLocalDataSource preschoolLocalDataSource;
  final NetworkInfo networkInfo;

  PreschoolRepositoryImp(
      {required this.preschoolRemoteDataSource,
      required this.preschoolLocalDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Preschool>>> getPreschools() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePreschool = await preschoolRemoteDataSource.getAllPreschool();
        preschoolLocalDataSource.cachedPreschool(remotePreschool);
        return right(remotePreschool);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPreschool =
            await preschoolLocalDataSource.getCachedPreschool();
        return right(localPreschool);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Preschool>> getPreschoolById(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final preschool = await preschoolRemoteDataSource.getPreschoolById(id);
        return Right(preschool);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<Preschool>>> getPreschoolByName(
    String? name,
    int? age,
    String? area,
    double? latitude,
    double? longitude,
  ) {
    return _getPreschool(() {
      return preschoolRemoteDataSource.getPreschoolByName(
          name, age, area, latitude, longitude);
    });
  }

  Future<Either<Failure, List<Preschool>>> _getPreschool(
      SearchByIdOrName searchByIdOrName) async {
    if (await networkInfo.isConnected) {
      try {
        final preschool = await searchByIdOrName();
        return Right(preschool);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<Preschool>>> getRecommendedPreschools() {
    return _getPreschool(() {
      return preschoolRemoteDataSource.getRecommendedPreschool();
    });
  }
  
  @override
  Future<Either<Failure, List<String>>> getPreschoolGrades(int id) async{
    if (await networkInfo.isConnected) {
      try {
        final grade = await preschoolRemoteDataSource.getPreschoolGrades(id);
        return Right(grade);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
