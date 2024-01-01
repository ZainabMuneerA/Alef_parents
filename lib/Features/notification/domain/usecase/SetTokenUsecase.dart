import 'package:alef_parents/Features/notification/domain/entity/setToken.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/Failure.dart';
import '../repository/SetTokenRepository.dart';

class RegisterUseCase {
  final SetTokenRepository repository;

  RegisterUseCase({required this.repository});

  Future<Either<Failure, void>> call(String uid, String token,) async {
    return repository.setToken(uid, token);
  }
}