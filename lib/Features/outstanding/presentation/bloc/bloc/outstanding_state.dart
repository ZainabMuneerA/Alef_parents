part of 'outstanding_bloc.dart';

sealed class OutstandingState extends Equatable {
  const OutstandingState();

  @override
  List<Object> get props => [];
}

final class OutstandingInitial extends OutstandingState {}

class LoadingOutstandingState extends OutstandingState {}

class LoadedOutstandingState extends OutstandingState {
  final List<Outstanding> outstanding;

  LoadedOutstandingState({required this.outstanding});

  @override
  List<Object> get props => [outstanding];
}

class LoadedUpdateOutstandingState extends OutstandingState {
  final Bill bill;

  LoadedUpdateOutstandingState({required this.bill});

  @override
  List<Object> get props => [bill];
}

class ErrorOutstandingState extends OutstandingState {
  final String message;

  ErrorOutstandingState({required this.message});

  @override
  List<Object> get props => [message];
}
