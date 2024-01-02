import 'package:alef_parents/Features/register/domain/entity/User.dart';
import 'package:equatable/equatable.dart';

class Register extends Equatable {
  final String message;
  final User user;

  Register({
    required this.message,
    required this.user,
  });

  @override
  List<Object?> get props => [message, user];
}
