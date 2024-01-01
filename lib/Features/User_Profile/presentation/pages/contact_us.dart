import 'package:alef_parents/core/app_theme.dart';
import 'package:alef_parents/core/widget/reuseable_input.dart';
import 'package:alef_parents/framework/services/auth/auth.dart';
import 'package:alef_parents/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/widget/app_bar.dart';

class ContactUsPage extends StatelessWidget {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(
          showBackButton: true,
          title: S.of(context).contact_us,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Feel free to contact us!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ReusableInputField(
                label: "Subject", inputController: _subjectController),
            const SizedBox(height: 16),
            FloatingLabelTextField(
                hintText: "Body", inputController: _bodyController),
            const SizedBox(height: 16),
            SizedBox(
              width: 330,
              height: 61,
              child: ElevatedButton(
                onPressed: sendEmai,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(primaryColor),
                ),
                child: const Text(
                  'Send',
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
  }

  Future sendEmai() async {
  _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'Alef.preschool@gmail.com',
      query: 'subject=${_subjectController.text}&body=${_bodyController.text}',
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      print('Could not launch email');
    }
  }
  }
}
