part of 'appointment_bloc.dart';

sealed class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object> get props => [];
}

class SetAppointmentEvent extends AppointmentEvent{
 final AppointmentRequest request;
 

  const SetAppointmentEvent(this.request);

  @override
  List<Object> get props => [request];

}
