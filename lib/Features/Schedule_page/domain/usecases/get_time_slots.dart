import 'package:alef_parents/Features/Schedule_page/domain/entity/available_slots.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/Failure.dart';
import '../repository/appointment_repository.dart';

class GetTimeSlotsUseCase {
  final AppointmentRepository repository;

  GetTimeSlotsUseCase({required this.repository});

  Future<Either<Failure, AvailableSlots>> call(int preschoolId, String date) async {
    return repository.getTimeSlots(preschoolId, date);
  }
}
