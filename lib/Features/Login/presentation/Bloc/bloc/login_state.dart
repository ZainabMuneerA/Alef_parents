part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

//loaddding 
class LoadingLoginState extends LoginState {}

//success
class LoadedLoginState extends LoginState {
  final Login login;

  LoadedLoginState({required this.login});

  @override
  List<Object> get props => [Login];
}

//failure 
class ErrorLoginState extends LoginState {
  final String message;

  ErrorLoginState({required this.message});

  @override
  List<Object> get props => [message];
}