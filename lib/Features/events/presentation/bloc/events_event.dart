part of 'events_bloc.dart';

sealed class EventsEvent extends Equatable {
  const EventsEvent();

  @override
  List<Object> get props => [];
}

class GetEventsByClassEvents extends EventsEvent {
  final int classId;

  const GetEventsByClassEvents({required this.classId});

 @override
  List<Object> get props => [classId];
}
