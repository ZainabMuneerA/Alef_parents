import 'package:alef_parents/Features/outstanding/data/models/outstanding_model.dart';
import 'package:alef_parents/Features/outstanding/domain/entities/bill.dart';

class BillModel extends Bill {
  BillModel({
    required super.message,
    required super.outstanding,
  });

  factory BillModel.fromJson(Map<String, dynamic> json) {
    return BillModel(
      message: json['message'],
     outstanding: OutstandingModel.fromJson(json['payment']),
     
     );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'payment': outstanding,
    };
  }
}
