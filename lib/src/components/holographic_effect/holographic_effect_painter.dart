import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'models/holographic_effect_theme.dart';

/// A custom painter that creates the holographic shine effect with dual waves.
///
/// This painter replicates the CSS ::before pseudo-element animation plus a second wave:
/// - Creates two large gradient rectangles (200% width/height)
/// - First wave: rotates -45 degrees, animates translateY(100%) from top-left to bottom-right
/// - Second wave: rotates 45 degrees, animates translateY(-100%) from bottom-right to top-left
/// - Uses exact same gradient stops and colors as CSS
class HolographicEffectPainter extends CustomPainter {
  /// The current value of the first shine animation (0.0 to 1.0).
  final double shineAnimationValue;

  /// The current value of the second wave animation (0.0 to 1.0).
  final double secondWaveAnimationValue;

  /// The theme data defining the card's appearance.
  final HolographicEffectTheme theme;

  /// Whether the card is currently being hovered.
  final bool isHovering;

  HolographicEffectPainter({
    required this.shineAnimationValue,
    required this.secondWaveAnimationValue,
    required this.theme,
    required this.isHovering,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Only draw the holographic shine effect when hovering
    if (isHovering) {
      // Draw first wave (top-left to bottom-right)
      if (shineAnimationValue > 0) {
        _drawWave(canvas, size, shineAnimationValue, -45, 1, false);
      }

      // Draw second wave (bottom-right to top-left) with slight delay
      if (secondWaveAnimationValue > 0) {
        _drawWave(canvas, size, secondWaveAnimationValue, 45, -1, true);
      }
    }
  }

  void _drawWave(Canvas canvas, Size size, double animationValue,
      double rotationDegrees, int direction, bool isSecondWave) {
    canvas.save();

    // Create the gradient exactly matching CSS:
    // linear-gradient(0deg, transparent, transparent 30%, rgba(0, 255, 255, 0.3))
    final shinePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.transparent,
          Colors.transparent,
          const Color(0x4D00FFFF), // rgba(0, 255, 255, 0.3) - exact CSS match
        ],
        stops: const [0.0, 0.3, 1.0], // Exact CSS stops
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // CSS positioning: top: -50%, left: -50%, width: 200%, height: 200%
    final double rectWidth = size.width * 2.0; // 200%
    final double rectHeight = size.height * 2.0; // 200%
    final double rectLeft = -size.width * 0.5; // -50%
    final double rectTop = -size.height * 0.5; // -50%

    // Apply rotation (45 degrees for second wave, -45 degrees for first wave)
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(rotationDegrees * (math.pi / 180.0));
    canvas.translate(-size.width / 2, -size.height / 2);

    // Apply the translateY animation
    // First wave: moves down (positive translateY)
    // Second wave: moves up (negative translateY)
    final double translateY = direction * (-animationValue) * rectHeight;

    // Draw the shine rectangle
    final shineRect = Rect.fromLTWH(
      rectLeft,
      rectTop + translateY,
      rectWidth,
      rectHeight,
    );

    canvas.drawRect(shineRect, shinePaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant HolographicEffectPainter oldDelegate) {
    // Repaint if the animation value, theme, or hover state changes
    return oldDelegate.shineAnimationValue != shineAnimationValue ||
        oldDelegate.secondWaveAnimationValue != secondWaveAnimationValue ||
        oldDelegate.theme != theme ||
        oldDelegate.isHovering != isHovering;
  }
}
