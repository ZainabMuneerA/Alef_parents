part of 'events_bloc.dart';

sealed class EventsState extends Equatable {
  const EventsState();

  @override
  List<Object> get props => [];
}

final class EventsInitial extends EventsState {}

final class LoadingEvents extends EventsState {}

final class LoadedEvents extends EventsState {
  final List<Events> events;

  const LoadedEvents({required this.events});

  @override
  List<Object> get props => [events];
}
class ErrorEventsState extends EventsState {
  final String message;

  const ErrorEventsState({required this.message});

  @override
  List<Object> get props => [message];
}