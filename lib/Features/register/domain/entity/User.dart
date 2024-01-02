import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String email;
  final String roleName;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
 

  User({
    required this.id,
    required this.email,
    required this.roleName,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      roleName: json['role_name'],
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      
    );
  }

  @override
  List<Object?> get props => [id, email, roleName, name, createdAt, updatedAt,];
}
