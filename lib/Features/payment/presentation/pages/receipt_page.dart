
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';


class ReceiptPage extends StatelessWidget {
  final _screenshot = ScreenshotController();
  final String transactionId;
  final int dateTime;
  final String email;
  final int amount;

  ReceiptPage(
      {required this.transactionId,
      required this.dateTime,
      required this.email,
      required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20), // Adjust the radius as needed
        ),
      ),
        title: Text(
          'Receipt',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: Colors.white),
            onPressed: () {
              _takeScreenshot();
            },
          ),
        ],
      ),
      body: Screenshot(
        controller: _screenshot,
        child: Center(
          child: Stack(
            children: [
              // Main container
              Container(
                width: 400,
                height: 550,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.5),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(10, 20),
                      blurRadius: 20,
                      spreadRadius: 20,
                      color: Colors.grey.withOpacity(.15),
                    ),
                  ],
                ),
                margin: EdgeInsets.only(top: 40),
                child: Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Receipt',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Divider(),
                      _buildReceiptItem(amount),
                      Divider(),
                      _buildTransactionDetails(transactionId, dateTime),
                      Divider(),
                      _buildUserDetails(email),
                      Divider(),
                      _buildThankYouMessage(),
                    ],
                  ),
                ),
              ),
              _buildImageContainer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageContainer() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color.fromARGB(
              255, 207, 204, 204), // Adjust the color as needed
        ),
        child: Center(
          child: Lottie.network(
            'https://lottie.host/3e2ce167-be81-4e23-a7f0-63b3e25d1f06/H0E7vX0u2U.json',
            repeat: true,
            reverse: true,
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptItem(int paidAmount) {
    String formattedAmount = NumberFormat.currency(
      locale: 'en_BH',
      symbol: 'BHD',
      decimalDigits: 3, // Set the desired number of decimal places
    ).format(
        paidAmount / 1000); // Divide by 1000 to convert from fils to dinars

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Paid Amount: $formattedAmount',
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionDetails(String transactionId, int dateTime) {
    // Convert epoch to DateTime
    DateTime transactionDateTime =
              DateTime.fromMillisecondsSinceEpoch(dateTime * 1000); // Convert to microseconds
    // Format date using intl package
    String formattedDate =
        DateFormat.yMMMMd().add_jm().format(transactionDateTime);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Receipt ID: $transactionId',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 8.0),
          Text(
            'Date and Time: $formattedDate',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  Widget _buildUserDetails(String userEmail) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        'User Email: $userEmail',
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }

  Widget _buildThankYouMessage() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        'Thank you for choosing Alef!',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 191, 230, 192),
        ),
      ),
    );
  }

void _takeScreenshot() async {
  final Uint8List? uint8List = await _screenshot.capture();

  if (uint8List != null) {
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/image.png');
    await file.writeAsBytes(uint8List);
    await Share.shareFiles([file.path]);
  } else {
    // Handle the case where uint8List is null (e.g., capture failed)
    print('Screenshot capture failed');
  }
}

}
