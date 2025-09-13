import 'package:flutter/material.dart';

/// Defines the visual properties for the [RotatingCube] widget.
@immutable
class RotatingCubeTheme {
  /// The size (width and height) of each face of the cube.
  final double faceSize;

  /// The text style for the content displayed on each face.
  final TextStyle textStyle;

  /// The border for each face of the cube.
  final Border border;

  /// The background gradient for each face.
  final Gradient backgroundGradient;

  /// Creates a theme for the rotating cube.
  const RotatingCubeTheme({
    this.faceSize = 200.0,
    this.textStyle = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    this.border = const Border.fromBorderSide(
      BorderSide(color: Color(0xFF646CFF), width: 2),
    ),
    this.backgroundGradient = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF2A2A2A), Color(0xFF383838)],
    ),
  });
}
