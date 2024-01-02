import 'package:alef_parents/Features/register/domain/entity/register.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/Failure.dart';
import '../repository/registration_repository.dart';

class RegisterUseCase {
  final RegisterRepository repository;

  RegisterUseCase({required this.repository});

  Future<Either<Failure, Register>> call(String email, String name, String password) async {
    return repository.register(email,name, password);
  }
}