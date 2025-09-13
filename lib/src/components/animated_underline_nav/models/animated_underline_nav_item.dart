import 'package:flutter/material.dart';

/// Represents a single item in the [AnimatedUnderlineNav].
class AnimatedUnderlineNavItem {
  /// The title text of the menu item.
  final String title;

  /// The callback that is executed when the item is tapped.
  final VoidCallback onTap;

  /// Creates an item for the animated underline navigation menu.
  AnimatedUnderlineNavItem({
    required this.title,
    required this.onTap,
  });
}
