import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';
import '../../../../core/shared/Navigation/presentation/widget/ArchWidget.dart';
import '../../../../core/widget/profilePic.dart';

import '../widgets/StudentDropDown.dart';


class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool _isEnglishEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              // Clip the background image using the ArchClipper widget
              ClipPath(
                clipper: ArchClipper(),
                child: Container(
                  color: primaryColor,
                  height: 350,
                ),
              ),
              const Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 90),
                      ProfilePic(imageUrl: 'lib/assets/images/imageHolder.jpeg'),
                      SizedBox(height: 16),
                      Text(
                        'Zainab Abdulla',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 8), // Reduce the height value here
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 270.0, 16.0, 0.0),
                child: Column(
                  children: [
                    StudentDropDown(
                      options: const ['Download Attendance Report', 'Download Evaluation Report'],
                      studentName: 'Zainab Abdulla',
                      studentSchool: 'Farawla Preschool',
                      onChanged: (option) {},
                    ),







                    //TODO remove when done
                    SizedBox(height: 16),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       'Language',
                    //       style: TextStyle(
                    //         fontSize: 16,
                    //       ),
                    //     ),
                    //     Switch(
                    //       value: _isEnglishEnabled,
                    //       onChanged: (value) {
                    //         setState(() {
                    //           _isEnglishEnabled = value;
                    //         });
                    //       },
                    //     ),
                    //   ],
                    // ),




                  ],
                ),
              ),
            ],
          ),
          // Other widgets for the user profile page, such as email address, bio, etc.
        ],
      ),
    );
  }
}

