import 'package:flutter/material.dart';

/// Defines the visual properties for the [HoverUnderline] widget.
@immutable
class HoverUnderlineTheme {
  /// The text style of the widget.
  final TextStyle textStyle;

  /// The gradient for the underline and overline.
  final Gradient lineGradient;

  /// The height (thickness) of the lines.
  final double lineHeight;

  /// The vertical gap between the text and the lines.
  final double lineGap;

  /// Creates a theme for the hover underline widget.
  const HoverUnderlineTheme({
    this.textStyle = const TextStyle(fontSize: 32, color: Colors.white),
    this.lineGradient = const LinearGradient(
      colors: [Color(0xFFFF0000), Color(0xFF00FFFF)],
    ),
    this.lineHeight = 2.0,
    this.lineGap = 5.0,
  });
}
