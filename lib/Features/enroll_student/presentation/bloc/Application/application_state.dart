part of 'application_bloc.dart';

sealed class ApplicationState extends Equatable {
  const ApplicationState();

  @override
  List<Object> get props => [];
}

final class ApplicationInitial extends ApplicationState {}

final class LoadingApplicationState extends ApplicationState {}

final class LoadedApplicationState extends ApplicationState {
  final List<EnrollmentStatus> application;

  const LoadedApplicationState({required this.application});

   @override
  List<Object> get props => [application];
}

final class LoadedEnrollmentState extends ApplicationState {
  final Enrollment enrollment;

  const LoadedEnrollmentState({required this.enrollment});

   @override
  List<Object> get props => [enrollment];
}

final class LoadedCancelEnrollmentState extends ApplicationState {
  final String message;

  const LoadedCancelEnrollmentState({required this.message});

   @override
  List<Object> get props => [message];
}

class ErrorApplicationState extends ApplicationState {
  final String message;

  ErrorApplicationState({required this.message});

  @override
  List<Object> get props => [message];
}

class NoDataState extends ApplicationState {
  final String message;

  NoDataState({required this.message});

  @override
  List<Object> get props => [message];
}