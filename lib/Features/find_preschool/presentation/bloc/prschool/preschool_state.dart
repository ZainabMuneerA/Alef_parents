part of 'preschool_bloc.dart';

abstract class PreschoolState extends Equatable {
  const PreschoolState();

  @override
  List<Object> get props => [];
}

class PreschoolInitial extends PreschoolState {}

class LoadingPreschoolState extends PreschoolState {}

class LoadedPreschoolState extends PreschoolState {
  final List<Preschool> preschool;

  LoadedPreschoolState({required this.preschool});

  @override
  List<Object> get props => [Preschool];
}

class ErrorPreschoolState extends PreschoolState {
  final String message;

  ErrorPreschoolState({required this.message});

  @override
  List<Object> get props => [message];
}
