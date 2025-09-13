import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'models/animated_arrow_button_theme.dart';

/// A painter for the [AnimatedArrowButton] that handles drawing the skewed
/// background, the animated shadow, and the animated arrow paths.
class AnimatedArrowButtonPainter extends CustomPainter {
  final Animation<Offset> shadowOffsetAnimation;
  final Animation<Color?> shadowColorAnimation;
  final Animation<double> arrowPathAnimation;
  final Animation<Color?> arrowColorAnimation1;
  final Animation<Color?> arrowColorAnimation2;
  final Animation<Color?> arrowColorAnimation3;
  final AnimatedArrowButtonTheme theme;

  AnimatedArrowButtonPainter({
    required this.shadowOffsetAnimation,
    required this.shadowColorAnimation,
    required this.arrowPathAnimation,
    required this.arrowColorAnimation1,
    required this.arrowColorAnimation2,
    required this.arrowColorAnimation3,
    required this.theme,
  }) : super(
            repaint: Listenable.merge([
          shadowOffsetAnimation,
          shadowColorAnimation,
          arrowPathAnimation,
          arrowColorAnimation1,
          arrowColorAnimation2,
          arrowColorAnimation3,
        ]));

  @override
  void paint(Canvas canvas, Size size) {
    final skewRadians = theme.skew * (math.pi / 180);
    final Matrix4 skewMatrix = Matrix4.identity()
      ..setEntry(0, 1, math.tan(skewRadians));

    final Paint backgroundPaint = Paint()..color = theme.backgroundColor;
    final Paint shadowPaint = Paint()..color = shadowColorAnimation.value!;

    final Path buttonPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final Path shadowPath = buttonPath.shift(shadowOffsetAnimation.value);

    // 1. Draw Shadow
    canvas.save();
    canvas.transform(skewMatrix.storage);
    canvas.drawPath(shadowPath, shadowPaint);
    canvas.restore();

    // 2. Draw Background
    canvas.save();
    canvas.transform(skewMatrix.storage);
    canvas.drawPath(buttonPath, backgroundPaint);
    canvas.restore();

    // 3. Draw Arrow SVG Paths
    _drawArrow(canvas, size);
  }

  void _drawArrow(Canvas canvas, Size size) {
    // The arrow drawing logic assumes a fixed size context for simplicity.
    // In a real-world scenario, you might want to make this more dynamic.
    const double svgWidth = 66.0;
    const double svgHeight = 43.0;
    final double scaleX = (size.height * 0.5) / svgWidth;
    final double scaleY = (size.height * 0.5) / svgHeight;
    final double scale = math.min(scaleX, scaleY);

    // Position the arrow inside the button
    final double rightPadding = size.width * 0.15;
    final double arrowContainerWidth = svgWidth * scale;
    final double offsetX = size.width - arrowContainerWidth - rightPadding;
    final double offsetY = (size.height - (svgHeight * scale)) / 2;

    canvas.save();
    canvas.translate(offsetX, offsetY);
    canvas.scale(scale);

    // Extracted and simplified path data from the original SVG
    // Path 1
    final path1 = Path()
      ..moveTo(40.15, 3.89)
      ..lineTo(43.97, 0.13)
      ..cubicTo(44.17, -0.05, 44.48, -0.05, 44.67, 0.13)
      ..lineTo(65.69, 20.78)
      ..cubicTo(66.08, 21.17, 66.09, 21.8, 65.7, 22.19)
      ..lineTo(44.67, 42.86)
      ..cubicTo(44.48, 43.05, 44.17, 43.05, 43.97, 42.86)
      ..lineTo(40.15, 39.10)
      ..cubicTo(39.95, 38.91, 39.95, 38.59, 40.14, 38.39)
      ..lineTo(56.99, 21.85)
      ..cubicTo(57.19, 21.66, 57.19, 21.34, 57, 21.14)
      ..lineTo(40.15, 4.60)
      ..cubicTo(39.95, 4.41, 39.95, 4.09, 40.14, 3.9)
      ..close();
    final path1Paint = Paint()..color = arrowColorAnimation1.value!;
    final double path1TranslateX = -60 * (1 - arrowPathAnimation.value);
    canvas.drawPath(path1.shift(Offset(path1TranslateX, 0)), path1Paint);

    // Path 2
    final path2 = Path()
      ..moveTo(20.15, 3.89)
      ..lineTo(23.97, 0.13)
      ..cubicTo(24.17, -0.05, 24.48, -0.05, 24.67, 0.13)
      ..lineTo(45.69, 20.78)
      ..cubicTo(46.08, 21.17, 46.09, 21.8, 45.7, 22.19)
      ..lineTo(24.67, 42.86)
      ..cubicTo(24.48, 43.05, 24.17, 43.05, 23.97, 42.86)
      ..lineTo(20.15, 39.10)
      ..cubicTo(19.95, 38.91, 19.95, 38.59, 20.14, 38.39)
      ..lineTo(36.99, 21.85)
      ..cubicTo(37.19, 21.66, 37.19, 21.34, 37, 21.14)
      ..lineTo(20.15, 4.60)
      ..cubicTo(19.95, 4.41, 19.95, 4.09, 20.14, 3.9)
      ..close();
    final path2Paint = Paint()..color = arrowColorAnimation2.value!;
    final double path2TranslateX = -30 * (1 - arrowPathAnimation.value);
    canvas.drawPath(path2.shift(Offset(path2TranslateX, 0)), path2Paint);

    // Path 3
    final path3 = Path()
      ..moveTo(0.15, 3.89)
      ..lineTo(3.97, 0.13)
      ..cubicTo(4.17, -0.05, 4.48, -0.05, 4.67, 0.13)
      ..lineTo(25.69, 20.78)
      ..cubicTo(26.08, 21.17, 26.09, 21.8, 25.7, 22.19)
      ..lineTo(4.67, 42.86)
      ..cubicTo(4.48, 43.05, 4.17, 43.05, 3.97, 42.86)
      ..lineTo(0.15, 39.10)
      ..cubicTo(-0.04, 38.91, -0.04, 38.59, 0.14, 38.39)
      ..lineTo(16.99, 21.85)
      ..cubicTo(17.19, 21.66, 17.19, 21.34, 17, 21.14)
      ..lineTo(0.15, 4.60)
      ..cubicTo(-0.04, 4.41, -0.04, 4.09, 0.14, 3.9)
      ..close();
    final path3Paint = Paint()..color = arrowColorAnimation3.value!;
    canvas.drawPath(path3, path3Paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant AnimatedArrowButtonPainter oldDelegate) {
    // Repainting is handled by the Listenable.merge in the constructor
    return false;
  }
}
