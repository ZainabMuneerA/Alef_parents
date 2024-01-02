import 'package:alef_parents/Features/payment/domain/entity/fees.dart';
import 'package:equatable/equatable.dart';

class Paid extends Equatable {
  final String message;
  final Fees fees;

  Paid({required this.message, required this.fees});

  @override
  List<Object?> get props =>
      [message, fees];
}
