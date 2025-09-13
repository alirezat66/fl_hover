import 'package:flutter/material.dart';

/// Defines the visual properties for the [CardSlide] widget.
@immutable
class CardSlideTheme {
  /// The total width of the card.
  final double width;

  /// The total height of the card.
  final double height;

  /// The box shadow for the bottom slide, which becomes visible on hover.
  final BoxShadow bottomSlideShadow;

  /// Creates a theme for the card slide widget.
  const CardSlideTheme({
    this.width = 300.0,
    this.height = 350.0,
    this.bottomSlideShadow = const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.4),
      blurRadius: 40,
      spreadRadius: 0,
      offset: Offset(0, 20),
    ),
  });
}
