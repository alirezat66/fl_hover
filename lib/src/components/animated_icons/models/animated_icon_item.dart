import 'package:flutter/material.dart';

/// Represents a single icon in the [AnimatedHoverIcons] widget.
class AnimatedIconItem {
  /// The icon to display (e.g., Icons.calculate, Icons.directions_car, etc.)
  final IconData icon;

  /// The background color for this icon on hover
  final Color hoverColor;

  /// The callback to execute when this icon is tapped
  final VoidCallback? onTap;

  /// The tooltip text to show when hovering
  final String? tooltip;

  /// Creates an [AnimatedIconItem].
  const AnimatedIconItem({
    required this.icon,
    required this.hoverColor,
    this.onTap,
    this.tooltip,
  });

  /// Creates a copy of this icon with the given fields replaced with new values.
  AnimatedIconItem copyWith({
    IconData? icon,
    Color? hoverColor,
    VoidCallback? onTap,
    String? tooltip,
  }) {
    return AnimatedIconItem(
      icon: icon ?? this.icon,
      hoverColor: hoverColor ?? this.hoverColor,
      onTap: onTap ?? this.onTap,
      tooltip: tooltip ?? this.tooltip,
    );
  }
}
