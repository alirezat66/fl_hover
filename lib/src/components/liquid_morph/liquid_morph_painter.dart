import 'package:flutter/material.dart';
import 'models/liquid_morph_theme.dart';

/// A custom painter to render the animated liquid conic gradient.
///
/// This painter is responsible for drawing the background and the expanding
/// gradient effect when the widget is hovered, controlled by the `animationValue`.
class LiquidMorphPainter extends CustomPainter {
  /// The current value of the liquid animation (0.0 to 1.0).
  final double animationValue;

  /// The theme data defining the widget's appearance.
  final LiquidMorphTheme theme;

  LiquidMorphPainter({
    required this.animationValue,
    required this.theme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // 1. Draw the base background
    final backgroundPaint = Paint()..color = theme.backgroundColor;
    // The border radius is handled by the AnimatedContainer's decoration,
    // so we can just draw a rectangle here that will be clipped.
    canvas.drawRect(rect, backgroundPaint);

    // 2. Draw the animated liquid effect
    if (animationValue > 0) {
      final liquidPaint = Paint()
        ..shader = SweepGradient(
          center: Alignment.center,
          colors: [
            theme.liquidColor,
            theme.backgroundColor,
            theme.liquidColor,
          ],
          stops: const [0.0, 0.33, 0.66], // Corresponds to 120 and 240 degrees
        ).createShader(rect);

      // The effect is an expanding, semi-transparent overlay.
      canvas.save();

      // Scale the canvas from the center based on the animation value.
      canvas.translate(size.width / 2, size.height / 2);
      canvas.scale(animationValue * 2); // Scale up to cover the widget
      canvas.translate(-size.width / 2, -size.height / 2);

      // Apply opacity that fades in and out with the animation
      final opacity = (animationValue > 0.5)
          ? (1.0 - animationValue) * 2
          : animationValue * 2;

      canvas.drawRect(
          rect, liquidPaint..color = Colors.white.withValues(alpha: opacity * 0.5));

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant LiquidMorphPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
