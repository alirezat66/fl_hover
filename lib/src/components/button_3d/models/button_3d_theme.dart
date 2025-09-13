import 'package:flutter/material.dart';

/// Defines the visual properties of the [Button3D] widget.
///
/// Used to customize the appearance of the 3D button, including colors,
/// depth, and text style.
@immutable
class Button3DTheme {
  /// The main background color of the button's top surface.
  final Color backgroundColor;

  /// The background color of the button when hovered.
  final Color hoverBackgroundColor;

  /// The color of the 3D shadow/depth effect.
  final Color shadowColor;

  /// The color of the border around the button's top surface.
  final Color borderColor;

  /// The text style for the content inside the button.
  final TextStyle textStyle;

  /// The vertical depth of the button's 3D effect in logical pixels.
  final double depth;

  /// The border radius for the button's corners.
  final BorderRadius borderRadius;

  /// Creates a theme for the 3D button.
  ///
  /// A default theme is provided that mimics the original CSS effect.
  const Button3DTheme({
    this.backgroundColor = const Color(0xFFCDFFE8), // colorShadeE
    this.hoverBackgroundColor = const Color(0xFFBBE8D3), // colorShadeD
    this.shadowColor = const Color(0xFF6AA389), // colorShadeA
    this.borderColor = const Color(0xFF6AA389), // colorShadeA
    this.textStyle = const TextStyle(
      color: Color(0xFF6AA389), // colorShadeA
      fontSize: 24,
      fontWeight: FontWeight.w700,
      fontFamily: 'OpenSans',
    ),
    this.depth = 8.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
  });
}
