import 'package:flutter/material.dart';

/// Defines the visual properties for the [AnimatedIconWidget] widget.
@immutable
class AnimatedIconTheme {
  /// The size of the icon container (width and height).
  final double size;

  /// The size of the icon itself.
  final double iconSize;

  /// The color of the icon.
  final Color iconColor;

  /// The background color for the left half of the icon container.
  final Color leftBackgroundColor;

  /// The background color for the sliding overlay that appears on hover.
  final Color hoverOverlayColor;

  /// Creates a theme for the animated icon.
  const AnimatedIconTheme({
    this.size = 100.0,
    this.iconSize = 50.0,
    this.iconColor = Colors.white,
    this.leftBackgroundColor = const Color(0xFFd35400),
    this.hoverOverlayColor = const Color(0xFFe67e22),
  });
}
