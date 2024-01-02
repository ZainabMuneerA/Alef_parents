import 'package:equatable/equatable.dart';

class Outstanding extends Equatable {
  final int id;
  final String status;
  final String type;
  final int fees;
  final String? paidOn;
  final String dueDate;
  final int studentId;

  Outstanding(
      {required this.id,
      required this.status,
      required this.type,
      required this.fees,
      this.paidOn,
      required this.dueDate,
      required this.studentId});

  @override
  List<Object?> get props => [id, status, fees, paidOn, dueDate, studentId];
}
