import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';

class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = primaryColor // Adjust color as needed
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const double dashWidth = 5.0; // Adjust dash width
    const double dashSpace = 5.0; // Adjust space between dashes

    double startX = 0.0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DashedBorder extends StatelessWidget {
  final Widget child;

  DashedBorder({required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(),
      child: child,
    );
  }
}
