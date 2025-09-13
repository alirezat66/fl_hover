import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'models/holographic_card_theme.dart';

/// A custom painter that creates the holographic shine effect on the card.
///
/// This painter draws the base card and an animated, rotated gradient that
/// sweeps across the card to create a shimmering effect, controlled by the
/// `shineAnimationValue`.
class HolographicCardPainter extends CustomPainter {
  /// The current value of the shine animation (0.0 to 1.0).
  final double shineAnimationValue;

  /// The theme data defining the card's appearance.
  final HolographicCardTheme theme;

  HolographicCardPainter({
    required this.shineAnimationValue,
    required this.theme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cardRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final cardRRect = theme.borderRadius.toRRect(cardRect);

    // 1. Draw the base card background
    final backgroundPaint = Paint()..color = theme.backgroundColor;
    canvas.drawRRect(cardRRect, backgroundPaint);

    // 2. Draw the animated holographic shine
    if (shineAnimationValue > 0) {
      final shinePaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: const [0.0, 0.5, 1.0],
          colors: [
            Colors.transparent,
            theme.shineColor,
            Colors.transparent,
          ],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

      // We need to draw a much larger rectangle and rotate it to get the
      // sweeping diagonal effect.
      final double largerDimension =
          math.sqrt(size.width * size.width + size.height * size.height);
      final double angle = -45 * (math.pi / 180.0); // -45 degrees in radians

      // The total distance the shine needs to travel diagonally
      final totalTravelDistance = largerDimension * 2;
      final currentTravel = shineAnimationValue * totalTravelDistance;

      canvas.save();

      // Clip the canvas to the card's shape so the shine doesn't spill out.
      canvas.clipRRect(cardRRect);

      // Center the rotation point
      canvas.translate(size.width / 2, size.height / 2);
      canvas.rotate(angle);
      // Un-center the rotation point
      canvas.translate(-size.width / 2, -size.height / 2);

      // Draw the shine rectangle, moving it across the canvas
      final shineRect = Rect.fromLTWH(
        currentTravel - largerDimension,
        -largerDimension / 2, // Center it vertically
        largerDimension,
        largerDimension * 2, // Make it tall enough to cover the card
      );

      canvas.drawRect(shineRect, shinePaint);

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant HolographicCardPainter oldDelegate) {
    return oldDelegate.shineAnimationValue != shineAnimationValue;
  }
}
