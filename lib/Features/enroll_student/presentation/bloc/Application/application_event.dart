part of 'application_bloc.dart';

sealed class ApplicationEvent extends Equatable {
  const ApplicationEvent();

  @override
  List<Object> get props => [];
}

class GetApplicationEvent extends ApplicationEvent {
  final int id;
 
  GetApplicationEvent({required this.id});
}

class EnrollmentEvent extends ApplicationEvent {
  final ApplicationRequest request;

  EnrollmentEvent({required this.request});
}
