import 'package:flutter/material.dart';

/// Defines the visual properties for the [CardSkew] widget.
@immutable
class CardSkewTheme {
  /// The width of the card.
  final double width;

  /// The height of the card.
  final double height;

  /// The list of gradients for the skewed background.
  /// The widget will cycle through these gradients.
  final List<Gradient> backgroundGradients;

  /// Creates a theme for the skewed card.
  const CardSkewTheme({
    this.width = 320.0,
    this.height = 400.0,
    this.backgroundGradients = const [
      LinearGradient(
        colors: [Color(0xffffbc00), Color(0xffff0058)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      LinearGradient(
        colors: [Color(0xff03a9f4), Color(0xffff0058)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      LinearGradient(
        colors: [Color(0xff4dff03), Color(0xff00d0ff)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ],
  });
}
