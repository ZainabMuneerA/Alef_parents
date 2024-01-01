import 'package:alef_parents/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentDetailsList extends StatelessWidget {
  final String feeName;
  final String date;
  final String status;
  final String amount;
  final int paymentId;

  const PaymentDetailsList({
    Key? key,
    required this.feeName,
    required this.date,
    required this.status,
    required this.amount,
    required this.paymentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Convert status and comparison strings to lowercase for case-insensitive comparison
    String lowercaseStatus = status.toLowerCase();

    // Define background color based on status
    Color backgroundColor = Colors.grey; // Default color
    if (lowercaseStatus == 'pending') {
      backgroundColor = accentColor;
    } else if (lowercaseStatus == 'due') {
      backgroundColor = primaryColor;
    } else if (lowercaseStatus == 'paid') {
      backgroundColor = const Color.fromRGBO(178, 219, 154, 1);
    }

    return GestureDetector(
      onTap: () {
        // Check if the status is 'paid', and return early if true
        if (lowercaseStatus == 'paid') {
          return;
        }

        // If the status is not 'paid', show the payment bottom sheet
        showPaymentBottomSheet(context);
      },
      child: Container(
        width: 290,
        height: 100, // Adjust the height as needed
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color.fromARGB(255, 228, 225, 225)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 17.5,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 20,
              child: Transform.translate(
                offset: const Offset(0, -10),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 6.0,
                          offset: Offset(1.0, 1.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                30,
                10,
                10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    feeName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    // Format the date to be human-readable
                    DateFormat.yMMMMd().format(DateTime.parse(date)),
                    style: const TextStyle(fontSize: 14),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: Text(
                "BHD $amount",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showPaymentBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: 220,
              child: Container(
                padding: const EdgeInsets.fromLTRB(
                  16.0,
                  8,
                  16,
                  20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text('Pay'),
                      onTap: () {
                        // Add logic for payment
                        // ...
                        Navigator.pop(context); // Close the bottom sheet
                      },
                    ),
                    const Divider(),
                    Text(
                      "Amount: $amount BHD",
                      style: TextStyle(fontSize: 16),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 430,
                      height: 61,
                      child: ElevatedButton(
                        onPressed: () {
                          //TODO payment
                          Navigator.pushNamed(
                            context,
                            '/payment-page',
                            arguments: {
                              'dueAmount': int.parse(amount),
                              'paymentId': paymentId
                            },
                          );
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(primaryColor),
                        ),
                        child: const Text(
                          "Pay now",
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
              ),
            );
          },
        );
      },
    );
  }
}
