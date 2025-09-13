import 'package:flutter/material.dart';

/// Defines the visual properties for the [AnimatedArrowButton] widget.
@immutable
class AnimatedArrowButtonTheme {
  /// The background color of the button in its normal state.
  final Color backgroundColor;

  /// The color of the text on the button.
  final Color textColor;

  /// The color of the shadow.
  final Color shadowColor;

  /// The color of the shadow on hover.
  final Color hoverShadowColor;

  /// The text style for the button's label.
  final TextStyle textStyle;

  /// The initial offset for the button's shadow.
  final Offset shadowOffset;

  /// The shadow offset when the button is hovered.
  final Offset hoverShadowOffset;

  /// The skew factor for the button's shape.
  final double skew;

  /// Creates a theme for the animated arrow button.
  const AnimatedArrowButtonTheme({
    this.backgroundColor = const Color(0xFF6225E6),
    this.textColor = Colors.white,
    this.shadowColor = Colors.black,
    this.hoverShadowColor = const Color(0xFFFBC638),
    this.textStyle = const TextStyle(
      fontFamily: 'Poppins',
      fontSize: 40,
      fontWeight: FontWeight.w900,
      fontStyle: FontStyle.italic,
    ),
    this.shadowOffset = const Offset(6, 6),
    this.hoverShadowOffset = const Offset(10, 10),
    this.skew = -15.0, // Degrees
  });
}
