


import 'package:alef_parents/Features/attendance/domain/entities/attendance.dart';
import 'package:alef_parents/Features/attendance/domain/entities/attendance_status.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:dartz/dartz.dart';

abstract class AttendanceRepository {

  //usecases
  Future<Either<Failure, List<Attendance>>> getAttendanceByStudentId(int studentId, );
  Future<Either<Failure, AttendanceStatus>> getAttendanceStatus(int studentId, );
}
