import 'package:flutter/material.dart';

/// Defines the visual properties for the [HolographicCard] widget.
///
/// This theme allows customization of colors, shadows, and text style to
/// match your application's design.
@immutable
class HolographicCardTheme {
  /// The background color of the card.
  final Color backgroundColor;

  /// The primary color of the shimmering holographic effect.
  final Color shineColor;

  /// The color of the glow/shadow effect when the card is hovered.
  final Color glowColor;

  /// The text style for the content displayed on the card.
  final TextStyle textStyle;

  /// The border radius for the card's corners.
  final BorderRadius borderRadius;

  /// Creates a theme for the holographic card.
  ///
  /// A default theme is provided that closely matches the original CSS effect.
  const HolographicCardTheme({
    this.backgroundColor = const Color(0xFF111111),
    this.shineColor = const Color(0x4D00FFFF), // rgba(0, 255, 255, 0.3)
    this.glowColor = const Color(0x8000FFFF), // rgba(0, 255, 255, 0.5)
    this.textStyle = const TextStyle(
      color: Color(0xFF00FFFF),
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    this.borderRadius = const BorderRadius.all(Radius.circular(15)),
  });
}
