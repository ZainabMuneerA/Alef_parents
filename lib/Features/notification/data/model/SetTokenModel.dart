

import '../../domain/entity/setToken.dart';

class SetTokenModel extends SetToken {
  SetTokenModel({
    required super.uid,
    required super.token,
  });

factory SetTokenModel.fromJson(Map<String, dynamic> json) {
  return SetTokenModel(
    uid: json['uid'],
    token: json['token'],
  );
}


  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'token': token,
    };
  }
}
