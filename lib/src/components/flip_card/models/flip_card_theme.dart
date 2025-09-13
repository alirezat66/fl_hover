import 'package:flutter/material.dart';

/// Defines the visual properties for the [FlipCard] widget.
///
/// This theme allows for basic customization such as border radius.
/// The content's background should be defined within the front and back widgets themselves.
@immutable
class FlipCardTheme {
  /// The border radius for both the front and back faces of the card.
  final BorderRadius borderRadius;

  /// Creates a theme for the flip card.
  const FlipCardTheme({
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });
}
