part of 'time_bloc.dart';

sealed class TimeState extends Equatable {
  const TimeState();
  
  @override
  List<Object> get props => [];
}

final class TimeInitial extends TimeState {}

//loading 
class LoadingTimeState extends TimeState {}

//success
class LoadedTimeState extends TimeState {
  final AvailableSlots time;

  LoadedTimeState({required this.time});

  @override
  List<Object> get props => [time];
}

//failure 
class ErrorTimeState extends TimeState {
  final String message;

  ErrorTimeState({required this.message});

  @override
  List<Object> get props => [message];
}

