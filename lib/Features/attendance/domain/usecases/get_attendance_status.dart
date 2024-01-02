

import 'package:alef_parents/Features/attendance/domain/entities/attendance_status.dart';
import 'package:alef_parents/Features/attendance/domain/repositories/attendance_repository.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart';

class AttendanceStatusUseCase {
  final AttendanceRepository repository;

  AttendanceStatusUseCase({required this.repository});

  Future<Either<Failure, AttendanceStatus>> call(int studentId,) async {
    return repository.getAttendanceStatus(studentId);
  }
}