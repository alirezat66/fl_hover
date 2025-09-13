import 'package:flutter/material.dart';

/// Defines the visual properties and animations for the [CardSlide] widget.
///
/// This class can be used as a [ThemeExtension] to provide a consistent
/// look and feel for [CardSlide] widgets across the entire application.
@immutable
class CardSlideTheme extends ThemeExtension<CardSlideTheme> {
  /// The background color of the card panels.
  final Color? backgroundColor;

  /// The border radius for the card.
  final BorderRadius? borderRadius;

  /// The internal padding for the content within each panel.
  final EdgeInsets? padding;

  /// The shadow elevation of the card in its normal state.
  final double? elevation;

  /// The shadow elevation of the card when hovered.
  final double? hoverElevation;

  /// The duration for the entire slide and flip animation sequence.
  final Duration? animationDuration;

  /// The vertical distance the top panel slides up on hover.
  final double? slideOffset;

  /// Creates a theme for the CardSlide widget.
  const CardSlideTheme({
    this.backgroundColor = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.padding = const EdgeInsets.all(24.0),
    this.elevation = 4.0,
    this.hoverElevation = 16.0,
    this.animationDuration = const Duration(milliseconds: 800),
    this.slideOffset = 80.0,
  });

  @override
  ThemeExtension<CardSlideTheme> copyWith({
    Color? backgroundColor,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    double? elevation,
    double? hoverElevation,
    Duration? animationDuration,
    double? slideOffset,
  }) {
    return CardSlideTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      elevation: elevation ?? this.elevation,
      hoverElevation: hoverElevation ?? this.hoverElevation,
      animationDuration: animationDuration ?? this.animationDuration,
      slideOffset: slideOffset ?? this.slideOffset,
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
      padding: EdgeInsets.lerp(padding, other.padding, t),
      elevation: lerpDouble(elevation, other.elevation, t),
      hoverElevation: lerpDouble(hoverElevation, other.hoverElevation, t),
      slideOffset: lerpDouble(slideOffset, other.slideOffset, t),
      // Duration can't be linearly interpolated, so we'll just take the new one.
      animationDuration: t > 0.5 ? other.animationDuration : animationDuration,
    );
  }

  // A helper function to smoothly interpolate between two doubles.
  static double? lerpDouble(double? a, double? b, double t) {
    if (a == null || b == null) return t < 0.5 ? a : b;
    return a + (b - a) * t;
  }
}
