import 'package:alef_parents/Features/register/domain/entity/register.dart';

import '../../domain/entity/User.dart';

class RegisterModel extends Register {
  RegisterModel({
    required super.message,
    required super.user,
  });

factory RegisterModel.fromJson(Map<String, dynamic> json) {
  return RegisterModel(
    message: json['message'],
    user: User.fromJson(json['createdUser']),
  );
}


  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'createdUser': user,
    };
  }
}
