import 'package:flutter/material.dart';

/// Defines the visual properties for the [AnimatedPlayButton] widget.
@immutable
class AnimatedPlayButtonTheme {
  /// The overall size of the button.
  final double size;

  /// The decoration of the button's body in its normal state.
  /// Provides full control over background, border, gradient, shape, etc.
  final BoxDecoration decoration;

  /// The decoration of the button's body when hovered.
  final BoxDecoration hoverDecoration;

  /// The box shadow for the button in its normal state.
  final BoxShadow? shadow;

  /// The box shadow for the button when hovered.
  final BoxShadow? hoverShadow;

  /// The color of the pause/play bars.
  final Color barColor;

  /// The color of the circles on the bars.
  final Color circleColor;

  /// The color of the bars on hover.
  final Color hoverBarColor;

  /// The color of the circles on hover.
  final Color hoverCircleColor;

  /// The duration of the morph animation.
  final Duration animationDuration;

  /// Creates a theme for the animated play button.
  const AnimatedPlayButtonTheme({
    this.size = 100.0,
    this.decoration = const BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
    ),
    this.hoverDecoration = const BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
    ),
    this.shadow,
    this.hoverShadow = const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.15),
      blurRadius: 20,
      spreadRadius: 2,
      offset: Offset(0, 10),
    ),
    this.barColor = const Color(0xFFf5a700),
    this.circleColor = const Color(0xFFed7f00),
    this.hoverBarColor = const Color(0xFF2faee0),
    this.hoverCircleColor = const Color(0xFF008ac9),
    this.animationDuration = const Duration(milliseconds: 400),
  });
}
