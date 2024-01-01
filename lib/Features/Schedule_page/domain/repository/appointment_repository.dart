import 'package:alef_parents/Features/Schedule_page/domain/entity/scheduled.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/Failure.dart';
import '../entity/appointment_request.dart';
import '../entity/available_slots.dart';

abstract class AppointmentRepository {
  //usecases
  Future<Either<Failure, Scheduled>> scheduled(
      AppointmentRequest appointmentRequest);

  Future<Either<Failure, AvailableSlots>> getTimeSlots(int preschoolId, String date);
}
