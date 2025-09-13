import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A custom painter that draws the skewed background and its blurred reflection.
class CardSkewPainter extends CustomPainter {
  final double skewFactor;
  final Gradient gradient;

  CardSkewPainter({
    required this.skewFactor,
    required this.gradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader =
          gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    final path = Path();

    // The main skewed shape
    path.moveTo(size.width * 0.25, 0);
    path.lineTo(size.width * 0.75, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width * 0.5, size.height);
    path.close();

    // Apply the dynamic skew transformation
    final matrix = Matrix4.identity()
      ..setEntry(2, 0, skewFactor); // Skew along the x-axis in a 3D-like manner

    final transformedPath = path.transform(matrix.storage);

    // Draw the blurred background first
    canvas.drawPath(
      transformedPath,
      Paint()
        ..shader =
            gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height))
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30.0),
    );

    // Draw the main shape on top
    canvas.drawPath(transformedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CardSkewPainter oldDelegate) {
    return oldDelegate.skewFactor != skewFactor ||
        oldDelegate.gradient != gradient;
  }
}
