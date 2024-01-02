import 'package:alef_parents/Features/Schedule_page/domain/entity/available_slots.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/error/Failure.dart';
import '../../../../../../core/error/map_failure_to_msg.dart';
import '../../../../domain/usecases/get_time_slots.dart';
import '../../appointment/appointment_bloc.dart';

part 'time_event.dart';
part 'time_state.dart';

class TimeBloc extends Bloc<TimeEvent, TimeState> {
  final GetTimeSlotsUseCase getAvailableTime;
  TimeBloc({
    required this.getAvailableTime,
  }) : super(TimeInitial()) {
    on<TimeEvent>((event, emit) async {
      if (event is GetAvailableTime) {
        emit(LoadingTimeState());

        try {
          // Debug statement to indicate that the event is being processed
          print('Event: $event');

          final failureOrTiem =
              await getAvailableTime(event.preschool, event.date);

          // Debug statement to indicate the result of the getAllPreschool() function
          print('time in bloc result: $failureOrTiem');

          emit(_mapFailureOrTimeToState(failureOrTiem));
        } catch (error) {
          // Debug statement to indicate any errors that occur during event processing
          print('Error during event processing: $error');

          if (error is ServerFailure) {
            emit(ErrorTimeState(message: error.message?? 'Errpr'));
          } else {
          emit(ErrorTimeState(message: 'An error occurred'));
          }
        }
      }
    });
  }
}

TimeState _mapFailureOrTimeToState(Either<Failure, AvailableSlots> either) {
  return either.fold(
    (failure) {
      if (failure is ServerFailure) {
        return ErrorTimeState(message: failure.message ?? 'Error');
      } else {
        return ErrorTimeState(message: mapFailureToMessage(failure));
      }
    },
    (time) => LoadedTimeState(time: time),
  );
}
