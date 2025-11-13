import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'models/stand_up_effect_theme.dart';

class StandUpEffect extends StatefulWidget {
  const StandUpEffect({
    super.key,
    required this.theme,
    required this.topChild,
    required this.bottomChild,
    this.onTap,
  });

  final StandUpEffectTheme theme;
  final Widget topChild;
  final Widget bottomChild;
  final VoidCallback? onTap;

  @override
  State<StandUpEffect> createState() => _StandUpEffectState();
}

class _StandUpEffectState extends State<StandUpEffect>
    with SingleTickerProviderStateMixin {
  static const double _defaultScale = 0.72;
  static const double _hoverLift = -26;
  static const double _perspective = 0.0015;
  static const Color _shadowColor = Color(0x33000000);

  late AnimationController _controller;
  late Curve _curve;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    final theme = widget.theme;
    _controller = AnimationController(
      vsync: this,
      duration: theme.animationDuration,
    );
    _curve = theme.animationCurve;
  }

  @override
  void didUpdateWidget(covariant StandUpEffect oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newTheme = widget.theme;
    if (_controller.duration != newTheme.animationDuration) {
      _controller.duration = newTheme.animationDuration;
    }
    if (_curve != newTheme.animationCurve) {
      _curve = newTheme.animationCurve;
    }
    if (_isHovered) {
      _controller.forward(from: 0);
    } else {
      _controller.reset();
    }
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleEnter(PointerEnterEvent event) {
    setState(() => _isHovered = true);
    _controller.forward(from: 0);
  }

  void _handleExit(PointerExitEvent event) {
    setState(() => _isHovered = false);
    _controller.reverse();
  }

  Matrix4 _buildTransform(double progress) {
    final theme = widget.theme;
    final curved = _curve.transform(progress);
    final tilt = _lerp(theme.initialTiltDegrees, 0, curved);

    final matrix = Matrix4.identity()
      ..setEntry(3, 2, _perspective)
      ..rotateX(_toRadians(tilt));
    return matrix;
  }

  BoxShadow _buildShadow(double progress) {
    final curved = _curve.transform(progress);
    final blur = _lerp(22, 70, curved);
    final spread = _lerp(1, 4, curved);
    final offset = _lerp(28, 45, curved);
    final baseAlpha = _shadowColor.a;
    final alpha = (baseAlpha * (0.8 + 0.3 * curved)).clamp(0.0, 1.0);
    return BoxShadow(
      color: _shadowColor.withValues(alpha: alpha),
      blurRadius: blur,
      spreadRadius: spread,
      offset: Offset(0, offset),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final topFlex = (theme.topSectionRatio * 100).round().clamp(1, 99);
    final bottomFlex = 100 - topFlex;

    return MouseRegion(
      onEnter: _handleEnter,
      onExit: _handleExit,
      child: GestureDetector(
        onTap: widget.onTap,
        child: SizedBox(
          width: theme.width,
          height: theme.height,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final progress = _controller.value;
              final curved = _curve.transform(progress);
              final lift = _lerp(0, _hoverLift, curved);
              final transform = _buildTransform(progress);
              final shadow = _buildShadow(progress);
              final scale = _lerp(_defaultScale, 1.0, curved);

              return Transform.translate(
                offset: Offset(0, lift),
                child: Transform(
                  alignment: Alignment.center,
                  transform: transform,
                  child: Transform.scale(
                    scale: scale,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [shadow],
                        borderRadius:
                            BorderRadius.circular(theme.borderRadius),
                      ),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(theme.borderRadius),
                        child: Column(
                          children: [
                            Expanded(
                              flex: topFlex,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      theme.topGradientStart,
                                      theme.topGradientEnd,
                                    ],
                                  ),
                                ),
                                child: widget.topChild,
                              ),
                            ),
                            Expanded(
                              flex: bottomFlex,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      theme.bottomGradientStart,
                                      theme.bottomGradientEnd,
                                    ],
                                  ),
                                ),
                                child: widget.bottomChild,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  double _toRadians(double degrees) => degrees * math.pi / 180;

  double _lerp(double a, double b, double t) => a + (b - a) * t;
}
