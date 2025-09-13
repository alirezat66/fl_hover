import 'package:flutter/material.dart';

/// Defines the visual properties for the [AnimatedPlayButton] widget.
@immutable
class AnimatedPlayButtonTheme {
  /// The size of the button (width and height).
  final double size;

  /// The default background color of the button.
  final Color backgroundColor;

  /// The color of the pause/play bars.
  final Color barColor;

  /// The color of the circles on the bars.
  final Color circleColor;

  /// The color of the bars on hover.
  final Color hoverBarColor;

  /// The color of the circles on hover.
  final Color hoverCircleColor;

  /// The box shadow for the button.
  final BoxShadow shadow;

  /// Creates a theme for the animated play button.
  const AnimatedPlayButtonTheme({
    this.size = 100.0,
    this.backgroundColor = Colors.white,
    this.barColor = const Color(0xFFf5a700),
    this.circleColor = const Color(0xFFed7f00),
    this.hoverBarColor = const Color(0xFF2faee0),
    this.hoverCircleColor = const Color(0xFF008ac9),
    this.shadow = const BoxShadow(
      color: Color.fromRGBO(247, 149, 29, 0.5),
      blurRadius: 30.0,
      spreadRadius: 0.0,
    ),
  });
}
