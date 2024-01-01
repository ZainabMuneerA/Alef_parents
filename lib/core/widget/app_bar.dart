import '../app_theme.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final String? title;
  final bool showBackButton; // Add a parameter to control the visibility
  const AppBarWidget({Key? key, this.title, this.showBackButton = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20), // Adjust the radius as needed
        ),
      ),
      title: Text(
        title ?? '',
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w100),
      ),
      centerTitle: true,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                // Handle the back button press
                Navigator.of(context).pop();
              },
            )
          : null, // If showBackButton is false, don't show anything
    );
  }
}



 // return AppBar(
    //    backgroundColor: Colors.transparent,
    //   elevation: 0, // This removes the shadow below the app bar
    //   leading: IconButton(
    //     icon: Icon(
    //       Icons.arrow_back,
    //       color: primaryColor,
    //       size: 30,
    //       ),
    //     onPressed: () {
    //       // Pop the current route off the navigation stack
    //       Navigator.of(context).pop();
    //     },
    //   ),
    // );