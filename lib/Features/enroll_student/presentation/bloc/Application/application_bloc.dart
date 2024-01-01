import 'package:alef_parents/Features/enroll_student/domain/entity/ApplicationRequest.dart';
import 'package:alef_parents/Features/enroll_student/domain/entity/Enrollment.dart';
import 'package:alef_parents/Features/enroll_student/domain/usecase/ApplyToPreschool.dart';
import 'package:alef_parents/Features/enroll_student/domain/usecase/GetMyApplication.dart';
import 'package:alef_parents/core/error/Exception.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/Failure.dart';
import '../../../domain/entity/EnrollmentStatus.dart';

part 'application_event.dart';
part 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  final GetApplicationUseCase getApplicationUseCase;
  final ApplyToPreschoolUseCase applyToPreschoolUseCase;

  ApplicationBloc({
    required this.applyToPreschoolUseCase,
    required this.getApplicationUseCase,
  }) : super(ApplicationInitial()) {
    on<ApplicationEvent>((event, emit) async {
      if (event is GetApplicationEvent) {
        emit(LoadingApplicationState());

        try {
          final failureOrApplication = await getApplicationUseCase(event.id);
          print(failureOrApplication);
          emit(_mapFailureOrApplicationToState(failureOrApplication));
        } on NoDataYetException catch (e){
          emit(NoDataState(message: e.message));
          }catch (error) {
          print('Error in GetApplicationEvent: $error');
          emit(ErrorApplicationState(message: 'Unexpected error occurred'));
        }
      } else if (event is EnrollmentEvent) {
        emit(LoadingApplicationState());

        try {
          final failureOrEnrollment =
              await applyToPreschoolUseCase(event.request);

          emit(_mapFailureOrEnrollmentToState(failureOrEnrollment));
        } catch (error) {
          emit(ErrorApplicationState(message: 'Unexpected error occurred'));
        }
      }
    });
  }

  ApplicationState _mapFailureOrApplicationToState(
      Either<Failure, List<EnrollmentStatus>> either) {
    return either.fold(
      (failure) =>
          ErrorApplicationState(message: _mapFailureToMessage(failure)),
      (application) => LoadedApplicationState(application: application),
    );
  }

  ApplicationState _mapFailureOrEnrollmentToState(
      Either<Failure, Enrollment> either) {
    return either.fold(
      (failure) =>
          ErrorApplicationState(message: _mapFailureToMessage(failure)),
      (enrollment) => LoadedEnrollmentState(enrollment: enrollment),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    // Map different Failure types to corresponding error messages
    if (failure is ServerFailure) {
      return 'Server failure';
    } else if (failure is EmptyCacheFailure) {
      return 'Empty cache failure';
    } else if (failure is OfflineFailure) {
      return 'Offline failure';
    } else {
      return 'Unexpected error occurred';
    }
  }
}
