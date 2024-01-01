import 'package:alef_parents/Features/Schedule_page/domain/entity/appointment_request.dart';
import 'package:alef_parents/Features/Schedule_page/domain/entity/scheduled.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/Failure.dart';
import '../repository/appointment_repository.dart';

class AppointmentUseCase {
  final AppointmentRepository repository;

  AppointmentUseCase({required this.repository});

  Future<Either<Failure, Scheduled>> call(
      AppointmentRequest appointmentRequest) async {
    return repository.scheduled(appointmentRequest);
  }
}
