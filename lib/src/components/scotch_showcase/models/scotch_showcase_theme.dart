import 'package:flutter/material.dart';

/// Defines the visual properties for the [ScotchShowcase] widget.
@immutable
class ScotchShowcaseTheme {
  /// The main dark color for the background.
  final Color darkColor;

  /// The lighter dark color for background stripes.
  final Color midDarkColor;

  /// The main light color for text.
  final Color lightColor;

  /// The mid-range light color for secondary text.
  final Color midLightColor;

  /// The text style for the main title (e.g., "Scotch").
  final TextStyle titleStyle;

  /// The text style for the subtitle (e.g., "VIDEOCASSETTE EG").
  final TextStyle subtitleStyle;

  /// The text style for the product code (e.g., "T 120").
  final TextStyle codeStyle;

  /// The text style for the description paragraph.
  final TextStyle descriptionStyle;

  /// The gradient for the sphere.
  final Gradient sphereGradient;

  /// Creates a theme for the Scotch Showcase widget.
  const ScotchShowcaseTheme({
    this.darkColor = const Color(0xFF191F1D),
    this.midDarkColor = const Color(0xFF555A57),
    this.lightColor = const Color(0xFFECE0C8),
    this.midLightColor = const Color(0xFF949993),
    this.titleStyle = const TextStyle(
        fontFamily: 'Mulish',
        fontWeight: FontWeight.w900,
        fontSize: 64,
        color: Color(0xFFECE0C8)),
    this.subtitleStyle = const TextStyle(
        fontFamily: 'Playfair', fontSize: 16, color: Color(0xFF949993)),
    this.codeStyle = const TextStyle(
        fontFamily: 'DMSerifDisplay', fontSize: 24, color: Color(0xFF949993)),
    this.descriptionStyle = const TextStyle(
        fontFamily: 'Mulish',
        fontWeight: FontWeight.w700,
        color: Color(0xFF949993)),
    this.sphereGradient = const RadialGradient(
      colors: [
        Color(0xFFEDE6BF),
        Color(0xFFECC947),
        Color(0xFFCB5A31),
        Color(0xFF6F5D79),
        Color(0xFF4E779A),
      ],
      center: Alignment.topLeft,
      radius: 1.5,
    ),
  });
}
