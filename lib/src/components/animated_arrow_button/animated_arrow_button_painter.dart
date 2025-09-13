import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'models/animated_arrow_button_theme.dart';

/// The definitive painter that correctly draws the shadow, background from
/// a BoxDecoration, and the spreading arrows.
class AnimatedArrowButtonPainter extends CustomPainter {
  final Animation<double> hoverAnimation;
  final Animation<Color?> shadowColorAnimation;
  final Animation<Offset> shadowOffsetAnimation;
  final List<Animation<Color?>> arrowColorAnimations;
  final AnimatedArrowButtonTheme theme;

  AnimatedArrowButtonPainter({
    required this.hoverAnimation,
    required this.shadowColorAnimation,
    required this.shadowOffsetAnimation,
    required this.arrowColorAnimations,
    required this.theme,
  }) : super(
            repaint: Listenable.merge([
          hoverAnimation,
          shadowColorAnimation,
          shadowOffsetAnimation,
          ...arrowColorAnimations,
        ]));

  @override
  void paint(Canvas canvas, Size size) {
    final skewRadians = theme.skew * (math.pi / 180);
    final Matrix4 skewMatrix = Matrix4.identity()
      ..setEntry(0, 1, math.tan(skewRadians));

    final Paint shadowPaint = Paint()..color = shadowColorAnimation.value!;

    // Lerp between the two decorations to animate background, border, etc.
    final currentDecoration = BoxDecoration.lerp(
        theme.decoration, theme.hoverDecoration, hoverAnimation.value)!;

    final RRect buttonRRect = RRect.fromRectAndCorners(
      Rect.fromLTWH(0, 0, size.width, size.height),
      topLeft:
          currentDecoration.borderRadius?.resolve(TextDirection.ltr).topLeft ??
              Radius.zero,
      topRight:
          currentDecoration.borderRadius?.resolve(TextDirection.ltr).topRight ??
              Radius.zero,
      bottomLeft: currentDecoration.borderRadius
              ?.resolve(TextDirection.ltr)
              .bottomLeft ??
          Radius.zero,
      bottomRight: currentDecoration.borderRadius
              ?.resolve(TextDirection.ltr)
              .bottomRight ??
          Radius.zero,
    );

    final Path buttonPath = Path()..addRRect(buttonRRect);
    final Path shadowPath = buttonPath.shift(shadowOffsetAnimation.value);

    // 1. Draw Shadow
    canvas.save();
    canvas.transform(skewMatrix.storage);
    canvas.drawPath(shadowPath, shadowPaint);
    canvas.restore();

    // 2. Draw Background using the painter from the decoration
    final backgroundPainter = currentDecoration.createBoxPainter();
    canvas.save();
    canvas.transform(skewMatrix.storage);
    backgroundPainter.paint(
        canvas, Offset.zero, ImageConfiguration(size: size));
    canvas.restore();

    // 3. Draw Arrows (on top of the background)
    _drawArrow(canvas, size);
  }

  void _drawArrow(Canvas canvas, Size size) {
    const double svgWidth = 66.0;
    const double svgHeight = 43.0;
    final arrowTheme = theme.arrowTheme;
    final double scale = arrowTheme.size / svgHeight;

    final double arrowAssemblyWidth = svgWidth * scale;
    final double skewOffset =
        (math.tan(theme.skew.abs() * (math.pi / 180)) * size.height / 2);

    final double offsetX = size.width -
        arrowAssemblyWidth -
        theme.padding.resolve(TextDirection.ltr).right +
        skewOffset;

    final double offsetY = (size.height - (svgHeight * scale)) / 2;

    canvas.save();
    canvas.translate(offsetX, offsetY);
    canvas.scale(scale);

    final path1 = _createArrowPath1();
    final path2 = _createArrowPath2();
    final path3 = _createArrowPath3();

    final double hoverValue = hoverAnimation.value;
    final double path1TranslateX = -40 * (1 - hoverValue);
    final double path2TranslateX = -20 * (1 - hoverValue);

    final baseColor = arrowTheme.color;
    final hoverColor1 = arrowColorAnimations[0].value!;
    final hoverColor2 = arrowColorAnimations[1].value!;
    final hoverColor3 = arrowColorAnimations[2].value!;

    final path1Paint = Paint()
      ..color = Color.lerp(baseColor, hoverColor1, hoverValue)!;
    final path2Paint = Paint()
      ..color = Color.lerp(baseColor, hoverColor2, hoverValue)!;
    final path3Paint = Paint()
      ..color = Color.lerp(baseColor, hoverColor3, hoverValue)!;

    canvas.drawPath(path1.shift(Offset(path1TranslateX, 0)), path1Paint);
    canvas.drawPath(path2.shift(Offset(path2TranslateX, 0)), path2Paint);
    canvas.drawPath(path3, path3Paint);

    canvas.restore();
  }

  Path _createArrowPath1() => Path()
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
  Path _createArrowPath2() => Path()
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
  Path _createArrowPath3() => Path()
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

  @override
  bool shouldRepaint(covariant AnimatedArrowButtonPainter oldDelegate) => false;
}
