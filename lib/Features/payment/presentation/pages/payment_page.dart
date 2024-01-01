import 'dart:io';

import 'package:alef_parents/Features/outstanding/presentation/bloc/bloc/outstanding_bloc.dart';
import 'package:alef_parents/Features/payment/presentation/bloc/payment/payment_bloc.dart';
import 'package:alef_parents/Features/payment/presentation/pages/receipt_page.dart';
import 'package:alef_parents/core/app_theme.dart';
import 'package:alef_parents/core/widget/loading_widget.dart';
import 'package:alef_parents/framework/shared_prefrences/UserPreferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../../../core/widget/app_bar.dart';
import '../../../../core/widget/dialog_widget.dart';
import 'package:alef_parents/injection_container.dart' as di;

class PaymentPage extends StatefulWidget {
  final int dueAmount;
  final int paymentId;

  const PaymentPage(
      {Key? key, required this.dueAmount, required this.paymentId})
      : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late PaymentBloc _paymentBloc;
  List<int> unpaidFeesList = [];
  String _email = '';
  String _transactionId = '';
  int _paidAmount = 0;
 int _date = 0;
  @override
  void initState() {
    super.initState();
    _paymentBloc = di.sl<PaymentBloc>();
    _fetchEmail();
    unpaidFeesList.add(widget.dueAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AppBarWidget(
            title: 'Payment',
            showBackButton: true,
          ),
        ),
      body: BlocBuilder<PaymentBloc, PaymentState>(
        bloc: _paymentBloc,
        builder: (context, state) {
          CardFormEditController controller = CardFormEditController(
            initialDetails: state.cardFieldInputDetails,
          );

          if (state.status == PaymentStatus.initial) {
            return _buildCardForm(context, controller);
          } else if (state.status == PaymentStatus.success) {
            _transactionId = state.transactionId;
            _paidAmount = state.amount;
            _date=state.date;
            _upadeateOutstanding();

            return _buildSuccessScreen(context);
          } else if (state.status == PaymentStatus.failure) {
            return _buildFailureScreen(context);
          } else {
            return const Center(child: LoadingWidget());
          }
        },
      ),
    );
  }

  Widget _buildCardForm(
      BuildContext context, CardFormEditController controller) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Card Form',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 20),
          CardFormField(controller: controller),
          SizedBox(
            width: 330,
            height: 61,
            child: ElevatedButton(
              onPressed: () => _processPayment(controller),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
              ),
              child: const Text(
                "Pay",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessScreen(BuildContext context) {
    return Center(
      child: DialogFb1(
        isError: false,
        subText: 'Paid Succussfully, a receipt has been sent to your email!',
        btnText: "View Receipt",
        onPressed: () => _navigateToReceiptPage(context),
        // Navigator.pushNamed(context, '/receipt'),
      ),
    );
  }

  void _navigateToReceiptPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReceiptPage(
          transactionId:
              _transactionId, 
          dateTime: _date, 
          email: _email,
          amount: _paidAmount,
        ),
      ),
    );
  }

  Widget _buildFailureScreen(BuildContext context) {
    return Center(
      child: DialogFb1(
        isError: true,
        subText: 'Payment not successful',
        btnText: "Try Again",
        onPressed: () => _paymentBloc.add(PaymentStartEvent()),
      ),
    );
  }

  Widget _buildTransactionDetails(String transactionId, String dateTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Transaction ID: $transactionId',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8),
        Text(
          'Date and Time: $dateTime',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  void _processPayment(CardFormEditController controller) {
    if (controller.details.complete) {
      final items =
          unpaidFeesList.map((price) => {'price': price.toDouble()}).toList();

      _paymentBloc.add(
        PaymentCreateIntent(
          billingDetails: BillingDetails(email: _email),
          items: items,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill the form before submitting"),
        ),
      );
    }
  }

  void _fetchEmail() async {
    final email = await UserPreferences.getEmail();
    setState(() {
      _email = email ?? '';
    });
  }

  void _upadeateOutstanding() {
    try {
      OutstandingBloc outstandingBloc = di.sl<OutstandingBloc>();
      outstandingBloc.add(UpdateOutstandingEvent(paymentId: widget.paymentId));
    } catch (e) {
      print("found error while updaing");
      throw e;
    }
  }
}
