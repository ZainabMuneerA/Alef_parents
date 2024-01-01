


import 'package:dartz/dartz.dart';

import '../../../../core/error/Failure.dart';
import '../entity/setToken.dart';

abstract class SetTokenRepository {

  //usecases
  Future<Either<Failure, void>> setToken(String uid, String token);

}