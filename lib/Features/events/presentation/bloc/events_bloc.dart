import 'package:alef_parents/Features/events/domain/entities/events.dart';
import 'package:alef_parents/Features/events/domain/usecases/get_event_by_class.dart';
import 'package:alef_parents/core/error/Failure.dart';
import 'package:alef_parents/core/error/map_failure_to_msg.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final GetEventByClass getEventByClass;
  EventsBloc({
    required this.getEventByClass,
  }) : super(EventsInitial()) {
    on<EventsEvent>((event, emit) async {
      if (event is GetEventsByClassEvents) {
        emit(LoadingEvents());
        try {
          final failureOrEvent = await getEventByClass(event.classId);
          emit(_mapFailureOrEventToState(failureOrEvent));
        } catch (error) {
          emit(ErrorEventsState(message: "an error occured"));
        }
      }
    });
  }
}

EventsState _mapFailureOrEventToState(
    Either<Failure, List<Events>> either) {
  return either.fold(
    (failure) => ErrorEventsState(message: mapFailureToMessage(failure)),
    (events) => LoadedEvents(events: events),
  );
}
