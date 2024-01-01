import 'package:alef_parents/Features/outstanding/domain/entities/outstanding.dart';

class OutstandingModel extends Outstanding {
  OutstandingModel(
      {required super.id,
      required super.status,
      required super.type,
      required super.fees,
      required super.dueDate,
      required super.paidOn,
      required super.studentId});

  factory OutstandingModel.fromJson(Map<String, dynamic> json) {
    return OutstandingModel(
        id: json['id'],
        status: json['status'],
        type: json['type'],
        fees: json['fees'],
        dueDate: json['due_date'],
        paidOn: json['paid_on'],
        studentId: json['student_id']);
  }
}
