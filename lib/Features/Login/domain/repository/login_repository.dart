

import 'package:alef_parents/Features/Login/domain/entity/login.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/Failure.dart';

abstract class LoginRepository {

  //usecases
  Future<Either<Failure, Login>> login(String email, String password);

}
