import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_hover_effects/src/playground/playground_property.dart';
import 'package:flutter_hover_effects/src/playground/playground_theme.dart';

/// Defines the visual properties and theme for the [HolographicEffect] widget.
///
/// This theme can be provided directly to the widget or integrated into the
/// application's overall theme using `ThemeData.extensions`.
@immutable
class HolographicEffectTheme extends ThemeExtension<HolographicEffectTheme>
    implements PlaygroundTheme {
  /// The background color of the card (matches CSS #111).
  final Color? backgroundColor;

  /// The primary color of the holographic shine effect (matches CSS rgba(0, 255, 255, 0.3)).
  final Color? shineColor;

  /// The color of the glow/shadow effect when hovered (matches CSS rgba(0, 255, 255, 0.5)).
  final Color? glowColor;

  /// The border radius for the card's corners (matches CSS 15px).
  final BorderRadius? borderRadius;

  /// The padding between the card's border and its child.
  final EdgeInsets? padding;

  /// The elevation (shadow depth) of the card in its normal state.
  final double? elevation;

  /// The elevation (shadow depth) of the card when hovered.
  final double? hoverElevation;

  /// The scaling factor applied to the card on hover (matches CSS scale(1.05)).
  final double? scaleFactor;

  /// The duration of the hover animations (matches CSS transition: all 0.5s ease).
  final Duration? animationDuration;

  /// The duration of one full sweep of the holographic shine.
  final Duration? shineDuration;

  /// Creates a theme for the holographic effect.
  ///
  /// A default theme is provided with values that exactly match the original CSS effect.
  const HolographicEffectTheme({
    this.backgroundColor = const Color(0xFF111111), // #111 - exact CSS match
    this.shineColor =
        const Color(0x4D00FFFF), // rgba(0, 255, 255, 0.3) - exact CSS match
    this.glowColor =
        const Color(0x8000FFFF), // rgba(0, 255, 255, 0.5) - exact CSS match
    this.borderRadius =
        const BorderRadius.all(Radius.circular(15)), // 15px - exact CSS match
    this.padding = const EdgeInsets.all(24.0),
    this.elevation = 0.0,
    this.hoverElevation = 0.0,
    this.scaleFactor = 1.05, // scale(1.05) - exact CSS match
    this.animationDuration =
        const Duration(milliseconds: 500), // 0.5s ease - exact CSS match
    this.shineDuration =
        const Duration(milliseconds: 500), // 0.5s ease - exact CSS match
  });

  @override
  HolographicEffectTheme copyWith({
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
    return HolographicEffectTheme(
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
  HolographicEffectTheme lerp(
      ThemeExtension<HolographicEffectTheme>? other, double t) {
    if (other is! HolographicEffectTheme) {
      return this;
    }
    return HolographicEffectTheme(
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

  @override
  List<EditableProperty> getEditableProperties(
      void Function(PlaygroundTheme newTheme) onUpdate) {
    return [
      EditableProperty(
        label: 'Background Color',
        value: backgroundColor,
        onChanged: (value) => onUpdate(copyWith(backgroundColor: value)),
      ),
      EditableProperty(
        label: 'Shine Color',
        value: shineColor,
        onChanged: (value) => onUpdate(copyWith(shineColor: value)),
      ),
      EditableProperty(
        label: 'Glow Color',
        value: glowColor,
        onChanged: (value) => onUpdate(copyWith(glowColor: value)),
      ),
      EditableProperty(
        label: 'Border Radius',
        value: borderRadius,
        onChanged: (value) => onUpdate(copyWith(borderRadius: value)),
      ),
      EditableProperty(
        label: 'Padding',
        value: padding,
        onChanged: (value) => onUpdate(copyWith(padding: value)),
      ),
      EditableProperty(
        label: 'Elevation',
        value: elevation,
        onChanged: (value) => onUpdate(copyWith(elevation: value)),
      ),
      EditableProperty(
        label: 'Hover Elevation',
        value: hoverElevation,
        onChanged: (value) => onUpdate(copyWith(hoverElevation: value)),
      ),
      EditableProperty(
        label: 'Scale Factor',
        value: scaleFactor,
        onChanged: (value) => onUpdate(copyWith(scaleFactor: value)),
      ),
      EditableProperty(
        label: 'Animation Duration',
        value: animationDuration,
        onChanged: (value) => onUpdate(copyWith(animationDuration: value)),
      ),
      EditableProperty(
        label: 'Shine Duration',
        value: shineDuration,
        onChanged: (value) => onUpdate(copyWith(shineDuration: value)),
      ),
    ];
  }
}
