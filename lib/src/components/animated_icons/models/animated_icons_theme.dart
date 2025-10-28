import 'package:flutter/material.dart';
import 'package:fl_hover/fl_hover.dart';

/// Defines the visual properties for the [AnimatedHoverIcons] widget.
@immutable
class AnimatedIconsTheme extends ThemeExtension<AnimatedIconsTheme>
    implements PlaygroundTheme {
  /// The background color of the container.
  final Color backgroundColor;

  /// The size of each icon.
  final double iconSize;

  /// The spacing between icons.
  final double spacing;

  /// The background color of the icons.
  final Color iconBackgroundColor;

  /// The color of the icons.
  final Color iconColor;

  /// The duration of the hover animations.
  final Duration animationDuration;

  /// The curve for the animations.
  final Curve animationCurve;

  /// The rotation angle for the icons (in degrees).
  final double rotationAngle;

  /// The hover background color.
  final Color hoverBackgroundColor;

  /// The hover background opacity.
  final double hoverBackgroundOpacity;

  /// Creates a theme for the [AnimatedHoverIcons].
  const AnimatedIconsTheme({
    this.backgroundColor = const Color(0xFF262626), // Like CSS background
    this.iconSize = 100.0, // Like CSS width/height: 100px
    this.spacing = 10.0, // Like CSS margin: 10px
    this.iconBackgroundColor =
        const Color(0xFFd35400), // Like CSS background: #d35400
    this.iconColor = Colors.white, // Like CSS color: #fff
    this.animationDuration =
        const Duration(milliseconds: 500), // Like CSS transition: .5s
    this.animationCurve =
        Curves.easeInOut, // Like CSS transition: .5s ease-in-out
    this.rotationAngle = 45.0, // Like CSS transform: rotate(45deg)
    this.hoverBackgroundColor =
        const Color(0xFFe67e22), // Like CSS background: #e67e22
    this.hoverBackgroundOpacity = 0.7, // Like CSS opacity: .7
  });

  @override
  ThemeExtension<AnimatedIconsTheme> copyWith({
    Color? backgroundColor,
    double? iconSize,
    double? spacing,
    Color? iconBackgroundColor,
    Color? iconColor,
    Duration? animationDuration,
    Curve? animationCurve,
    double? rotationAngle,
    Color? hoverBackgroundColor,
    double? hoverBackgroundOpacity,
  }) {
    return AnimatedIconsTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      iconSize: iconSize ?? this.iconSize,
      spacing: spacing ?? this.spacing,
      iconBackgroundColor: iconBackgroundColor ?? this.iconBackgroundColor,
      iconColor: iconColor ?? this.iconColor,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      rotationAngle: rotationAngle ?? this.rotationAngle,
      hoverBackgroundColor: hoverBackgroundColor ?? this.hoverBackgroundColor,
      hoverBackgroundOpacity:
          hoverBackgroundOpacity ?? this.hoverBackgroundOpacity,
    );
  }

  @override
  ThemeExtension<AnimatedIconsTheme> lerp(
    ThemeExtension<AnimatedIconsTheme>? other,
    double t,
  ) {
    if (other is! AnimatedIconsTheme) {
      return this;
    }
    return AnimatedIconsTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ??
          backgroundColor,
      iconSize: lerpDouble(iconSize, other.iconSize, t) ?? iconSize,
      spacing: lerpDouble(spacing, other.spacing, t) ?? spacing,
      iconBackgroundColor:
          Color.lerp(iconBackgroundColor, other.iconBackgroundColor, t) ??
              iconBackgroundColor,
      iconColor: Color.lerp(iconColor, other.iconColor, t) ?? iconColor,
      rotationAngle:
          lerpDouble(rotationAngle, other.rotationAngle, t) ?? rotationAngle,
      hoverBackgroundColor:
          Color.lerp(hoverBackgroundColor, other.hoverBackgroundColor, t) ??
              hoverBackgroundColor,
      hoverBackgroundOpacity:
          lerpDouble(hoverBackgroundOpacity, other.hoverBackgroundOpacity, t) ??
              hoverBackgroundOpacity,
      // Duration and Curve can't be linearly interpolated
      animationDuration: t > 0.5 ? other.animationDuration : animationDuration,
      animationCurve: t > 0.5 ? other.animationCurve : animationCurve,
    );
  }

  // Helper function for lerpDouble
  static double? lerpDouble(double? a, double? b, double t) {
    if (a == null || b == null) return t < 0.5 ? a : b;
    return a + (b - a) * t;
  }

  @override
  List<EditableProperty> getEditableProperties(
    void Function(PlaygroundTheme newTheme) onUpdate,
  ) {
    return [
      EditableProperty<Color?>(
        label: 'Background Color',
        value: backgroundColor,
        onChanged: (value) => onUpdate(
            copyWith(backgroundColor: value as Color?) as PlaygroundTheme),
      ),
      EditableProperty<double?>(
        label: 'Icon Size',
        value: iconSize,
        min: 60.0,
        max: 150.0,
        onChanged: (value) => onUpdate(
            copyWith(iconSize: (value as num).toDouble()) as PlaygroundTheme),
      ),
      EditableProperty<double?>(
        label: 'Spacing',
        value: spacing,
        min: 5.0,
        max: 30.0,
        onChanged: (value) => onUpdate(
            copyWith(spacing: (value as num).toDouble()) as PlaygroundTheme),
      ),
      EditableProperty<Color?>(
        label: 'Icon Background Color',
        value: iconBackgroundColor,
        onChanged: (value) => onUpdate(
            copyWith(iconBackgroundColor: value as Color?) as PlaygroundTheme),
      ),
      EditableProperty<Color?>(
        label: 'Icon Color',
        value: iconColor,
        onChanged: (value) =>
            onUpdate(copyWith(iconColor: value as Color?) as PlaygroundTheme),
      ),
      EditableProperty<double?>(
        label: 'Rotation Angle',
        value: rotationAngle,
        min: 0.0,
        max: 360.0,
        onChanged: (value) => onUpdate(
            copyWith(rotationAngle: (value as num).toDouble())
                as PlaygroundTheme),
      ),
      EditableProperty<Color?>(
        label: 'Hover Background Color',
        value: hoverBackgroundColor,
        onChanged: (value) => onUpdate(
            copyWith(hoverBackgroundColor: value as Color?) as PlaygroundTheme),
      ),
      EditableProperty<double?>(
        label: 'Hover Background Opacity',
        value: hoverBackgroundOpacity,
        min: 0.0,
        max: 1.0,
        onChanged: (value) => onUpdate(
            copyWith(hoverBackgroundOpacity: (value as num).toDouble())
                as PlaygroundTheme),
      ),
      EditableProperty<Duration?>(
        label: 'Animation Duration',
        value: animationDuration,
        onChanged: (value) => onUpdate(
            copyWith(animationDuration: value as Duration?) as PlaygroundTheme),
      ),
      EditableProperty<String?>(
        label: 'Animation Curve',
        value: animationCurve.toString(),
        onChanged: (value) {
          final curve = _getCurveFromString(value ?? 'easeInOut');
          onUpdate(copyWith(animationCurve: curve) as PlaygroundTheme);
        },
      ),
    ];
  }

  // Helper method to convert string to Curve
  static Curve _getCurveFromString(String curveName) {
    switch (curveName) {
      case 'easeInOut':
        return Curves.easeInOut;
      case 'easeIn':
        return Curves.easeIn;
      case 'easeOut':
        return Curves.easeOut;
      case 'ease':
        return Curves.ease;
      case 'linear':
        return Curves.linear;
      case 'fastOutSlowIn':
        return Curves.fastOutSlowIn;
      case 'bounceIn':
        return Curves.bounceIn;
      case 'bounceOut':
        return Curves.bounceOut;
      case 'elasticIn':
        return Curves.elasticIn;
      case 'elasticOut':
        return Curves.elasticOut;
      default:
        return Curves.easeInOut;
    }
  }
}
