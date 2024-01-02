import 'package:alef_parents/Features/payment/domain/entity/paid.dart';

class PaidModel extends Paid {
  PaidModel(
      {
        required super.message,
      required super.fees,

      });

  factory PaidModel.fromJson(Map<String, dynamic> json) {
    return PaidModel(
      message: json['message'],
      fees: json['payment'],
   
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'payment': fees,
 
    };
  }
}
