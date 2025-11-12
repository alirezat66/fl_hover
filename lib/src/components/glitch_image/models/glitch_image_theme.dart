import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:fl_hover/src/playground/playground_property.dart';
import 'package:fl_hover/src/playground/playground_theme.dart';

/// Theme configuration for the [GlitchImage] widget.
class GlitchImageTheme extends ThemeExtension<GlitchImageTheme>
    implements PlaygroundTheme {
  /// Width of the widget.
  final double width;

  /// Height of the widget.
  final double height;

  const GlitchImageTheme({
    this.width = 600,
    this.height = 400,
  });

  @override
  GlitchImageTheme copyWith({
    double? width,
    double? height,
  }) {
    return GlitchImageTheme(
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }

  @override
  GlitchImageTheme lerp(ThemeExtension<GlitchImageTheme>? other, double t) {
    if (other is! GlitchImageTheme) return this;
    return GlitchImageTheme(
      width: lerpDouble(width, other.width, t) ?? width,
      height: lerpDouble(height, other.height, t) ?? height,
    );
  }

  @override
  List<EditableProperty> getEditableProperties(
      void Function(PlaygroundTheme newTheme) onUpdate) {
    return [
      EditableProperty<double>(
        label: 'Width',
        value: width,
        min: 200,
        max: 800,
        onChanged: (value) =>
            onUpdate(copyWith(width: (value as num).toDouble())),
      ),
      EditableProperty<double>(
        label: 'Height',
        value: height,
        min: 150,
        max: 600,
        onChanged: (value) =>
            onUpdate(copyWith(height: (value as num).toDouble())),
      ),
    ];
  }
}
