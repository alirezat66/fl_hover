import 'package:flutter/material.dart';

/// Defines the visual properties for the [CursorShowcaseBox] widget.
@immutable
class CursorShowcaseBoxTheme {
  /// The background decoration of the box.
  final BoxDecoration decoration;

  /// The background decoration of the box when hovered.
  final BoxDecoration hoverDecoration;

  /// Creates a theme for the cursor showcase box widget.
  const CursorShowcaseBoxTheme({
    this.decoration = const BoxDecoration(
      color: Color(0xFF333333),
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    this.hoverDecoration = const BoxDecoration(
      color: Color(0xFF444444),
      borderRadius: BorderRadius.all(Radius.circular(12)),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10,
        )
      ],
    ),
  });
}
