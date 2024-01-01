part of 'guardian_type_bloc.dart';

sealed class GuardianTypeState extends Equatable {
  const GuardianTypeState();

  @override
  List<Object> get props => [];
}

final class GuardianTypeInitial extends GuardianTypeState {}

class LoadingGuadianType extends GuardianTypeState {}

class LoadedGuadianType extends GuardianTypeState {
  final List<GuardianType> guardianType;

  LoadedGuadianType({required this.guardianType});

  @override
  List<Object> get props => [guardianType];
}

class ErrorGuadianType extends GuardianTypeState {
  final String message;

  ErrorGuadianType({required this.message});

  @override
  List<Object> get props => [message];
}
