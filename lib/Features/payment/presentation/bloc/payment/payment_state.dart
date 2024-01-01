part of 'payment_bloc.dart';

enum PaymentStatus { initial, loading, success, failure }

class PaymentState extends Equatable {
  final PaymentStatus status;
  final CardFieldInputDetails cardFieldInputDetails;
  final String transactionId;
  final int date;
  final int amount;

  const PaymentState({
    this.status = PaymentStatus.initial,
    this.cardFieldInputDetails = const CardFieldInputDetails(complete: false),
    this.transactionId = '',
    this.date = 0,
    this.amount =0,

  });

  PaymentState copyWith({
    PaymentStatus? status,
    CardFieldInputDetails? cardFieldInputDetails,
    String? transactionId,
    int? date,
    int? amount,
  }) {
    return PaymentState(
      status: status ?? this.status,
      cardFieldInputDetails:
          cardFieldInputDetails ?? this.cardFieldInputDetails,
      transactionId: transactionId ?? this.transactionId,
      date: date ?? this.date,
      amount: amount ?? this.amount
    );
  }

  @override
  List<Object> get props => [status, cardFieldInputDetails];
}

// final class PaymentInitial extends PaymentState {}
