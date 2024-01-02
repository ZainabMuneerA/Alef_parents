


import 'package:dartz/dartz.dart';

import '../../../../core/error/Failure.dart';
import '../entity/guardianType.dart';

abstract class GuardianTypeRepository{

  Future<Either<Failure, List<GuardianType>>> Guardain();

}