import 'package:flutter/material.dart';

/// Represents a single item in the [AnimatedNavMenu].
class AnimatedNavMenuItem {
  /// The icon to display for this menu item.
  final IconData icon;

  /// The title text to display when the item is hovered.
  final String title;

  /// The gradient background for the item when it is hovered.
  final Gradient hoverGradient;

  /// The callback that is executed when the item is tapped.
  final VoidCallback onTap;

  /// Creates a menu item for the animated navigation menu.
  AnimatedNavMenuItem({
    required this.icon,
    required this.title,
    required this.hoverGradient,
    required this.onTap,
  });
}
