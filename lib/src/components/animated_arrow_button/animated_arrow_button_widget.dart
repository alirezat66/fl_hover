import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'animated_arrow_button_painter.dart';
import 'models/animated_arrow_button_theme.dart';

/// A button with a skewed design and an animated arrow that responds to hover.
class AnimatedArrowButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final AnimatedArrowButtonTheme theme;
  final double width;
  final double height;
  final Duration animationDuration;

  const AnimatedArrowButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.theme = const AnimatedArrowButtonTheme(),
    this.width = 250,
    this.height = 80,
    this.animationDuration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  State<AnimatedArrowButton> createState() => _AnimatedArrowButtonState();
}

class _AnimatedArrowButtonState extends State<AnimatedArrowButton>
    with TickerProviderStateMixin {
  late final AnimationController _hoverController;
  late final AnimationController _colorController;

  late Animation<Offset> _shadowOffsetAnimation;
  late Animation<Color?> _shadowColorAnimation;
  late Animation<double> _arrowPathAnimation;
  late Animation<double> _textPaddingAnimation;

  late Animation<Color?> _arrowColorAnimation1;
  late Animation<Color?> _arrowColorAnimation2;
  late Animation<Color?> _arrowColorAnimation3;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _colorController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _setupAnimations();
  }

  void _setupAnimations() {
    final theme = widget.theme;
    _shadowOffsetAnimation = Tween<Offset>(
      begin: theme.shadowOffset,
      end: theme.hoverShadowOffset,
    ).animate(CurvedAnimation(parent: _hoverController, curve: Curves.easeOut));

    _shadowColorAnimation = ColorTween(
      begin: theme.shadowColor,
      end: theme.hoverShadowColor,
    ).animate(CurvedAnimation(parent: _hoverController, curve: Curves.easeOut));

    _arrowPathAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _hoverController, curve: Curves.easeOut));

    _textPaddingAnimation = Tween<double>(begin: 0.0, end: 45.0).animate(
        CurvedAnimation(parent: _hoverController, curve: Curves.easeOut));

    // Arrow color animations
    _arrowColorAnimation1 = _createColorCycleAnimation(0.6, 1.0);
    _arrowColorAnimation2 = _createColorCycleAnimation(0.4, 0.8);
    _arrowColorAnimation3 = _createColorCycleAnimation(0.2, 0.6);
  }

  Animation<Color?> _createColorCycleAnimation(double begin, double end) {
    return TweenSequence<Color?>(
      [
        TweenSequenceItem(
          tween: ColorTween(
              begin: widget.theme.textColor,
              end: widget.theme.hoverShadowColor),
          weight: 50,
        ),
        TweenSequenceItem(
          tween: ColorTween(
              begin: widget.theme.hoverShadowColor,
              end: widget.theme.textColor),
          weight: 50,
        ),
      ],
    ).animate(CurvedAnimation(
      parent: _colorController,
      curve: Interval(begin, end, curve: Curves.easeInOut),
    ));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  void _onHover(bool isHovering) {
    if (isHovering) {
      _hoverController.forward();
      _colorController.repeat();
    } else {
      _hoverController.reverse();
      _colorController.stop();
      _colorController.value = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double skewRadians = widget.theme.skew * (math.pi / 180);

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: CustomPaint(
            painter: AnimatedArrowButtonPainter(
              shadowOffsetAnimation: _shadowOffsetAnimation,
              shadowColorAnimation: _shadowColorAnimation,
              arrowPathAnimation: _arrowPathAnimation,
              arrowColorAnimation1: _arrowColorAnimation1,
              arrowColorAnimation2: _arrowColorAnimation2,
              arrowColorAnimation3: _arrowColorAnimation3,
              theme: widget.theme,
            ),
            child: AnimatedBuilder(
              animation: _textPaddingAnimation,
              builder: (context, child) {
                return Padding(
                  padding: EdgeInsets.only(right: _textPaddingAnimation.value),
                  child: Center(
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(0, 1, math.tan(-skewRadians)),
                      alignment: Alignment.center,
                      child: DefaultTextStyle(
                        style: widget.theme.textStyle
                            .copyWith(color: widget.theme.textColor),
                        child: child!,
                      ),
                    ),
                  ),
                );
              },
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
