part of 'application_bloc.dart';

sealed class ApplicationEvent extends Equatable {
  const ApplicationEvent();

  @override
  List<Object> get props => [];
}

class GetApplicationEvent extends ApplicationEvent {
  final int id;
 
  const GetApplicationEvent({required this.id});
}


class EnrollmentEvent extends ApplicationEvent {
  final ApplicationRequest request;

  const EnrollmentEvent({required this.request});
}

class CancelApplicationEvent extends ApplicationEvent {
  final int id;

  const CancelApplicationEvent({required this.id});
}