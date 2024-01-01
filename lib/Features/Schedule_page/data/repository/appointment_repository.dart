

import 'package:alef_parents/Features/Schedule_page/domain/entity/appointment_request.dart';
import 'package:alef_parents/Features/Schedule_page/domain/entity/available_slots.dart';
import 'package:alef_parents/Features/Schedule_page/domain/entity/scheduled.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/Network/network_info.dart';
import '../../../../core/error/Exception.dart';
import '../../../../core/error/Failure.dart';
import '../../domain/repository/appointment_repository.dart';
import '../datasource/appointment_datasource.dart';

class AppointmentRepositoryImp implements AppointmentRepository {
  final AppointmentDataSource dataSource;
  final NetworkInfo networkInfo;

  AppointmentRepositoryImp(
    {required this.dataSource,
     required this.networkInfo});

  
  @override
  Future<Either<Failure, Scheduled>> scheduled(AppointmentRequest appointmentRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final appoint = await dataSource.schedule(appointmentRequest);
        return Right(appoint);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, AvailableSlots>> getTimeSlots(int preschoolId, String date) async { 
    if (await networkInfo.isConnected) {
      try {
        final time = await dataSource.availableSlots(preschoolId, date);
        return Right(time);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

}