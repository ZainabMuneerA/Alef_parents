import 'package:alef_parents/Features/Schedule_page/domain/entity/appointment_request.dart';
import 'package:alef_parents/Features/Schedule_page/domain/entity/scheduled.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/Failure.dart';
import '../../../../../core/error/map_failure_to_msg.dart';
import '../../../domain/usecases/appointment_usecase.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentUseCase appointmentUseCase;

  AppointmentBloc(
    {
      required this.appointmentUseCase,
    }
  ) : super(AppointmentInitial()) {
    on<AppointmentEvent>((event, emit) async{ 
 if (event is SetAppointmentEvent) {
        emit(LoadingScheduledState());

        try {
          // Debug statement to indicate that the event is being processed
          print('Event: $event');

          final failureOrLoged = await appointmentUseCase(event.request);

          emit(_mapFailureOrScheduledToState(failureOrLoged));
        } catch (error) {

          // Emitting ErrorPreschoolState with an appropriate error message
          emit(ErrorScheduleState(message: 'An error occurred'));
        }
      }

    });
  }
}

 AppointmentState _mapFailureOrScheduledToState(
      Either<Failure, Scheduled> either) {
    return either.fold(
      (failure) => ErrorScheduleState(message: mapFailureToMessage(failure)),
      (scheduled) => LoadedScheduledState(scheduled: scheduled),
    );
  }



