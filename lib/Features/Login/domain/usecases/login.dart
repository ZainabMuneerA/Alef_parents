

import 'package:dartz/dartz.dart';

import '../../../../core/error/Failure.dart';
import '../entity/login.dart';
import '../repository/login_repository.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase({required this.repository});

  Future<Either<Failure, Login>> call(String email, String password) async {
    return repository.login(email, password);
  }
}