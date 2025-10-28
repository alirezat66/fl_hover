import 'package:flutter/material.dart';

/// Defines the direction in which the sliding background fills the menu item.
enum FillDirection {
  /// Fill from left to right
  leftToRight,

  /// Fill from right to left
  rightToLeft,

  /// Fill from top to bottom
  topToBottom,

  /// Fill from bottom to top
  bottomToTop,

  /// Fill from center outward horizontally
  centerHorizontal,

  /// Fill from center outward vertically
  centerVertical,
}

/// Extension to provide alignment and animation properties for FillDirection
extension FillDirectionExtension on FillDirection {
  /// Returns the alignment for the sliding background
  Alignment get alignment {
    switch (this) {
      case FillDirection.leftToRight:
        return Alignment.centerLeft;
      case FillDirection.rightToLeft:
        return Alignment.centerRight;
      case FillDirection.topToBottom:
        return Alignment.topCenter;
      case FillDirection.bottomToTop:
        return Alignment.bottomCenter;
      case FillDirection.centerHorizontal:
        return Alignment.center;
      case FillDirection.centerVertical:
        return Alignment.center;
    }
  }

  /// Returns true if the fill direction is horizontal
  bool get isHorizontal {
    return this == FillDirection.leftToRight ||
        this == FillDirection.rightToLeft ||
        this == FillDirection.centerHorizontal;
  }

  /// Returns true if the fill direction is vertical
  bool get isVertical {
    return this == FillDirection.topToBottom ||
        this == FillDirection.bottomToTop ||
        this == FillDirection.centerVertical;
  }

  /// Returns the display name for the fill direction
  String get displayName {
    switch (this) {
      case FillDirection.leftToRight:
        return 'Left to Right';
      case FillDirection.rightToLeft:
        return 'Right to Left';
      case FillDirection.topToBottom:
        return 'Top to Bottom';
      case FillDirection.bottomToTop:
        return 'Bottom to Top';
      case FillDirection.centerHorizontal:
        return 'Center Horizontal';
      case FillDirection.centerVertical:
        return 'Center Vertical';
    }
  }
}

