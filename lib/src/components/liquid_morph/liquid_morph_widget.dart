import 'package:flutter/material.dart';
import 'models/liquid_morph_theme.dart';

/// A widget that displays a button with liquid morph hover effect.
///
/// The button transforms from rounded to rectangular shape on hover,
/// with a rotating conic gradient background effect.
class LiquidMorph extends StatefulWidget {
  /// The child widget to display inside the button
  final Widget child;

  /// The theme for styling the widget
  final LiquidMorphTheme theme;

  /// Callback when the button is tapped
  final VoidCallback? onTap;

  const LiquidMorph({
    super.key,
    required this.child,
    required this.theme,
    this.onTap,
  });

  @override
  State<LiquidMorph> createState() => _LiquidMorphState();
}

class _LiquidMorphState extends State<LiquidMorph>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _borderRadiusAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.theme.animationDuration,
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 15.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.theme.animationCurve,
    ));

    _borderRadiusAnimation = Tween<double>(
      begin: widget.theme.borderRadius,
      end: widget.theme.hoverBorderRadius,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.theme.animationCurve,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleHoverEnter() {
    _controller.forward();
  }

  void _handleHoverExit() {
    _controller.reverse();
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
            return Transform.rotate(
              angle: _rotationAnimation.value *
                  3.14159 /
                  180, // Convert degrees to radians
              child: Container(
                width: widget.theme.width,
                height: widget.theme.height,
                decoration: BoxDecoration(
                  color: _controller.value == 0.0
                      ? widget.theme.backgroundColor
                      : null,
                  gradient: _controller.value > 0.0
                      ? SweepGradient(
                          colors: [
                            widget.theme.gradientColors[0],
                            widget.theme.gradientColors[1],
                            widget.theme.gradientColors[2],
                          ],
                          stops: widget.theme.gradientStops,
                        )
                      : null,
                  borderRadius:
                      BorderRadius.circular(_borderRadiusAnimation.value),
                ),
                child: Center(
                  child: widget.child,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
