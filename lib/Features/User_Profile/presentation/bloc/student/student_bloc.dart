import 'package:alef_parents/Features/User_Profile/domain/entity/student.dart';
import 'package:alef_parents/Features/User_Profile/domain/usecase/get_student_usecase.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:alef_parents/core/error/map_failure_to_msg.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final GetStudentUseCase getStudentUseCase;
  StudentBloc({
    required this.getStudentUseCase,
  }) : super(StudentInitial()) {
    on<StudentEvent>((event, emit) async {
      if (event is GetStudentEvent) {
        emit(LoadingStudentState());
        try {
          final failureOrStudent = await getStudentUseCase(event.userId);
          emit(_mapFailureOrStudentToState(failureOrStudent));
        } catch (e) {
          print("error in bloc $e");
          emit(ErrorStudentState(message: "an error occured"));
        }
      }
    });
  }
}

StudentState _mapFailureOrStudentToState(
    Either<Failure, List<Student>> either) {
  return either.fold(
    (failure) => ErrorStudentState(message: mapFailureToMessage(failure)),
    (student) => LoadedStudentState(student: student),
  );
}
