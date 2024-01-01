

import 'package:equatable/equatable.dart';

class SetToken extends Equatable {
  final String uid;
  final String token;

  SetToken({
    required this.uid,
    required this.token,
  });

  @override
  List<Object?> get props => [uid, token];
}
