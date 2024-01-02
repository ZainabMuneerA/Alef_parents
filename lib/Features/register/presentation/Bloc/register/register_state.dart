part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();
  
  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

//loading 
class LoadingRegisterState extends RegisterState {}

//success
class LoadedRegisterState extends RegisterState {
  final Register register;

  LoadedRegisterState({required this.register});

  @override
  List<Object> get props => [register];
}

//failure 
class ErrorRegisterState extends RegisterState {
  final String message;

  ErrorRegisterState({required this.message});

  @override
  List<Object> get props => [message];
}

