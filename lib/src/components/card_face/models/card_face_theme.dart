import 'package:flutter/material.dart';

/// Defines the visual properties for the [CardFace] widget.
@immutable
class CardFaceTheme {
  /// The width of the card.
  final double width;

  /// The height of the card.
  final double height;

  /// The border radius for the card.
  final BorderRadius borderRadius;

  /// The height of the top face when it's shrunk (on hover).
  final double shrunkenHeight;

  /// The box shadow for the card.
  final BoxShadow shadow;

  /// Creates a theme for the card face widget.
  const CardFaceTheme({
    this.width = 300.0,
    this.height = 400.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(15)),
    this.shrunkenHeight = 60.0,
    this.shadow = const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.5),
      blurRadius: 60,
      spreadRadius: 0,
      offset: Offset(0, 15),
    ),
  });
}
