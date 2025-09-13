import 'package:flutter/material.dart';

/// Represents a single item in the [SlidingNavMenu].
class SlidingNavMenuItem {
  /// The title text of the menu item.
  final String title;

  /// The callback that is executed when the item is tapped.
  final VoidCallback onTap;

  /// The color of the left border and the slide-in background on hover.
  final Color highlightColor;

  /// Creates an item for the sliding navigation menu.
  SlidingNavMenuItem({
    required this.title,
    required this.onTap,
    required this.highlightColor,
  });
}
