import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'models/animated_arrow_button_theme.dart';

/// A widget that displays a button with animated arrow and skew effects on hover.
///
/// The button features a skewed design with a shadow that changes on hover,
/// and an arrow that animates with color changes.
class AnimatedArrowButton extends StatefulWidget {
  /// The theme for styling the widget
  final AnimatedArrowButtonTheme theme;

  /// Callback when the button is tapped
  final VoidCallback? onTap;

  const AnimatedArrowButton({
    super.key,
    this.theme = const AnimatedArrowButtonTheme(),
    this.onTap,
  });

  @override
  State<AnimatedArrowButton> createState() => _AnimatedArrowButtonState();
}

class _AnimatedArrowButtonState extends State<AnimatedArrowButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _arrowController;
  late Animation<double> _shadowAnimation;
  late Animation<double> _arrowSpacingAnimation;
  late Animation<Color?> _arrowColorAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.theme.animationDuration,
      vsync: this,
    );
    _arrowController = AnimationController(
      duration: const Duration(milliseconds: 3000), // Even slower animation
      vsync: this,
    );

    _shadowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.theme.animationCurve,
    ));

    _arrowSpacingAnimation = Tween<double>(
      begin: 0.0,
      end: 45.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.theme.animationCurve,
    ));

    _arrowColorAnimation = ColorTween(
      begin: widget.theme.arrowColor,
      end: widget.theme.hoverArrowColor,
    ).animate(CurvedAnimation(
      parent: _arrowController,
      curve: Curves.easeInOutSine, // Smoother curve
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    _arrowController.dispose();
    super.dispose();
  }

  void _handleHoverEnter() {
    setState(() {
      _isHovered = true;
    });
    _controller.forward();
    _arrowController.repeat();
  }

  void _handleHoverExit() {
    setState(() {
      _isHovered = false;
    });
    _controller.reverse();
    _arrowController.stop();
    _arrowController.reset();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHoverEnter(),
      onExit: (_) => _handleHoverExit(),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final currentShadowOffset = Offset.lerp(
              widget.theme.shadowOffset,
              widget.theme.hoverShadowOffset,
              _shadowAnimation.value,
            )!;

            final currentShadowColor = Color.lerp(
              widget.theme.shadowColor,
              widget.theme.hoverShadowColor,
              _shadowAnimation.value,
            )!;

            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(0)
                ..rotateY(0)
                ..rotateZ(widget.theme.skewAngle * 3.14159 / 180),
              child: Container(
                padding: widget.theme.padding,
                decoration: BoxDecoration(
                  color: widget.theme.backgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: currentShadowColor,
                      offset: currentShadowOffset,
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Text
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateX(0)
                        ..rotateY(0)
                        ..rotateZ(-widget.theme.skewAngle * 3.14159 / 180),
                      child: Text(
                        widget.theme.text,
                        style: widget.theme.textStyle,
                      ),
                    ),
                    // Arrow spacing
                    SizedBox(width: _arrowSpacingAnimation.value),
                    // Arrow
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateX(0)
                        ..rotateY(0)
                        ..rotateZ(-widget.theme.skewAngle * 3.14159 / 180),
                      child: AnimatedBuilder(
                        animation: _arrowController,
                        builder: (context, child) {
                          return CustomPaint(
                            size: const Size(66, 43),
                            painter: ArrowPainter(
                              color: _arrowColorAnimation.value ??
                                  widget.theme.arrowColor,
                              isAnimating: _isHovered,
                              animationValue: _arrowController.value,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Custom painter for drawing the animated arrow
class ArrowPainter extends CustomPainter {
  final Color color;
  final bool isAnimating;
  final double animationValue;

  ArrowPainter({
    required this.color,
    required this.isAnimating,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw each arrow part separately with sequential animation
    _drawArrowPart(canvas, paint, 0); // Leftmost (part 3)
    _drawArrowPart(canvas, paint, 1); // Middle (part 2)
    _drawArrowPart(canvas, paint, 2); // Rightmost (part 1)
  }

  void _drawArrowPart(Canvas canvas, Paint paint, int partIndex) {
    final path = Path();

    // Calculate animation progress for this specific part with smooth wave animation
    Color partColor = Colors.white;
    if (isAnimating) {
      // Create a smooth wave animation using sine wave
      final totalParts = 3;
      final waveOffset = partIndex / totalParts; // Offset for each part
      final waveValue = (math.sin(
                  (animationValue * 2 * math.pi) - (waveOffset * 2 * math.pi)) +
              1) /
          2;

      // Apply smooth curve to the wave
      final smoothWave = Curves.easeInOutSine.transform(waveValue);

      // Only show color when wave is strong enough (avoid too subtle changes)
      if (smoothWave > 0.3) {
        partColor = Color.lerp(Colors.white, color, smoothWave) ?? color;
      } else {
        partColor = Colors.white;
      }
    }

    paint.color = partColor;

    switch (partIndex) {
      case 0: // Leftmost arrow (part 3)
        path.moveTo(0.154393339, 3.89485454);
        path.lineTo(3.97631488, 0.139296592);
        path.cubicTo(4.17083111, -0.0518420739, 4.48263286, -0.0518571125,
            4.67716753, 0.139262789);
        path.lineTo(25.6916134, 20.7848311);
        path.cubicTo(26.0855801, 21.1718824, 26.0911863, 21.8050225, 25.704135,
            22.1989893);
        path.cubicTo(25.7000188, 22.2031791, 25.6958657, 22.2073326, 25.6916762,
            22.2114492);
        path.lineTo(4.67709797, 42.8607841);
        path.cubicTo(4.48259567, 43.0519059, 4.17082418, 43.0519358, 3.97628526,
            42.8608513);
        path.lineTo(0.154518591, 39.1069479);
        path.cubicTo(-0.0424848215, 38.9134427, -0.0453206733, 38.5968729,
            0.148184538, 38.3998695);
        path.cubicTo(0.150289256, 38.3977268, 0.152413239, 38.395603,
            0.154556228, 38.3934985);
        path.lineTo(16.9937789, 21.8567812);
        path.cubicTo(17.1908028, 21.6632968, 17.193672, 21.3467273, 17.0001876,
            21.1497035);
        path.cubicTo(16.9980647, 21.1475418, 16.9959223, 21.1453995, 16.9937605,
            21.1432767);
        path.lineTo(0.15452076, 4.60825197);
        path.cubicTo(-0.0425130651, 4.41477773, -0.0453986756, 4.09820839,
            0.148075568, 3.90117456);
        path.cubicTo(0.150162624, 3.89904911, 0.152268631, 3.89694235,
            0.154393339, 3.89485454);
        path.close();
        break;

      case 1: // Middle arrow (part 2)
        path.moveTo(20.1543933, 3.89485454);
        path.lineTo(23.9763149, 0.139296592);
        path.cubicTo(24.1708311, -0.0518420739, 24.4826329, -0.0518571125,
            24.6771675, 0.139262789);
        path.lineTo(45.6916134, 20.7848311);
        path.cubicTo(46.0855801, 21.1718824, 46.0911863, 21.8050225, 45.704135,
            22.1989893);
        path.cubicTo(45.7000188, 22.2031791, 45.6958657, 22.2073326, 45.6916762,
            22.2114492);
        path.lineTo(24.677098, 42.8607841);
        path.cubicTo(24.4825957, 43.0519059, 24.1708242, 43.0519358, 23.9762853,
            42.8608513);
        path.lineTo(20.1545186, 39.1069479);
        path.cubicTo(19.9575152, 38.9134427, 19.9546793, 38.5968729, 20.1481845,
            38.3998695);
        path.cubicTo(20.1502893, 38.3977268, 20.1524132, 38.395603, 20.1545562,
            38.3934985);
        path.lineTo(36.9937789, 21.8567812);
        path.cubicTo(37.1908028, 21.6632968, 37.193672, 21.3467273, 37.0001876,
            21.1497035);
        path.cubicTo(36.9980647, 21.1475418, 36.9959223, 21.1453995, 36.9937605,
            21.1432767);
        path.lineTo(20.1545208, 4.60825197);
        path.cubicTo(19.9574869, 4.41477773, 19.9546013, 4.09820839, 20.1480756,
            3.90117456);
        path.cubicTo(20.1501626, 3.89904911, 20.1522686, 3.89694235, 20.1543933,
            3.89485454);
        path.close();
        break;

      case 2: // Rightmost arrow (part 1)
        path.moveTo(40.1543933, 3.89485454);
        path.lineTo(43.9763149, 0.139296592);
        path.cubicTo(44.1708311, -0.0518420739, 44.4826329, -0.0518571125,
            44.6771675, 0.139262789);
        path.lineTo(65.6916134, 20.7848311);
        path.cubicTo(66.0855801, 21.1718824, 66.0911863, 21.8050225, 65.704135,
            22.1989893);
        path.cubicTo(65.7000188, 22.2031791, 65.6958657, 22.2073326, 65.6916762,
            22.2114492);
        path.lineTo(44.677098, 42.8607841);
        path.cubicTo(44.4825957, 43.0519059, 44.1708242, 43.0519358, 43.9762853,
            42.8608513);
        path.lineTo(40.1545186, 39.1069479);
        path.cubicTo(39.9575152, 38.9134427, 39.9546793, 38.5968729, 40.1481845,
            38.3998695);
        path.cubicTo(40.1502893, 38.3977268, 40.1524132, 38.395603, 40.1545562,
            38.3934985);
        path.lineTo(56.9937789, 21.8567812);
        path.cubicTo(57.1908028, 21.6632968, 57.193672, 21.3467273, 57.0001876,
            21.1497035);
        path.cubicTo(56.9980647, 21.1475418, 56.9959223, 21.1453995, 56.9937605,
            21.1432767);
        path.lineTo(40.1545208, 4.60825197);
        path.cubicTo(39.9574869, 4.41477773, 39.9546013, 4.09820839, 40.1480756,
            3.90117456);
        path.cubicTo(40.1501626, 3.89904911, 40.1522686, 3.89694235, 40.1543933,
            3.89485454);
        path.close();
        break;
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant ArrowPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.isAnimating != isAnimating ||
        oldDelegate.animationValue != animationValue;
  }
}
