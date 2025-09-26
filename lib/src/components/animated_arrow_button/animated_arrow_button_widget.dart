import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'animated_arrow_button_painter.dart';
import 'models/animated_arrow_button_theme.dart';

/// The definitive version of AnimatedArrowButton, with full customization
/// via BoxDecoration and a correctly functioning arrow animation.
class AnimatedArrowButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final AnimatedArrowButtonTheme? theme;

  const AnimatedArrowButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.theme,
  }) : super(key: key);

  @override
  State<AnimatedArrowButton> createState() => _AnimatedArrowButtonState();
}

class _AnimatedArrowButtonState extends State<AnimatedArrowButton>
    with TickerProviderStateMixin {
  late final AnimationController _hoverController;
  late final AnimationController _colorController;
  late AnimatedArrowButtonTheme _theme;

  late Animation<Offset> _shadowOffsetAnimation;
  late Animation<Color?> _shadowColorAnimation;
  late List<Animation<Color?>> _arrowColorAnimations;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(vsync: this);
    _colorController = AnimationController(vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _theme = widget.theme ?? const AnimatedArrowButtonTheme();
    _hoverController.duration = _theme.animationDuration;
    _colorController.duration = _theme.animationDuration * 2;
    _setupAnimations();
  }

  void _setupAnimations() {
    final arrowTheme = _theme.arrowTheme;

    _shadowOffsetAnimation = Tween<Offset>(
      begin: _theme.shadowOffset,
      end: _theme.hoverShadowOffset,
    ).animate(CurvedAnimation(parent: _hoverController, curve: Curves.easeOut));

    _shadowColorAnimation = ColorTween(
      begin: _theme.shadowColor,
      end: _theme.hoverShadowColor,
    ).animate(CurvedAnimation(parent: _hoverController, curve: Curves.easeOut));

    assert(arrowTheme.hoverColors.length >= 3,
        "ArrowTheme.hoverColors must contain at least 3 colors.");

    _arrowColorAnimations = [
      _createColorCycleAnimation(arrowTheme.hoverColors[0], 0.6, 1.0),
      _createColorCycleAnimation(arrowTheme.hoverColors[1], 0.4, 0.8),
      _createColorCycleAnimation(arrowTheme.hoverColors[2], 0.2, 0.6),
    ];
  }

  Animation<Color?> _createColorCycleAnimation(
      Color hoverColor, double begin, double end) {
    return TweenSequence<Color?>(
      [
        TweenSequenceItem(
            tween:
                ColorTween(begin: hoverColor, end: hoverColor.withValues(alpha: 0.6)),
            weight: 50),
        TweenSequenceItem(
            tween:
                ColorTween(begin: hoverColor.withValues(alpha: 0.6), end: hoverColor),
            weight: 50),
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
    final double skewRadians = _theme.skew * (math.pi / 180);
    final arrowTheme = _theme.arrowTheme;
    final double arrowAssemblyWidth = arrowTheme.size * (66.0 / 43.0);

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedBuilder(
          animation: Listenable.merge([_hoverController, _colorController]),
          builder: (context, child) {
            return CustomPaint(
              painter: AnimatedArrowButtonPainter(
                hoverAnimation: _hoverController,
                shadowColorAnimation: _shadowColorAnimation,
                shadowOffsetAnimation: _shadowOffsetAnimation,
                arrowColorAnimations: _arrowColorAnimations,
                theme: _theme,
              ),
              child: child,
            );
          },
          child: Padding(
            padding: _theme.padding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform(
                  transform: Matrix4.identity()
                    ..setEntry(0, 1, math.tan(-skewRadians)),
                  alignment: Alignment.center,
                  child: DefaultTextStyle(
                    style: _theme.textStyle ??
                        Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: arrowTheme.color),
                    child: widget.child,
                  ),
                ),
                SizedBox(width: _theme.spacing + arrowAssemblyWidth),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
