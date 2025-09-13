import 'package:flutter/material.dart';

/// Defines the visual properties for the [PaperCard] widget.
@immutable
class PaperCardTheme {
  /// The background color of the card.
  final Color backgroundColor;

  /// The color of the card's border.
  final Color borderColor;

  /// The width of the card's border.
  final double borderWidth;

  /// The border radius of the card.
  final BorderRadius borderRadius;

  /// The box shadow for the card in its normal state.
  final BoxShadow shadow;

  /// The box shadow for the card when hovered.
  final BoxShadow hoverShadow;

  /// Creates a theme for the paper card widget.
  const PaperCardTheme({
    this.backgroundColor = Colors.white,
    this.borderColor = const Color(0xFFE0E0E0),
    this.borderWidth = 1.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
    this.shadow = const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.1),
      blurRadius: 10,
      offset: Offset(0, 5),
    ),
    this.hoverShadow = const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.15),
      blurRadius: 20,
      offset: Offset(0, 10),
    ),
  });
}
