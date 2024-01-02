


import 'package:alef_parents/Features/attendance/data/datasources/attendance_datasource.dart';
import 'package:alef_parents/Features/attendance/domain/entities/attendance.dart';
import 'package:alef_parents/Features/attendance/domain/entities/attendance_status.dart';
import 'package:alef_parents/Features/attendance/domain/repositories/attendance_repository.dart';
import 'package:alef_parents/core/Network/network_info.dart';
import 'package:alef_parents/core/error/Exception.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart';

class AttendanceRepositoryImp implements AttendanceRepository {
  final AttendanceDataSource dataSource;
  final NetworkInfo networkInfo;

  AttendanceRepositoryImp(
    {required this.dataSource,
     required this.networkInfo});

  
  @override
  Future<Either<Failure, List<Attendance>>> getAttendanceByStudentId(int studentId) async {
    if (await networkInfo.isConnected) {
      try {
        final attendance = await dataSource.getAttendanceByStudentId(studentId);
        return Right(attendance);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, AttendanceStatus>> getAttendanceStatus(int studentId)async {
   if (await networkInfo.isConnected) {
      try {
        final attendance = await dataSource.getAttendanceStatus(studentId);
        return Right(attendance);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

 
}
