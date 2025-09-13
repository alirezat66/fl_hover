import 'package:flutter/material.dart';

/// A custom painter to draw the diagonal striped background of the Scotch Showcase.
class ScotchShowcaseBackgroundPainter extends CustomPainter {
  final Color darkColor;
  final Color midDarkColor;

  ScotchShowcaseBackgroundPainter({
    required this.darkColor,
    required this.midDarkColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    // Draw the base dark color
    paint.color = darkColor;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Draw the diagonal stripes
    paint.color = midDarkColor;
    paint.style = PaintingStyle.stroke;

    // These values are calculated to mimic the CSS linear-gradient stripes
    const angle = 150 * (3.14159 / 180);
    final sinAngle = -0.5; // sin(150deg)
    final cosAngle = 0.866; // cos(150deg)

    // A list of stripe start percentages and thicknesses
    final stripes = [
      {'start': 0.602, 'thickness': 0.0008},
      {'start': 0.607, 'thickness': 0.0008},
      {'start': 0.614, 'thickness': 0.0008},
      {'start': 0.626, 'thickness': 0.012},
      {'start': 0.634, 'thickness': 0.0008},
      {'start': 0.646, 'thickness': 0.012},
      {'start': 0.654, 'thickness': 0.0008},
      {'start': 0.674, 'thickness': 0.02},
      {'start': 0.684, 'thickness': 0.0008},
      {'start': 0.714, 'thickness': 0.03},
      {'start': 0.724, 'thickness': 0.0008},
      {'start': 0.764, 'thickness': 0.04},
      {'start': 0.774, 'thickness': 0.0008},
      {'start': 0.814, 'thickness': 0.04},
      {'start': 0.824, 'thickness': 0.0008},
      {'start': 0.874, 'thickness': 0.05},
    ];

    for (var stripe in stripes) {
      final start = stripe['start'] as double;
      final thickness = stripe['thickness'] as double;
      paint.strokeWidth = size.height * thickness;
      final offset = size.height * start;

      // Calculate start and end points for a line that covers the whole canvas
      final p1 = Offset(offset * cosAngle, offset * sinAngle);
      final p2 = Offset(p1.dx + size.width * 2, p1.dy);

      canvas.drawLine(p1, p2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
