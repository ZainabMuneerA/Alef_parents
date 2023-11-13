import 'package:equatable/equatable.dart';

import 'User.dart';

class Login extends Equatable {
  final String message;
  final String jsontoken;
  final User user;

  Login({
    required this.message,
    required this.jsontoken,
    required this.user,
  });

  @override
  List<Object?> get props => [message, jsontoken, user];
}
