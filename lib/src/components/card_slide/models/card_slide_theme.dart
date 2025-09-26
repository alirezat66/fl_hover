import 'package:flutter/material.dart';
import 'package:flutter_hover_effects/hover_effects.dart';

/// Defines the visual properties and animations for the [CardSlide] widget.
///
/// This class can be used as a [ThemeExtension] to provide a consistent
/// look and feel for [CardSlide] widgets across the entire application.
@immutable
class CardSlideTheme extends ThemeExtension<CardSlideTheme>
    implements PlaygroundTheme {
  /// The background color of the content panel.
  final Color? backgroundColor;

  /// The background color of the icon panel.
  final Color? iconBackgroundColor;

  /// The border radius for the card.
  final BorderRadius? borderRadius;

  /// The internal padding for the content within each panel.
  final EdgeInsets? padding;

  /// The width of the card.
  final double? cardWidth;

  /// The height of the card.
  final double? cardHeight;

  /// The duration for the slide animation.
  final Duration? animationDuration;

  /// The text style for the title.
  final TextStyle? titleTextStyle;

  /// The text style for the subtitle.
  final TextStyle? subtitleTextStyle;

  /// Creates a theme for the CardSlide widget.
  const CardSlideTheme({
    this.backgroundColor = Colors.white,
    this.iconBackgroundColor = const Color(0xFF2c73df),
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.padding = const EdgeInsets.all(20.0),
    this.cardWidth = 400.0,
    this.cardHeight = 250.0,
    this.animationDuration = const Duration(milliseconds: 500),
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
    Color? iconBackgroundColor,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    double? cardWidth,
    double? cardHeight,
    Duration? animationDuration,
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
  }) {
    return CardSlideTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      iconBackgroundColor: iconBackgroundColor ?? this.iconBackgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      cardWidth: cardWidth ?? this.cardWidth,
      cardHeight: cardHeight ?? this.cardHeight,
      animationDuration: animationDuration ?? this.animationDuration,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
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
      iconBackgroundColor:
          Color.lerp(iconBackgroundColor, other.iconBackgroundColor, t),
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t),
      padding: EdgeInsets.lerp(padding, other.padding, t),
      cardWidth: lerpDouble(cardWidth, other.cardWidth, t),
      cardHeight: lerpDouble(cardHeight, other.cardHeight, t),
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t),
      subtitleTextStyle:
          TextStyle.lerp(subtitleTextStyle, other.subtitleTextStyle, t),
      // Duration can't be linearly interpolated, so we'll just take the new one.
      animationDuration: t > 0.5 ? other.animationDuration : animationDuration,
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
      EditableProperty<Color?>(
        label: 'Icon Background Color',
        value: iconBackgroundColor,
        onChanged: (value) => onUpdate(
            copyWith(iconBackgroundColor: value as Color?) as PlaygroundTheme),
      ),
      EditableProperty<BorderRadius?>(
        label: 'Border Radius',
        value: borderRadius,
        onChanged: (value) => onUpdate(
            copyWith(borderRadius: value as BorderRadius?) as PlaygroundTheme),
      ),
      EditableProperty<EdgeInsets?>(
        label: 'Padding',
        value: padding,
        onChanged: (value) => onUpdate(
            copyWith(padding: value as EdgeInsets?) as PlaygroundTheme),
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
      EditableProperty<Duration?>(
        label: 'Animation Duration',
        value: animationDuration,
        onChanged: (value) => onUpdate(
            copyWith(animationDuration: value as Duration?) as PlaygroundTheme),
      ),
    ];
  }
}
