import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'models/animated_play_button_theme.dart';

/// A custom painter that handles drawing the morphing play/pause icon.
///
/// This painter recreates the original animation logic by drawing two rotating
/// bars and animating the position of circles on top of them to create the
/// morphing illusion.
class AnimatedPlayButtonPainter extends CustomPainter {
  final Animation<double> hoverAnimation;
  final AnimatedPlayButtonTheme theme;

  AnimatedPlayButtonPainter({
    required this.hoverAnimation,
    required this.theme,
  }) : super(repaint: hoverAnimation);

  @override
  void paint(Canvas canvas, Size size) {
    // Center the canvas for easier calculations
    canvas.translate(size.width / 2, size.height / 2);

    _drawBar(canvas, size, isLeft: true);
    _drawBar(canvas, size, isLeft: false);
  }

  void _drawBar(Canvas canvas, Size size, {required bool isLeft}) {
    final angle = isLeft ? 45.0 : -45.0;
    final circleEndMargin = size.width * 0.52 * hoverAnimation.value;

    final barWidth = size.width * 0.64;
    final barHeight = size.width * 0.12;
    final barRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset.zero, width: barWidth, height: barHeight),
      Radius.circular(size.width * 0.06),
    );

    final barPaint = Paint()
      ..color = Color.lerp(
          theme.barColor, theme.hoverBarColor, hoverAnimation.value)!;
    final circlePaint = Paint()
      ..color = Color.lerp(
          theme.circleColor, theme.hoverCircleColor, hoverAnimation.value)!;

    canvas.save();
    canvas.rotate(angle * (math.pi / 180));

    // Draw the main bar
    canvas.drawRRect(barRect, barPaint);

    // Draw the circles that create the morphing effect
    final circleRadius = barHeight / 2;
    final circleLeftCenter = Offset(-barWidth / 2 + circleEndMargin, 0);
    final circleRightCenter = Offset(barWidth / 2 - circleEndMargin, 0);

    canvas.drawCircle(circleLeftCenter, circleRadius, circlePaint);
    canvas.drawCircle(circleRightCenter, circleRadius, circlePaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant AnimatedPlayButtonPainter oldDelegate) {
    return oldDelegate.theme != theme;
  }
}
