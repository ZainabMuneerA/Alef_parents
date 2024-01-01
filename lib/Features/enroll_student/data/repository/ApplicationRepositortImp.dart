import 'package:alef_parents/Features/enroll_student/data/datasource/ApplicationRemoteData.dart';
import 'package:alef_parents/Features/enroll_student/domain/entity/ApplicationRequest.dart';
import 'package:alef_parents/Features/enroll_student/domain/entity/Enrollment.dart';
import 'package:alef_parents/Features/enroll_student/domain/repository/Application_repository.dart';
import 'package:alef_parents/core/error/Exception.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/Network/network_info.dart';
import '../../domain/entity/EnrollmentStatus.dart';

class ApplicationRepositoryImp implements ApplicationRepository {
  final ApplicationRemoteData applicationRemoteData;
  final NetworkInfo networkInfo;

  ApplicationRepositoryImp(
      {required this.applicationRemoteData, required this.networkInfo});

  @override
  Future<Either<Failure, Enrollment>> applyToPreschool(
      ApplicationRequest request) async {
      if (await networkInfo.isConnected) {
      try {
        final enrollment = await applicationRemoteData.enrollStudent(request);
        return Right(enrollment);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<EnrollmentStatus>>> getApplications(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final applications = await applicationRemoteData.getAllApplication(id);
        return Right(applications);
        
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
  
  @override
  Future<Either<Failure, List<EnrollmentStatus>>> cancelApplications(int id) async{
     if (await networkInfo.isConnected) {
      try {
        final applications = await applicationRemoteData.cancelApplication(id);
        return Right(applications);
        
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
