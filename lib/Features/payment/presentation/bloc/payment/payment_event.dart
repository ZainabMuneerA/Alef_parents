part of 'payment_bloc.dart';

sealed class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class PaymentStartEvent extends PaymentEvent {}

// class PaymentCreateIntent extends PaymentEvent {
//   final BillingDetails billingDetails;
//   final List<Map<String, dynamic>> items;

//   PaymentCreateIntent({required this.billingDetails, required this.items});
//     @override
//   List<Object> get props => [billingDetails, items];
// }

class PaymentConfirmIntent extends PaymentEvent {
  final String clientSecret;

 const PaymentConfirmIntent({required this.clientSecret});
  List<Object> get props => [clientSecret];

}

class PaymentCreateIntent extends PaymentEvent {
  final BillingDetails billingDetails;
  final List<Map<String, dynamic>> items;

  PaymentCreateIntent({required this.billingDetails, required this.items});
  
  @override
  List<Object> get props => [billingDetails, items];
}

// class PaymentConfirmIntent extends PaymentEvent {
//   final String clientSecret;
//   final List<Map<String, dynamic>> items; // Include the items in the confirmation event

//   PaymentConfirmIntent({required this.clientSecret, required this.items});
  
//   @override
//   List<Object> get props => [clientSecret, items];
// }

