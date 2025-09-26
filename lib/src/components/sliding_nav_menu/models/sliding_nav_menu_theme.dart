import 'package:flutter/material.dart';
import 'package:flutter_hover_effects/hover_effects.dart';

/// Defines the visual properties for the [SlidingNavMenu] widget.
@immutable
class SlidingNavMenuTheme extends ThemeExtension<SlidingNavMenuTheme>
    implements PlaygroundTheme {
  /// The decoration for the entire menu container. If null, the background
  /// will be transparent.
  final BoxDecoration? menuDecoration;

  /// The fixed height for each menu item to ensure perfect alignment.
  final double itemHeight;

  /// The text style for the item's title in its normal state.
  final TextStyle? itemTextStyle;

  /// The text style for the item's title when hovered.
  final TextStyle? itemHoverTextStyle;

  /// The width/height of the highlight bar that is visible when the item
  /// is not hovered. Defaults to 0.
  final double peekSize;

  /// The direction in which the background fills the item.
  final FillDirection fillDirection;

  /// The curve for the animation.
  final Curve animationCurve;

  /// The duration of the slide and text color animations.
  final Duration animationDuration;

  /// Creates a theme for the [SlidingNavMenu].
  const SlidingNavMenuTheme({
    this.menuDecoration = const BoxDecoration(color: Color(0xFFEEEEEE)),
    this.itemHeight = 60.0,
    this.itemTextStyle =
        const TextStyle(color: Color(0xFF444444), fontSize: 16),
    this.itemHoverTextStyle =
        const TextStyle(color: Colors.white, fontSize: 16),
    this.peekSize = 0.0,
    this.fillDirection = FillDirection.leftToRight,
    this.animationCurve = Curves.easeOut,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  ThemeExtension<SlidingNavMenuTheme> copyWith({
    BoxDecoration? menuDecoration,
    double? itemHeight,
    TextStyle? itemTextStyle,
    TextStyle? itemHoverTextStyle,
    double? peekSize,
    FillDirection? fillDirection,
    Curve? animationCurve,
    Duration? animationDuration,
  }) {
    return SlidingNavMenuTheme(
      menuDecoration: menuDecoration ?? this.menuDecoration,
      itemHeight: itemHeight ?? this.itemHeight,
      itemTextStyle: itemTextStyle ?? this.itemTextStyle,
      itemHoverTextStyle: itemHoverTextStyle ?? this.itemHoverTextStyle,
      peekSize: peekSize ?? this.peekSize,
      fillDirection: fillDirection ?? this.fillDirection,
      animationCurve: animationCurve ?? this.animationCurve,
      animationDuration: animationDuration ?? this.animationDuration,
    );
  }

  @override
  ThemeExtension<SlidingNavMenuTheme> lerp(
    ThemeExtension<SlidingNavMenuTheme>? other,
    double t,
  ) {
    if (other is! SlidingNavMenuTheme) {
      return this;
    }
    return SlidingNavMenuTheme(
      menuDecoration:
          BoxDecoration.lerp(menuDecoration, other.menuDecoration, t) ??
              menuDecoration,
      itemHeight: lerpDouble(itemHeight, other.itemHeight, t) ?? itemHeight,
      itemTextStyle: TextStyle.lerp(itemTextStyle, other.itemTextStyle, t) ??
          itemTextStyle,
      itemHoverTextStyle:
          TextStyle.lerp(itemHoverTextStyle, other.itemHoverTextStyle, t) ??
              itemHoverTextStyle,
      peekSize: lerpDouble(peekSize, other.peekSize, t) ?? peekSize,
      // FillDirection, Curve and Duration can't be linearly interpolated
      fillDirection: t > 0.5 ? other.fillDirection : fillDirection,
      animationCurve: t > 0.5 ? other.animationCurve : animationCurve,
      animationDuration: t > 0.5 ? other.animationDuration : animationDuration,
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
        label: 'Item Height',
        value: itemHeight,
        min: 40.0,
        max: 100.0,
        onChanged: (value) => onUpdate(
            copyWith(itemHeight: (value as num).toDouble()) as PlaygroundTheme),
      ),
      EditableProperty<double?>(
        label: 'Peek Size',
        value: peekSize,
        min: 0.0,
        max: 20.0,
        onChanged: (value) => onUpdate(
            copyWith(peekSize: (value as num).toDouble()) as PlaygroundTheme),
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
      EditableProperty<String?>(
        label: 'Fill Direction',
        value: fillDirection.displayName,
        onChanged: (value) {
          final direction = FillDirection.values.firstWhere(
            (d) => d.displayName == value,
            orElse: () => FillDirection.leftToRight,
          );
          onUpdate(copyWith(fillDirection: direction) as PlaygroundTheme);
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
