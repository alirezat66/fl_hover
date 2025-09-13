import 'package:flutter/material.dart';

/// Defines the visual properties for the [SlidingNavMenu] widget.
@immutable
class SlidingNavMenuTheme {
  /// The decoration for the entire menu container. If null, the background
  /// will be transparent.
  final BoxDecoration? menuDecoration;

  /// The fixed height for each menu item to ensure perfect alignment.
  final double itemHeight;

  /// The text style for the item's title in its normal state.
  final TextStyle? itemTextStyle;

  /// The text style for the item's title when hovered.
  final TextStyle? itemHoverTextStyle;

  /// The width/height of the highlight bar that is visible when the item
  /// is not hovered. Defaults to 0.
  final double peekSize;

  /// The direction from which the sliding background animates.
  final AxisDirection slideDirection;

  /// The duration of the slide and text color animations.
  final Duration animationDuration;

  /// Creates a theme for the [SlidingNavMenu].
  const SlidingNavMenuTheme({
    this.menuDecoration = const BoxDecoration(color: Color(0xFFEEEEEE)),
    this.itemHeight = 60.0,
    this.itemTextStyle =
        const TextStyle(color: Color(0xFF444444), fontSize: 16),
    this.itemHoverTextStyle =
        const TextStyle(color: Colors.white, fontSize: 16),
    this.peekSize = 0.0,
    this.slideDirection = AxisDirection.left,
    this.animationDuration = const Duration(milliseconds: 300),
  });
}
