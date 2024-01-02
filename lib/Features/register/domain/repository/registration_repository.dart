

import 'package:alef_parents/Features/register/domain/entity/register.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/Failure.dart';

abstract class RegisterRepository {

  //usecases
  Future<Either<Failure, Register>> register(String email, String name, String password, );

}
