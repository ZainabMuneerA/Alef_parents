import 'package:alef_parents/Features/attendance/domain/entities/attendance.dart';
import 'package:alef_parents/Features/attendance/domain/entities/attendance_status.dart';
import 'package:alef_parents/Features/attendance/domain/usecases/get_attendance_by_student.dart';
import 'package:alef_parents/Features/attendance/domain/usecases/get_attendance_status.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:alef_parents/core/error/map_failure_to_msg.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceUseCase getAttendanceByStudentId;
  final AttendanceStatusUseCase attendanceStatus;
  AttendanceBloc({
    required this.getAttendanceByStudentId,
    required this.attendanceStatus,
  }) : super(AttendanceInitial()) {
    on<AttendanceEvent>((event, emit) async {
      if (event is GetAttendanceByStudentId) {
        emit(LoadingAttendance());
        try {
          final failureOrAttendace =
              await getAttendanceByStudentId(event.studentId);
          emit(_mapFailureOrAttendanceState(failureOrAttendace));
        } catch (error) {
          emit(const ErrorAttendance(message: "error"));
        }
      }

      if (event is GetAttendanceStatus) {
        emit(LoadingAttendance());
        try {
          final failureOrAttendace = await attendanceStatus(event.studentId);
          emit(_mapFailureOrAttendanceStatusState(failureOrAttendace));
        } catch (error) {
          emit(const ErrorAttendance(message: "error"));
        }
      }
    });
  }
}

AttendanceState _mapFailureOrAttendanceState(
    Either<Failure, List<Attendance>> either) {
  return either.fold(
    (failure) {
      return ErrorAttendance(message: mapFailureToMessage(failure));
    },
    (attendance) => LoadedAttendance(attendace: attendance),
  );
}

AttendanceState _mapFailureOrAttendanceStatusState(
    Either<Failure, AttendanceStatus> either) {
  return either.fold(
    (failure) {
      return ErrorAttendance(message: mapFailureToMessage(failure));
    },
    (attendance) => LoadedAttendanceStatus(attendace: attendance),
  );
}
