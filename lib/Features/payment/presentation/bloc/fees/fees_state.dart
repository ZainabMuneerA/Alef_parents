part of 'fees_bloc.dart';

sealed class FeesState extends Equatable {
  const FeesState();
  
  @override
  List<Object> get props => [];
}

final class FeesInitial extends FeesState {}


//loading 
class LoadingFeesState extends FeesState {}

//success get fees
class LoadedFeesState extends FeesState {
  final List<Fees> fees;

  LoadedFeesState({required this.fees});

  @override
  List<Object> get props => [fees];
}

//success paid
class LoadedPaidFeesState extends FeesState {
  final Paid paid;

  LoadedPaidFeesState({required this.paid});

  @override
  List<Object> get props => [paid];
}

//failure 
class ErrorFeesState extends FeesState {
  final String message;

  ErrorFeesState({required this.message});

  @override
  List<Object> get props => [message];
}

