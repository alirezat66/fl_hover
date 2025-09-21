import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_hover_effects/src/playground/playground_property.dart';
import 'package:flutter_hover_effects/src/playground/playground_theme.dart';

/// Defines the visual properties for the [FlipCard] widget.
///
/// This theme allows for customization of border radius, colors, padding, and animation properties.
@immutable
class FlipCardTheme extends ThemeExtension<FlipCardTheme>
    implements PlaygroundTheme {
  /// The border radius for both the front and back faces of the card.
  final BorderRadius? borderRadius;

  /// The background color of the front face.
  final Color? frontBackgroundColor;

  /// The background color of the back face.
  final Color? backBackgroundColor;

  /// The padding inside the card.
  final EdgeInsets? padding;

  /// The width of the card.
  final double? width;

  /// The height of the card.
  final double? height;

  /// The duration of the flip animation.
  final Duration? animationDuration;

  /// The curve of the flip animation.
  final Curve? animationCurve;

  /// The perspective value for the 3D effect.
  final double? perspective;

  /// Creates a theme for the flip card.
  const FlipCardTheme({
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.frontBackgroundColor = const Color(0xFF2196F3),
    this.backBackgroundColor = const Color(0xFF4CAF50),
    this.padding = const EdgeInsets.all(16.0),
    this.width = 300.0,
    this.height = 200.0,
    this.animationDuration = const Duration(milliseconds: 600),
    this.animationCurve = Curves.easeInOut,
    this.perspective = 0.001,
  });

  @override
  ThemeExtension<FlipCardTheme> copyWith({
    BorderRadius? borderRadius,
    Color? frontBackgroundColor,
    Color? backBackgroundColor,
    EdgeInsets? padding,
    double? width,
    double? height,
    Duration? animationDuration,
    Curve? animationCurve,
    double? perspective,
  }) {
    return FlipCardTheme(
      borderRadius: borderRadius ?? this.borderRadius,
      frontBackgroundColor: frontBackgroundColor ?? this.frontBackgroundColor,
      backBackgroundColor: backBackgroundColor ?? this.backBackgroundColor,
      padding: padding ?? this.padding,
      width: width ?? this.width,
      height: height ?? this.height,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      perspective: perspective ?? this.perspective,
    );
  }

  @override
  ThemeExtension<FlipCardTheme> lerp(
      ThemeExtension<FlipCardTheme>? other, double t) {
    if (other is! FlipCardTheme) return this;

    return FlipCardTheme(
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t),
      frontBackgroundColor:
          Color.lerp(frontBackgroundColor, other.frontBackgroundColor, t),
      backBackgroundColor:
          Color.lerp(backBackgroundColor, other.backBackgroundColor, t),
      padding: EdgeInsets.lerp(padding, other.padding, t),
      width: ui.lerpDouble(width, other.width, t),
      height: ui.lerpDouble(height, other.height, t),
      animationDuration: Duration(
        milliseconds: ((animationDuration?.inMilliseconds ?? 600) * (1 - t) +
                (other.animationDuration?.inMilliseconds ?? 600) * t)
            .round(),
      ),
      perspective: ui.lerpDouble(perspective, other.perspective, t),
    );
  }

  @override
  List<EditableProperty> getEditableProperties(
      Function(PlaygroundTheme) onUpdate) {
    return [
      EditableProperty<BorderRadius?>(
        label: 'Border Radius',
        value: borderRadius,
        onChanged: (value) => onUpdate(
            copyWith(borderRadius: value as BorderRadius?) as PlaygroundTheme),
      ),
      EditableProperty<Color?>(
        label: 'Front Background Color',
        value: frontBackgroundColor,
        onChanged: (value) => onUpdate(
            copyWith(frontBackgroundColor: value as Color?) as PlaygroundTheme),
      ),
      EditableProperty<Color?>(
        label: 'Back Background Color',
        value: backBackgroundColor,
        onChanged: (value) => onUpdate(
            copyWith(backBackgroundColor: value as Color?) as PlaygroundTheme),
      ),
      EditableProperty<EdgeInsets?>(
        label: 'Padding',
        value: padding,
        onChanged: (value) => onUpdate(
            copyWith(padding: value as EdgeInsets?) as PlaygroundTheme),
      ),
      EditableProperty<double?>(
        label: 'Width',
        value: width,
        min: 100.0,
        max: 500.0,
        onChanged: (value) =>
            onUpdate(copyWith(width: value as double?) as PlaygroundTheme),
      ),
      EditableProperty<double?>(
        label: 'Height',
        value: height,
        min: 100.0,
        max: 400.0,
        onChanged: (value) =>
            onUpdate(copyWith(height: value as double?) as PlaygroundTheme),
      ),
      EditableProperty<Duration?>(
        label: 'Animation Duration',
        value: animationDuration,
        onChanged: (value) => onUpdate(
            copyWith(animationDuration: value as Duration?) as PlaygroundTheme),
      ),
      EditableProperty<double?>(
        label: 'Perspective',
        value: perspective,
        min: 0.0001,
        max: 0.01,
        onChanged: (value) => onUpdate(
            copyWith(perspective: value as double?) as PlaygroundTheme),
      ),
    ];
  }
}
