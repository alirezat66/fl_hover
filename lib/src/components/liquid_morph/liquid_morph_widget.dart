import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'liquid_morph_painter.dart';
import 'models/liquid_morph_theme.dart';

/// A widget that morphs its shape and reveals a liquid-like gradient on hover.
///
/// Recreates the liquid morph CSS effect using an [AnimatedContainer] for the
/// shape and rotation, and a [CustomPainter] for the dynamic gradient effect.
class LiquidMorph extends StatefulWidget {
  /// The content to display inside the widget.
  final Widget child;

  /// The visual theme of the widget.
  final LiquidMorphTheme theme;

  /// The width of the widget.
  final double width;

  /// The height of the widget.
  final double height;

  /// The duration of the morph animation.
  final Duration animationDuration;

  const LiquidMorph({
    Key? key,
    required this.child,
    this.theme = const LiquidMorphTheme(),
    this.width = 250,
    this.height = 100,
    this.animationDuration = const Duration(milliseconds: 600),
  }) : super(key: key);

  @override
  State<LiquidMorph> createState() => _LiquidMorphState();
}

class _LiquidMorphState extends State<LiquidMorph>
    with SingleTickerProviderStateMixin {
  late final AnimationController _liquidController;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _liquidController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
  }

  @override
  void dispose() {
    _liquidController.dispose();
    super.dispose();
  }

  void _onHover(bool isHovering) {
    setState(() {
      _isHovering = isHovering;
    });
    if (_isHovering) {
      _liquidController.forward();
    } else {
      _liquidController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: widget.animationDuration,
        curve: const Cubic(0.68, -0.55, 0.265, 1.55), // Elastic ease from CSS
        width: widget.width,
        height: widget.height,
        transform: Matrix4.identity()
          ..rotateZ(_isHovering ? 15 * (math.pi / 180.0) : 0),
        transformAlignment: Alignment.center,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: _isHovering
              ? widget.theme.hoveredBorderRadius
              : widget.theme.initialBorderRadius,
        ),
        child: AnimatedBuilder(
          animation: _liquidController,
          builder: (context, child) {
            return CustomPaint(
              painter: LiquidMorphPainter(
                animationValue: _liquidController.value,
                theme: widget.theme,
              ),
              child: Center(
                child: DefaultTextStyle(
                  style: widget.theme.textStyle,
                  child: child!,
                ),
              ),
            );
          },
          child: widget.child,
        ),
      ),
    );
  }
}
