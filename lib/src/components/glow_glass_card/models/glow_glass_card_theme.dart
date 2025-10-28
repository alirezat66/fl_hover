import 'package:flutter/material.dart';
import '../../../playground/playground_theme.dart';
import '../../../playground/playground_property.dart';

/// Defines the visual properties for the [GlowGlassCard] widget.
class GlowGlassCardTheme extends ThemeExtension<GlowGlassCardTheme>
    implements PlaygroundTheme {
  /// The background color of the glass card
  final Color backgroundColor;

  /// The opacity of the glass background
  final double backgroundOpacity;

  /// The blur amount for the glass effect
  final double blurAmount;

  /// The border color
  final Color borderColor;

  /// The border width
  final double borderWidth;

  /// The border radius
  final double borderRadius;

  /// The glow color
  final Color glowColor;

  /// The glow opacity
  final double glowOpacity;

  /// The glow stroke width
  final double glowStrokeWidth;

  /// The glow blur radius
  final double glowBlurRadius;

  /// The duration of the glow animation
  final Duration animationDuration;

  /// The padding around the card
  final EdgeInsets cardPadding;

  /// The shadow color
  final Color shadowColor;

  /// The shadow blur radius
  final double shadowBlurRadius;

  /// The shadow offset
  final Offset shadowOffset;

  const GlowGlassCardTheme({
    this.backgroundColor = Colors.white,
    this.backgroundOpacity = 0.1,
    this.blurAmount = 10.0,
    this.borderColor = Colors.white,
    this.borderWidth = 1.5,
    this.borderRadius = 20.0,
    this.glowColor = const Color(0xFF4A90E2),
    this.glowOpacity = 1.0,
    this.glowStrokeWidth = 12.0,
    this.glowBlurRadius = 16.0,
    this.animationDuration = const Duration(milliseconds: 500),
    this.cardPadding = const EdgeInsets.all(10.0),
    this.shadowColor = Colors.black26,
    this.shadowBlurRadius = 20.0,
    this.shadowOffset = const Offset(0, 10),
  });

  @override
  GlowGlassCardTheme copyWith({
    Color? backgroundColor,
    double? backgroundOpacity,
    double? blurAmount,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    Color? glowColor,
    double? glowOpacity,
    double? glowStrokeWidth,
    double? glowBlurRadius,
    Duration? animationDuration,
    EdgeInsets? cardPadding,
    Color? shadowColor,
    double? shadowBlurRadius,
    Offset? shadowOffset,
  }) {
    return GlowGlassCardTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      backgroundOpacity: backgroundOpacity ?? this.backgroundOpacity,
      blurAmount: blurAmount ?? this.blurAmount,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      glowColor: glowColor ?? this.glowColor,
      glowOpacity: glowOpacity ?? this.glowOpacity,
      glowStrokeWidth: glowStrokeWidth ?? this.glowStrokeWidth,
      glowBlurRadius: glowBlurRadius ?? this.glowBlurRadius,
      animationDuration: animationDuration ?? this.animationDuration,
      cardPadding: cardPadding ?? this.cardPadding,
      shadowColor: shadowColor ?? this.shadowColor,
      shadowBlurRadius: shadowBlurRadius ?? this.shadowBlurRadius,
      shadowOffset: shadowOffset ?? this.shadowOffset,
    );
  }

  @override
  GlowGlassCardTheme lerp(ThemeExtension<GlowGlassCardTheme>? other, double t) {
    if (other is! GlowGlassCardTheme) {
      return this;
    }
    return GlowGlassCardTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ??
          backgroundColor,
      backgroundOpacity:
          lerpDouble(backgroundOpacity, other.backgroundOpacity, t),
      blurAmount: lerpDouble(blurAmount, other.blurAmount, t),
      borderColor: Color.lerp(borderColor, other.borderColor, t) ?? borderColor,
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t),
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t),
      glowColor: Color.lerp(glowColor, other.glowColor, t) ?? glowColor,
      glowOpacity: lerpDouble(glowOpacity, other.glowOpacity, t),
      glowStrokeWidth: lerpDouble(glowStrokeWidth, other.glowStrokeWidth, t),
      glowBlurRadius: lerpDouble(glowBlurRadius, other.glowBlurRadius, t),
      animationDuration: Duration(
        milliseconds: lerpDouble(
          animationDuration.inMilliseconds.toDouble(),
          other.animationDuration.inMilliseconds.toDouble(),
          t,
        ).round(),
      ),
      cardPadding:
          EdgeInsets.lerp(cardPadding, other.cardPadding, t) ?? cardPadding,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t) ?? shadowColor,
      shadowBlurRadius: lerpDouble(shadowBlurRadius, other.shadowBlurRadius, t),
      shadowOffset:
          Offset.lerp(shadowOffset, other.shadowOffset, t) ?? shadowOffset,
    );
  }

  static double lerpDouble(double a, double b, double t) {
    return a + (b - a) * t;
  }

  @override
  List<EditableProperty<dynamic>> getEditableProperties(
      [void Function(PlaygroundTheme)? onChanged]) {
    return [
      EditableProperty<Color>(
        label: 'Background Color',
        value: backgroundColor,
        onChanged: (color) {
          if (onChanged != null) {
            onChanged(copyWith(backgroundColor: color));
          }
        },
      ),
      EditableProperty<double>(
        label: 'Background Opacity',
        value: backgroundOpacity,
        onChanged: (opacity) {
          if (onChanged != null) {
            onChanged(copyWith(backgroundOpacity: opacity));
          }
        },
      ),
      EditableProperty<double>(
        label: 'Blur Amount',
        value: blurAmount,
        onChanged: (blur) {
          if (onChanged != null) {
            onChanged(copyWith(blurAmount: blur));
          }
        },
      ),
      EditableProperty<Color>(
        label: 'Border Color',
        value: borderColor,
        onChanged: (color) {
          if (onChanged != null) {
            onChanged(copyWith(borderColor: color));
          }
        },
      ),
      EditableProperty<double>(
        label: 'Border Width',
        value: borderWidth,
        onChanged: (width) {
          if (onChanged != null) {
            onChanged(copyWith(borderWidth: width));
          }
        },
      ),
      EditableProperty<double>(
        label: 'Border Radius',
        value: borderRadius,
        onChanged: (radius) {
          if (onChanged != null) {
            onChanged(copyWith(borderRadius: radius));
          }
        },
      ),
      EditableProperty<Color>(
        label: 'Glow Color',
        value: glowColor,
        onChanged: (color) {
          if (onChanged != null) {
            onChanged(copyWith(glowColor: color));
          }
        },
      ),
      EditableProperty<double>(
        label: 'Glow Opacity',
        value: glowOpacity,
        onChanged: (opacity) {
          if (onChanged != null) {
            onChanged(copyWith(glowOpacity: opacity));
          }
        },
      ),
      EditableProperty<double>(
        label: 'Glow Stroke Width',
        value: glowStrokeWidth,
        onChanged: (width) {
          if (onChanged != null) {
            onChanged(copyWith(glowStrokeWidth: width));
          }
        },
      ),
      EditableProperty<double>(
        label: 'Glow Blur Radius',
        value: glowBlurRadius,
        onChanged: (radius) {
          if (onChanged != null) {
            onChanged(copyWith(glowBlurRadius: radius));
          }
        },
      ),
      EditableProperty<double>(
        label: 'Shadow Blur Radius',
        value: shadowBlurRadius,
        onChanged: (radius) {
          if (onChanged != null) {
            onChanged(copyWith(shadowBlurRadius: radius));
          }
        },
      ),
      EditableProperty<int>(
        label: 'Animation Duration (ms)',
        value: animationDuration.inMilliseconds,
        onChanged: (duration) {
          if (onChanged != null) {
            onChanged(copyWith(
              animationDuration: Duration(milliseconds: duration),
            ));
          }
        },
      ),
    ];
  }
}
