import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'models/travel_story_card_theme.dart';

class TravelStoryCard extends StatefulWidget {
  const TravelStoryCard({
    super.key,
    required this.theme,
    required this.topChild,
    required this.bottomChild,
    this.onTap,
  });

  final TravelStoryCardTheme theme;
  final Widget topChild;
  final Widget bottomChild;
  final VoidCallback? onTap;

  @override
  State<TravelStoryCard> createState() => _TravelStoryCardState();
}

class _TravelStoryCardState extends State<TravelStoryCard>
    with SingleTickerProviderStateMixin {
  static const double _initialTilt = -60;
  static const double _initialScale = 0.7;
  static const double _hoverLift = -26;
  static const double _perspective = 0.0015;

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.theme.animationDuration,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleEnter(PointerEnterEvent event) {
    _controller.forward();
  }

  void _handleExit(PointerExitEvent event) {
    _controller.reverse();
  }

  Matrix4 _buildTransform(double progress) {
    final tilt = _lerp(_initialTilt, 0, progress);

    final matrix = Matrix4.identity()
      ..setEntry(3, 2, _perspective)
      ..rotateX(_toRadians(tilt));
    return matrix;
  }

  BoxShadow _buildShadow(double progress) {
    final blur = _lerp(22, 70, progress);
    final spread = _lerp(1, 4, progress);
    final offset = _lerp(28, 45, progress);
    return BoxShadow(
      color: Colors.black.withValues(alpha: 0.25 + progress * 0.2),
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
              final lift = _lerp(0, _hoverLift, progress);
              final transform = _buildTransform(progress);
              final shadow = _buildShadow(progress);
              final scale = _lerp(_initialScale, 1.0, progress);

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
