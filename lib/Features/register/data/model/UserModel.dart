

import '../../domain/entity/User.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.roleName,
    required super.name,
    required super.createdAt,
    required super.updatedAt,
    // required super.preschoolId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      roleName: json['role_name'],
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      // preschoolId: json['preschool_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'role_name': roleName,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      // 'preschool_id': preschoolId,
    };
  }
}
