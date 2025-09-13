import 'package:flutter/material.dart';

/// Defines the visual properties for the [SocialIconButton] widget.
@immutable
class SocialIconButtonTheme {
  /// The size of the button (width and height).
  final double size;

  /// The size of the icon inside the button.
  final double iconSize;

  /// The default background color of the button.
  final Color backgroundColor;

  /// The default color of the icon.
  final Color iconColor;

  /// The border for the button.
  final Border border;

  /// The color that fills the button on hover.
  final Color hoverFillColor;

  /// The color of the icon on hover.
  final Color hoverIconColor;

  /// The box shadow that appears on hover.
  final BoxShadow hoverShadow;

  /// Creates a theme for the social icon button.
  const SocialIconButtonTheme({
    this.size = 80.0,
    this.iconSize = 35.0,
    this.backgroundColor = Colors.white,
    this.iconColor = const Color(0xFF262626),
    this.border = const Border.fromBorderSide(
      BorderSide(color: Colors.white, width: 3),
    ),
    required this.hoverFillColor,
    this.hoverIconColor = Colors.white,
    this.hoverShadow = const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.3),
      blurRadius: 30,
      offset: Offset(0, 15),
    ),
  });
}
