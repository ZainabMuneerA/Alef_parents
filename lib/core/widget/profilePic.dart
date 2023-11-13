import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({required this.imageUrl, this.radius = 50.0, Key? key}) : super(key: key);

  final String imageUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: AssetImage(
        imageUrl,
      ),
    );
  }
}