import 'package:alef_parents/Features/Login/domain/entity/login.dart';


import '../../domain/entity/User.dart';


class LoginModel extends Login {
  LoginModel({
    required super.message,
    required super.jsontoken,
    required super.user,
  });

factory LoginModel.fromJson(Map<String, dynamic> json) {
  return LoginModel(
    message: json['message'],
    jsontoken: json['jsontoken'],
    user: User.fromJson(json['user']),
  );
}


  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'jsontoken': jsontoken,
      'user': user,
    };
  }
}
