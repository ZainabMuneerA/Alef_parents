import 'package:alef_parents/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../../../../core/widget/app_bar.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(
          showBackButton: true,
          title: S.of(context).about_us,
        ),
      ),
      body: Container(
        height: 500,
        margin: const EdgeInsets.all(30),
        // padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                'lib/assets/images/Alef_logo.png',
                width: 100,
                height: 100,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                S.of(context).about_alef,
              ),
            ),
          ],
        ),
      ), // Add more content as needed
    );
  }
}
