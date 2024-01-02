import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(const PaymentState()) {
    on<PaymentStartEvent>(_onPaymentStart);
    on<PaymentCreateIntent>(_onPaymentCreateIntent);
    on<PaymentConfirmIntent>(_onPaymentConfirmIntent);
  }

  void _onPaymentStart(
    PaymentStartEvent event,
    Emitter<PaymentState> emit,
  ) {
    emit(state.copyWith(status: PaymentStatus.initial));
  }

  void _onPaymentCreateIntent(
    PaymentCreateIntent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(state.copyWith(status: PaymentStatus.loading));

    try {
      final PaymentMethod = await Stripe.instance.createPaymentMethod(
        params: PaymentMethodParams.card(
          paymentMethodData:
              PaymentMethodData(billingDetails: event.billingDetails),
        ),
      );

      final paymentIntentResults = await _callPayEndpointMethodId(
        useStripeSDK: true,
        paymentMethodId: PaymentMethod.id!,
        currency: 'BHD',
        items: event.items,
      );
      if (paymentIntentResults['error'] != null) {
        emit(state.copyWith(status: PaymentStatus.failure));
      }

      if (paymentIntentResults['clientSecret'] != null &&
          paymentIntentResults['requiresAction'] == null) {
        emit(state.copyWith(
            status: PaymentStatus.success,
            transactionId: paymentIntentResults['id'],
            date: paymentIntentResults['date'],
            amount: paymentIntentResults['amount']));
      }
      if (paymentIntentResults['clientSecret'] != null &&
          paymentIntentResults['requiresAction'] != null &&
          paymentIntentResults['requiresAction'] == true) {
        final String clientSecret = paymentIntentResults['clientSecret'];
        add(PaymentConfirmIntent(
          clientSecret: clientSecret,
        ));
      }
    } catch (e) {
      print("this is the error here $e");
      emit(state.copyWith(status: PaymentStatus.failure));
    }
  }

  void _onPaymentConfirmIntent(
    PaymentConfirmIntent event,
    Emitter<PaymentState> emit,
  ) async {
    try {
      final paymentIntent =
          await Stripe.instance.handleNextAction(event.clientSecret);
      print(paymentIntent);
      if (paymentIntent.status == PaymentIntentsStatus.RequiresConfirmation) {
        Map<String, dynamic> results =
            await _callPayEndpointIntentId(paymentIntentId: paymentIntent.id);
        if (results['error'] != null) {
          emit(state.copyWith(status: PaymentStatus.failure));
        } else {
          print(paymentIntent.amount);
          paymentIntent.created;
          // paymentIntent.
          emit(state.copyWith(
            status: PaymentStatus.success,
            amount: int.parse(paymentIntent.amount.toString()),
          ));
        }
      }
    } catch (e) {
      emit(state.copyWith(status: PaymentStatus.failure));
    }
  }

  Future<Map<String, dynamic>> _callPayEndpointMethodId({
    required bool useStripeSDK,
    required String paymentMethodId,
    required String currency,
    List<Map<String, dynamic>>? items,
  }) async {
    final url = Uri.parse(
      'https://us-central1-alef-229ac.cloudfunctions.net/StripePayEndpointMethodId',
    );

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(
        {
          'useStripeSDK': useStripeSDK,
          'paymentMethodId': paymentMethodId,
          'currency': currency,
          'items': items,
        },
      ),
    );
    final decodedResponse = json.decode(response.body);
    return decodedResponse;
  }

  Future<Map<String, dynamic>> _callPayEndpointIntentId({
    required String paymentIntentId,
  }) async {
    final url = Uri.parse(
        'https://us-central1-alef-229ac.cloudfunctions.net/StripePayEndpointIntentId');

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(
          {'paymentIntentId': paymentIntentId},
        ));
    return json.decode(response.body);
  }
}
