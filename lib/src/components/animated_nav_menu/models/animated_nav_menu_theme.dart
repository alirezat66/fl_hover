import 'package:flutter/material.dart';
import 'package:flutter_hover_effects/hover_effects.dart';

/// Defines the visual properties for the [AnimatedNavMenu] widget.
@immutable
class AnimatedNavMenuTheme extends ThemeExtension<AnimatedNavMenuTheme>
    implements PlaygroundTheme {
  final double itemSize;
  final double itemHoverWidth;
  final double spacing;
  final Duration animationDuration;
  final Curve animationCurve;
  final Color iconColor;
  final Color textColor;
  final double iconSize;
  final double textSize;
  final FontWeight textWeight;

  const AnimatedNavMenuTheme({
    this.itemSize = 60.0,
    this.itemHoverWidth = 180.0,
    this.spacing = 25.0,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeOut,
    this.iconColor = const Color(0xFF777777),
    this.textColor = Colors.white,
    this.iconSize = 0.45,
    this.textSize = 0.25,
    this.textWeight = FontWeight.bold,
  });

  @override
  ThemeExtension<AnimatedNavMenuTheme> copyWith({
    double? itemSize,
    double? itemHoverWidth,
    double? spacing,
    Duration? animationDuration,
    Curve? animationCurve,
    Color? iconColor,
    Color? textColor,
    double? iconSize,
    double? textSize,
    FontWeight? textWeight,
  }) {
    return AnimatedNavMenuTheme(
      itemSize: itemSize ?? this.itemSize,
      itemHoverWidth: itemHoverWidth ?? this.itemHoverWidth,
      spacing: spacing ?? this.spacing,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      iconColor: iconColor ?? this.iconColor,
      textColor: textColor ?? this.textColor,
      iconSize: iconSize ?? this.iconSize,
      textSize: textSize ?? this.textSize,
      textWeight: textWeight ?? this.textWeight,
    );
  }

  @override
  ThemeExtension<AnimatedNavMenuTheme> lerp(
    ThemeExtension<AnimatedNavMenuTheme>? other,
    double t,
  ) {
    if (other is! AnimatedNavMenuTheme) {
      return this;
    }
    return AnimatedNavMenuTheme(
      itemSize: lerpDouble(itemSize, other.itemSize, t) ?? itemSize,
      itemHoverWidth:
          lerpDouble(itemHoverWidth, other.itemHoverWidth, t) ?? itemHoverWidth,
      spacing: lerpDouble(spacing, other.spacing, t) ?? spacing,
      iconColor: Color.lerp(iconColor, other.iconColor, t) ?? iconColor,
      textColor: Color.lerp(textColor, other.textColor, t) ?? textColor,
      iconSize: lerpDouble(iconSize, other.iconSize, t) ?? iconSize,
      textSize: lerpDouble(textSize, other.textSize, t) ?? textSize,
      // Duration, Curve and FontWeight can't be linearly interpolated
      animationDuration: t > 0.5 ? other.animationDuration : animationDuration,
      animationCurve: t > 0.5 ? other.animationCurve : animationCurve,
      textWeight: t > 0.5 ? other.textWeight : textWeight,
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
      EditableProperty<double?>(
        label: 'Item Size',
        value: itemSize,
        min: 40.0,
        max: 100.0,
        onChanged: (value) => onUpdate(
            copyWith(itemSize: (value as num).toDouble()) as PlaygroundTheme),
      ),
      EditableProperty<double?>(
        label: 'Hover Width',
        value: itemHoverWidth,
        min: 120.0,
        max: 250.0,
        onChanged: (value) => onUpdate(
            copyWith(itemHoverWidth: (value as num).toDouble())
                as PlaygroundTheme),
      ),
      EditableProperty<double?>(
        label: 'Spacing',
        value: spacing,
        min: 10.0,
        max: 50.0,
        onChanged: (value) => onUpdate(
            copyWith(spacing: (value as num).toDouble()) as PlaygroundTheme),
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
          final curve = _getCurveFromString(value ?? 'easeOut');
          onUpdate(copyWith(animationCurve: curve) as PlaygroundTheme);
        },
      ),
      EditableProperty<Color?>(
        label: 'Icon Color',
        value: iconColor,
        onChanged: (value) =>
            onUpdate(copyWith(iconColor: value as Color?) as PlaygroundTheme),
      ),
      EditableProperty<Color?>(
        label: 'Text Color',
        value: textColor,
        onChanged: (value) =>
            onUpdate(copyWith(textColor: value as Color?) as PlaygroundTheme),
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
        return Curves.easeOut;
    }
  }
}
