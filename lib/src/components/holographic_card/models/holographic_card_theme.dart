import 'dart:ui';
import 'package:flutter/material.dart';

/// Defines the visual properties and theme for the [HolographicCard] widget.
///
/// This theme can be provided directly to the widget or integrated into the
/// application's overall theme using `ThemeData.extensions`.
@immutable
class HolographicCardTheme extends ThemeExtension<HolographicCardTheme> {
  /// The background color of the card.
  final Color? backgroundColor;

  /// The primary color of the shimmering holographic effect.
  final Color? shineColor;

  /// The color of the glow/shadow effect when the card is hovered.
  final Color? glowColor;

  /// The border radius for the card's corners.
  final BorderRadius? borderRadius;

  /// The padding between the card's border and its child.
  final EdgeInsets? padding;

  /// The elevation (shadow depth) of the card in its normal state.
  final double? elevation;

  /// The elevation (shadow depth) of the card when hovered.
  final double? hoverElevation;

  /// The scaling factor applied to the card on hover. (e.g., 1.05 for 5% bigger).
  final double? scaleFactor;

  /// The duration of the hover animations (scale and elevation).
  final Duration? animationDuration;

  /// The duration of one full sweep of the holographic shine.
  final Duration? shineDuration;

  /// Creates a theme for the holographic card.
  ///
  /// A default theme is provided with values that closely match the original CSS effect.
  const HolographicCardTheme({
    this.backgroundColor = const Color(0xFF111111),
    this.shineColor = const Color(0x4D00FFFF), // rgba(0, 255, 255, 0.3)
    this.glowColor = const Color(0x8000FFFF), // rgba(0, 255, 255, 0.5)
    this.borderRadius = const BorderRadius.all(Radius.circular(15)),
    this.padding = const EdgeInsets.all(24.0),
    this.elevation = 4.0,
    this.hoverElevation = 20.0,
    this.scaleFactor = 1.05,
    this.animationDuration = const Duration(milliseconds: 300),
    this.shineDuration = const Duration(seconds: 2),
  });

  @override
  HolographicCardTheme copyWith({
    Color? backgroundColor,
    Color? shineColor,
    Color? glowColor,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    double? elevation,
    double? hoverElevation,
    double? scaleFactor,
    Duration? animationDuration,
    Duration? shineDuration,
  }) {
    return HolographicCardTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      shineColor: shineColor ?? this.shineColor,
      glowColor: glowColor ?? this.glowColor,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      elevation: elevation ?? this.elevation,
      hoverElevation: hoverElevation ?? this.hoverElevation,
      scaleFactor: scaleFactor ?? this.scaleFactor,
      animationDuration: animationDuration ?? this.animationDuration,
      shineDuration: shineDuration ?? this.shineDuration,
    );
  }

  @override
  HolographicCardTheme lerp(
      ThemeExtension<HolographicCardTheme>? other, double t) {
    if (other is! HolographicCardTheme) {
      return this;
    }
    return HolographicCardTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      shineColor: Color.lerp(shineColor, other.shineColor, t),
      glowColor: Color.lerp(glowColor, other.glowColor, t),
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t),
      padding: EdgeInsets.lerp(padding, other.padding, t),
      elevation: lerpDouble(elevation, other.elevation, t),
      hoverElevation: lerpDouble(hoverElevation, other.hoverElevation, t),
      scaleFactor: lerpDouble(scaleFactor, other.scaleFactor, t),
      // Durations don't lerp, typically the new theme's duration is taken.
      animationDuration: t < 0.5 ? animationDuration : other.animationDuration,
      shineDuration: t < 0.5 ? shineDuration : other.shineDuration,
    );
  }
}
