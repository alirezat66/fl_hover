import 'package:flutter/material.dart';

/// Represents a single data item in the [SlidingNavMenu].
/// The highlightColor is restored to allow per-item customization.
class SlidingNavMenuItem {
  /// The title text of the menu item.
  final String title;

  /// The callback that is executed when the item is tapped.
  final VoidCallback onTap;

  /// The highlight color for this specific item's border and slide-in background.
  /// This overrides any color set in the theme.
  final Color highlightColor;

  /// Creates an item for the sliding navigation menu.
  SlidingNavMenuItem({
    required this.title,
    required this.onTap,
    required this.highlightColor,
  });
}
