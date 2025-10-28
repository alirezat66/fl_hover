import 'package:flutter/material.dart';
import 'package:fl_hover/fl_hover.dart';

/// Defines the visual properties for the [AnimatedFillIcon] widget.
@immutable
class AnimatedFillIconTheme extends ThemeExtension<AnimatedFillIconTheme>
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

  /// The border color of the icons.
  final Color borderColor;

  /// The border width of the icons.
  final double borderWidth;

  /// The duration of the hover animations.
  final Duration animationDuration;

  /// The curve for the animations.
  final Curve animationCurve;

  /// The hover elevation (shadow).
  final double hoverElevation;

  /// The hover scale factor.
  final double hoverScale;

  /// The hover translate Y offset.
  final double hoverTranslateY;

  /// The direction of the color fill animation.
  final FillDirection fillDirection;

  /// Creates a theme for the [AnimatedFillIcon].
  const AnimatedFillIconTheme({
    this.backgroundColor = const Color(0xFF262626), // Like CSS background
    this.iconSize = 80.0, // Like CSS width/height: 80px
    this.spacing = 10.0, // Like CSS margin: 0 10px
    this.iconBackgroundColor = Colors.white, // Like CSS background-color: #fff
    this.iconColor = const Color(0xFF262626), // Like CSS color: #262626
    this.borderColor = Colors.white, // Like CSS border: 3px solid #fff
    this.borderWidth = 3.0, // Like CSS border: 3px solid #fff
    this.animationDuration =
        const Duration(milliseconds: 500), // Like CSS transition: .5s
    this.animationCurve = Curves.ease, // Like CSS transition: all 0.3s ease
    this.hoverElevation = 15.0, // Like CSS box-shadow: 0 15px 30px
    this.hoverScale = 1.1, // Like CSS scale(1.1)
    this.hoverTranslateY = -10.0, // Like CSS translateY(-10px)
    this.fillDirection = FillDirection.bottomToTop, // Default fill direction
  });

  @override
  ThemeExtension<AnimatedFillIconTheme> copyWith({
    Color? backgroundColor,
    double? iconSize,
    double? spacing,
    Color? iconBackgroundColor,
    Color? iconColor,
    Color? borderColor,
    double? borderWidth,
    Duration? animationDuration,
    Curve? animationCurve,
    double? hoverElevation,
    double? hoverScale,
    double? hoverTranslateY,
    FillDirection? fillDirection,
  }) {
    return AnimatedFillIconTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      iconSize: iconSize ?? this.iconSize,
      spacing: spacing ?? this.spacing,
      iconBackgroundColor: iconBackgroundColor ?? this.iconBackgroundColor,
      iconColor: iconColor ?? this.iconColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      hoverElevation: hoverElevation ?? this.hoverElevation,
      hoverScale: hoverScale ?? this.hoverScale,
      hoverTranslateY: hoverTranslateY ?? this.hoverTranslateY,
      fillDirection: fillDirection ?? this.fillDirection,
    );
  }

  @override
  ThemeExtension<AnimatedFillIconTheme> lerp(
    ThemeExtension<AnimatedFillIconTheme>? other,
    double t,
  ) {
    if (other is! AnimatedFillIconTheme) {
      return this;
    }
    return AnimatedFillIconTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ??
          backgroundColor,
      iconSize: lerpDouble(iconSize, other.iconSize, t) ?? iconSize,
      spacing: lerpDouble(spacing, other.spacing, t) ?? spacing,
      iconBackgroundColor:
          Color.lerp(iconBackgroundColor, other.iconBackgroundColor, t) ??
              iconBackgroundColor,
      iconColor: Color.lerp(iconColor, other.iconColor, t) ?? iconColor,
      borderColor: Color.lerp(borderColor, other.borderColor, t) ?? borderColor,
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t) ?? borderWidth,
      hoverElevation:
          lerpDouble(hoverElevation, other.hoverElevation, t) ?? hoverElevation,
      hoverScale: lerpDouble(hoverScale, other.hoverScale, t) ?? hoverScale,
      hoverTranslateY: lerpDouble(hoverTranslateY, other.hoverTranslateY, t) ??
          hoverTranslateY,
      // Duration, Curve, and FillDirection can't be linearly interpolated
      animationDuration: t > 0.5 ? other.animationDuration : animationDuration,
      animationCurve: t > 0.5 ? other.animationCurve : animationCurve,
      fillDirection: t > 0.5 ? other.fillDirection : fillDirection,
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
        min: 40.0,
        max: 120.0,
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
      EditableProperty<Color?>(
        label: 'Border Color',
        value: borderColor,
        onChanged: (value) =>
            onUpdate(copyWith(borderColor: value as Color?) as PlaygroundTheme),
      ),
      EditableProperty<double?>(
        label: 'Border Width',
        value: borderWidth,
        min: 0.0,
        max: 10.0,
        onChanged: (value) => onUpdate(
            copyWith(borderWidth: (value as num).toDouble())
                as PlaygroundTheme),
      ),
      EditableProperty<double?>(
        label: 'Hover Scale',
        value: hoverScale,
        min: 1.0,
        max: 2.0,
        onChanged: (value) => onUpdate(
            copyWith(hoverScale: (value as num).toDouble()) as PlaygroundTheme),
      ),
      EditableProperty<double?>(
        label: 'Hover Translate Y',
        value: hoverTranslateY,
        min: -30.0,
        max: 0.0,
        onChanged: (value) => onUpdate(
            copyWith(hoverTranslateY: (value as num).toDouble())
                as PlaygroundTheme),
      ),
      EditableProperty<Duration?>(
        label: 'Animation Duration',
        value: animationDuration,
        onChanged: (value) => onUpdate(
            copyWith(animationDuration: value as Duration?) as PlaygroundTheme),
      ),
      EditableProperty<String?>(
        label: 'Fill Direction',
        value: fillDirection.displayName,
        onChanged: (value) {
          final direction = _getFillDirectionFromString(value ?? 'bottomToTop');
          onUpdate(copyWith(fillDirection: direction) as PlaygroundTheme);
        },
      ),
    ];
  }

  // Helper method to convert string to FillDirection
  static FillDirection _getFillDirectionFromString(String directionName) {
    switch (directionName) {
      case 'Bottom to Top':
        return FillDirection.bottomToTop;
      case 'Top to Bottom':
        return FillDirection.topToBottom;
      case 'Left to Right':
        return FillDirection.leftToRight;
      case 'Right to Left':
        return FillDirection.rightToLeft;
      default:
        return FillDirection.bottomToTop;
    }
  }
}
