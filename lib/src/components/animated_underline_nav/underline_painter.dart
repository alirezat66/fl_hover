import 'dart:ui';

import 'package:flutter/material.dart';

/// A custom painter to draw the animated curvy underline.
class UnderlinePainter extends CustomPainter {
  final double animationValue;
  final Color color;
  final double strokeWidth;

  UnderlinePainter({
    required this.animationValue,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, size.height);

    // This path is a Flutter interpretation of the original SVG path.
    // M0,47.585c0,0,97.5,0,130,0
    path.cubicTo(
      size.width * 0.33, size.height, // control point 1
      size.width * 0.33, size.height, // control point 2
      size.width * 0.33, size.height, // end point
    );

    // c13.75,0,28.74-38.778,46.168-19.416
    path.cubicTo(
      size.width * 0.42, size.height, // control point 1
      size.width * 0.46, size.height * 0.2, // control point 2
      size.width * 0.5, size.height * 0.5, // end point
    );

    // C192.669,46.5,243.603,47.585,260,47.585
    path.cubicTo(
      size.width * 0.54, size.height * 0.8, // control point 1
      size.width * 0.62, size.height, // control point 2
      size.width * 0.67, size.height, // end point
    );

    // c31.821,0,130,0,130,0
    path.cubicTo(
      size.width * 1.0, size.height, // control point 1
      size.width * 1.0, size.height, // control point 2
      size.width * 1.0, size.height, // end point
    );

    // Animate the path drawing
    final PathMetrics pathMetrics = path.computeMetrics();
    final PathMetric pathMetric = pathMetrics.first;
    final Path extractPath = pathMetric.extractPath(
      0.0,
      pathMetric.length * animationValue,
    );

    canvas.drawPath(extractPath, paint);
  }

  @override
  bool shouldRepaint(covariant UnderlinePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
