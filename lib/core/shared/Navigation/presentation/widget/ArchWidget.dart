import 'package:flutter/material.dart';


class ArchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height); // Start at the bottom-left corner
    path.lineTo(0, size.height / 2); // Create a vertical line
    path.quadraticBezierTo(
      size.width / 2,
      size.height / 4, // Control point for the curved part
      size.width,
      size.height / 2,
    ); // Create the curved part
    path.lineTo(size.width, 0); // Create a vertical line
    path.lineTo(0, 0); // Create a horizontal line
    path.close(); // Close the path to form a closed shape

    final double radius = 16.0; // Adjust the radius as desired
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final Path roundedPath = Path()..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));

    path = Path.combine(PathOperation.intersect, path, roundedPath);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}