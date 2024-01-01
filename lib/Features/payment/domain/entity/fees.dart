import 'package:equatable/equatable.dart';

class Fees extends Equatable {
  final int id;
  final String status;
  final String type;
  final int fees;
  final String dueDate;
  final String? paidOn;
  final int studnetId;

  Fees(
      {required this.id,
      required this.status,
      required this.type,
      required this.fees,
      required this.dueDate,
       this.paidOn,
      required this.studnetId});

  @override
  List<Object?> get props => [id, status, type, fees, dueDate, paidOn, studnetId];
}
