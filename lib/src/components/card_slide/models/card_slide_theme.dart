import 'package:flutter/material.dart';
import 'package:fl_hover/fl_hover.dart';

/// Defines the visual properties and animations for the [CardSlide] widget.
///
/// This class can be used as a [ThemeExtension] to provide a consistent
/// look and feel for [CardSlide] widgets across the entire application.
@immutable
class CardSlideTheme extends ThemeExtension<CardSlideTheme>
    implements PlaygroundTheme {
  /// The background color of the content panel.
  final Color? backgroundColor;

  /// The border radius for the card.
  final BorderRadius? borderRadius;

  /// Controls how much of the bottom card remains visible when the top card slides up.
  /// This is the offset from the bottom edge where the bottom card content starts.
  /// Default is 20.0 pixels from the bottom.
  final double? cardOffset;

  /// The width of the card.
  final double? cardWidth;

  /// The height of the card.
  final double? cardHeight;

  final double? coveragePercentage;

  /// The duration for the slide animation.
  final Duration? animationDuration;

  /// The curve for the animation.
  final Curve? animationCurve;

  /// The text style for the title.
  final TextStyle? titleTextStyle;

  /// The text style for the subtitle.
  final TextStyle? subtitleTextStyle;

  /// Creates a theme for the CardSlide widget.
  const CardSlideTheme({
    this.backgroundColor = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.cardOffset = 20.0,
    this.cardWidth = 400.0,
    this.cardHeight = 250.0,
    this.coveragePercentage = 0.4,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeOut,
    this.titleTextStyle = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Color(0xFF414141),
    ),
    this.subtitleTextStyle = const TextStyle(
      fontSize: 16,
      color: Color(0xFF414141),
    ),
  });

  @override
  ThemeExtension<CardSlideTheme> copyWith({
    Color? backgroundColor,
    BorderRadius? borderRadius,
    double? cardOffset,
    double? cardWidth,
    double? cardHeight,
    Duration? animationDuration,
    Curve? animationCurve,
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
    double? coveragePercentage,
  }) {
    return CardSlideTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      cardOffset: cardOffset ?? this.cardOffset,
      cardWidth: cardWidth ?? this.cardWidth,
      cardHeight: cardHeight ?? this.cardHeight,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
      coveragePercentage: coveragePercentage ?? this.coveragePercentage,
    );
  }

  @override
  ThemeExtension<CardSlideTheme> lerp(
    ThemeExtension<CardSlideTheme>? other,
    double t,
  ) {
    if (other is! CardSlideTheme) {
      return this;
    }
    return CardSlideTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t),
      cardOffset: lerpDouble(cardOffset, other.cardOffset, t),
      cardWidth: lerpDouble(cardWidth, other.cardWidth, t),
      cardHeight: lerpDouble(cardHeight, other.cardHeight, t),
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t),
      subtitleTextStyle:
          TextStyle.lerp(subtitleTextStyle, other.subtitleTextStyle, t),
      // Duration and Curve can't be linearly interpolated
      animationDuration: t > 0.5 ? other.animationDuration : animationDuration,
      animationCurve: t > 0.5 ? other.animationCurve : animationCurve,
      coveragePercentage:
          lerpDouble(coveragePercentage, other.coveragePercentage, t),
    );
  }

  // A helper function to smoothly interpolate between two doubles.
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
      EditableProperty<BorderRadius?>(
        label: 'Border Radius',
        value: borderRadius,
        onChanged: (value) => onUpdate(
            copyWith(borderRadius: value as BorderRadius?) as PlaygroundTheme),
      ),
      EditableProperty<double?>(
        label: 'Card Width',
        value: cardWidth,
        min: 200.0,
        max: 600.0,
        onChanged: (value) => onUpdate(
            copyWith(cardWidth: (value as num).toDouble()) as PlaygroundTheme),
      ),
      EditableProperty<double?>(
        label: 'Card Height',
        value: cardHeight,
        min: 150.0,
        max: 400.0,
        onChanged: (value) => onUpdate(
            copyWith(cardHeight: (value as num).toDouble()) as PlaygroundTheme),
      ),
      EditableProperty<double?>(
        label: 'Coverage Percentage',
        value: coveragePercentage,
        min: 0.0,
        max: 0.5,
        onChanged: (value) => onUpdate(
            copyWith(coveragePercentage: (value as num).toDouble())
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
          final curve = _getCurveFromString(value ?? 'easeOut');
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
