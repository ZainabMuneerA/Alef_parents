part of 'appointment_bloc.dart';

sealed class AppointmentState extends Equatable {
  const AppointmentState();
  
  @override
  List<Object> get props => [];
}

final class AppointmentInitial extends AppointmentState {}

//loading 
class LoadingScheduledState extends AppointmentState {}

//success
class LoadedScheduledState extends AppointmentState {
  final Scheduled scheduled;

  LoadedScheduledState({required this.scheduled});

  @override
  List<Object> get props => [scheduled];
}

//failure 
class ErrorScheduleState extends AppointmentState {
  final String message;

  ErrorScheduleState({required this.message});

  @override
  List<Object> get props => [message];
}

