part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}
class RegisterUserEvent extends RegisterEvent{
 final String email;
 final String name;
  final String password;

  const RegisterUserEvent(this.email, this.name, this.password);

  @override
  List<Object> get props => [email,name,password];

}
