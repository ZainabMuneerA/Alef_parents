

import 'package:alef_parents/Features/attendance/domain/entities/attendance.dart';
import 'package:alef_parents/Features/attendance/domain/repositories/attendance_repository.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart';

class AttendanceUseCase {
  final AttendanceRepository repository;

  AttendanceUseCase({required this.repository});

  Future<Either<Failure, List<Attendance>>> call(int studentId,) async {
    return repository.getAttendanceByStudentId(studentId);
  }
}