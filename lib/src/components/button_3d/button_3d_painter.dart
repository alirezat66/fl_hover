import 'package:flutter/material.dart';
import 'models/button_3d_theme.dart';

/// A custom painter to draw the 3D button.
///
/// This painter is responsible for drawing the button's shadow (depth) and
/// its top surface, creating a convincing 3D effect that animates based on
/// the `pressAnimationValue`.
class Button3DPainter extends CustomPainter {
  /// The current value of the press animation (0.0 = released, 1.0 = fully pressed).
  final double pressAnimationValue;

  /// The current value of the hover animation (0.0 = not hovered, 1.0 = hovered).
  final double hoverAnimationValue;

  /// The theme data that defines the button's appearance.
  final Button3DTheme theme;

  Button3DPainter({
    required this.pressAnimationValue,
    required this.hoverAnimationValue,
    required this.theme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final pressDepth = pressAnimationValue * theme.depth;

    // Define the rounded rectangle shape for the button
    final RRect buttonRRect = RRect.fromRectAndCorners(
      Rect.fromLTWH(0, 0, size.width, size.height),
      topLeft: theme.borderRadius.topLeft,
      topRight: theme.borderRadius.topRight,
      bottomLeft: theme.borderRadius.bottomLeft,
      bottomRight: theme.borderRadius.bottomRight,
    );

    // 1. Draw the shadow/depth layer
    final shadowPaint = Paint()..color = theme.shadowColor;
    final shadowPath = Path()..addRRect(buttonRRect);
    // The shadow is drawn at the full depth, and the button face moves on top of it.
    canvas.save();
    canvas.translate(0, theme.depth);
    canvas.drawPath(shadowPath, shadowPaint);
    canvas.restore();

    // 2. Draw the top surface (the button face)
    final topSurfaceColor = Color.lerp(
      theme.backgroundColor,
      theme.hoverBackgroundColor,
      hoverAnimationValue,
    )!;

    final topPaint = Paint()..color = topSurfaceColor;
    final borderPaint = Paint()
      ..color = theme.borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // The top surface moves down as the button is pressed
    canvas.save();
    canvas.translate(0, pressDepth);
    canvas.drawPath(shadowPath, topPaint); // Re-using the same path
    canvas.drawPath(shadowPath, borderPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant Button3DPainter oldDelegate) {
    return oldDelegate.pressAnimationValue != pressAnimationValue ||
        oldDelegate.hoverAnimationValue != hoverAnimationValue;
  }
}
