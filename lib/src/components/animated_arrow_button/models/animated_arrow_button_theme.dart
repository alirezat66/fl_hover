import 'package:flutter/material.dart';

/// Defines the visual properties for the [AnimatedArrowButton] widget's arrows.
@immutable
class ArrowTheme {
  /// The base color of the arrow assembly.
  final Color color;

  /// The list of colors for the arrows to cycle through on hover.
  /// Must contain at least 3 colors.
  final List<Color> hoverColors;

  /// The height of the arrow assembly. The width will be scaled proportionally.
  final double size;

  const ArrowTheme({
    this.color = Colors.white,
    this.hoverColors = const [
      Color(0xFFFBC638),
      Color(0xFFFBC638),
      Color(0xFFFBC638)
    ],
    this.size = 24.0,
  });
}

/// Defines the visual properties for the [AnimatedArrowButton] widget.
@immutable
class AnimatedArrowButtonTheme {
  /// The decoration of the button in its normal state.
  /// Provides full control over background, border, gradient, etc.
  final BoxDecoration decoration;

  /// The decoration of the button when hovered.
  final BoxDecoration hoverDecoration;

  /// The color of the button's shadow.
  final Color shadowColor;

  /// The color of the button's shadow on hover.
  final Color hoverShadowColor;

  /// The initial offset for the button's shadow.
  final Offset shadowOffset;

  /// The shadow offset when the button is hovered.
  final Offset hoverShadowOffset;

  /// The default text style for the button's child widget.
  final TextStyle? textStyle;

  /// The inner padding of the button.
  final EdgeInsetsGeometry padding;

  /// The skew factor for the button's shape in degrees.
  final double skew;

  /// The horizontal spacing between the child widget and the arrow assembly.
  final double spacing;

  /// The duration of the hover animations.
  final Duration animationDuration;

  /// The theme for the arrow elements.
  final ArrowTheme arrowTheme;

  const AnimatedArrowButtonTheme({
    this.decoration = const BoxDecoration(
      color: Color(0xFF6225E6),
    ),
    this.hoverDecoration = const BoxDecoration(
      color: Color(0xFF7b41f2),
    ),
    this.shadowColor = Colors.black,
    this.hoverShadowColor = const Color(0xFFFBC638),
    this.shadowOffset = const Offset(6, 6),
    this.hoverShadowOffset = const Offset(10, 10),
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    this.skew = -15.0,
    this.spacing = 16.0,
    this.animationDuration = const Duration(milliseconds: 500),
    this.arrowTheme = const ArrowTheme(),
  });
}
