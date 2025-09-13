import 'package:flutter/material.dart';

/// Defines the visual properties for the [LiquidMorph] widget.
@immutable
class LiquidMorphTheme {
  /// The background color of the widget.
  final Color backgroundColor;

  /// The primary color of the conic gradient used for the liquid effect.
  final Color liquidColor;

  /// The text style for the content displayed inside the widget.
  final TextStyle textStyle;

  /// The border radius when the widget is in its normal state.
  final BorderRadius initialBorderRadius;

  /// The border radius when the widget is hovered.
  final BorderRadius hoveredBorderRadius;

  /// Creates a theme for the liquid morph widget.
  ///
  /// A default theme is provided that mimics the original CSS effect.
  const LiquidMorphTheme({
    this.backgroundColor = const Color(0xFF0A2342),
    this.liquidColor = const Color(0xFF00FFFF),
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    this.initialBorderRadius = const BorderRadius.all(Radius.circular(50)),
    this.hoveredBorderRadius = const BorderRadius.all(Radius.circular(10)),
  });
}
