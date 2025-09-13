import 'package:flutter/material.dart';

/// Defines the visual properties for the [Button3DSocial] widget.
@immutable
class Button3DSocialTheme {
  /// The width of the button.
  final double width;

  /// The height of the button.
  final double height;

  /// The default background color of the main face.
  final Color backgroundColor;

  /// The color of the side and bottom faces that create the 3D effect.
  final Color depthColor;

  /// The background color on hover.
  final Color hoverBackgroundColor;

  /// The color of the side face on hover.
  final Color hoverSideColor;

  /// The color of the bottom face on hover.
  final Color hoverBottomColor;

  /// The box shadow for the button.
  final BoxShadow shadow;

  /// The box shadow on hover.
  final BoxShadow hoverShadow;

  /// Creates a theme for the 3D social button.
  const Button3DSocialTheme({
    this.width = 210.0,
    this.height = 80.0,
    this.backgroundColor = Colors.white,
    this.depthColor = const Color(0xFFb1b1b1),
    required this.hoverBackgroundColor,
    required this.hoverSideColor,
    required this.hoverBottomColor,
    this.shadow = const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.5),
      blurRadius: 10,
      offset: Offset(-20, 20),
    ),
    this.hoverShadow = const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.5),
      blurRadius: 50,
      offset: Offset(-50, 50),
    ),
  });
}
