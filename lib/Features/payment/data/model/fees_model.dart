
import 'package:alef_parents/Features/payment/domain/entity/fees.dart';

class FeesModel extends Fees {
  FeesModel(
      {required super.id,
      required super.status,
      required super.type,
      required super.fees,
      required super.dueDate,
       super.paidOn,
      required super.studnetId});

  factory FeesModel.fromJson(Map<String, dynamic> json) {
    return FeesModel(
      id: json['id'],
      status: json['status'],
      type: json['type'],
      fees: json['fees'],
      dueDate: json['due_date'],
      paidOn: json['paid_on'],
      studnetId: json['student_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'type': type,
      'fees': fees,
      'due_date': dueDate,
      'paid_on': paidOn,
      'student_id': studnetId,
    };
  }
}
