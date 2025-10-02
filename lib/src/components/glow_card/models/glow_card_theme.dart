import 'package:flutter/material.dart';
import '../../../playground/playground_theme.dart';
import '../../../playground/playground_property.dart';
import '../../../models/cursor_behavior.dart';

/// Defines the visual properties for the [GlowCard] widget.
class GlowCardTheme extends ThemeExtension<GlowCardTheme>
    implements PlaygroundTheme {
  /// The background color of the card
  final Color backgroundColor;

  /// The border color of the card
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

  /// The cursor behavior when hovering
  final CursorBehavior cursorBehavior;

  const GlowCardTheme({
    this.backgroundColor = Colors.white,
    this.borderColor = const Color(0xFFBA7245),
    this.borderWidth = 3.0,
    this.borderRadius = 16.0,
    this.glowColor = const Color(0xFFBA7245),
    this.glowOpacity = 1.0,
    this.glowStrokeWidth = 15.0,
    this.glowBlurRadius = 14.0,
    this.animationDuration = const Duration(milliseconds: 500),
    this.cardPadding = const EdgeInsets.all(10.0),
    this.cursorBehavior = CursorBehavior.pointer,
  });

  @override
  GlowCardTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    Color? glowColor,
    double? glowOpacity,
    double? glowStrokeWidth,
    double? glowBlurRadius,
    Duration? animationDuration,
    EdgeInsets? cardPadding,
    CursorBehavior? cursorBehavior,
  }) {
    return GlowCardTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      glowColor: glowColor ?? this.glowColor,
      glowOpacity: glowOpacity ?? this.glowOpacity,
      glowStrokeWidth: glowStrokeWidth ?? this.glowStrokeWidth,
      glowBlurRadius: glowBlurRadius ?? this.glowBlurRadius,
      animationDuration: animationDuration ?? this.animationDuration,
      cardPadding: cardPadding ?? this.cardPadding,
      cursorBehavior: cursorBehavior ?? this.cursorBehavior,
    );
  }

  @override
  GlowCardTheme lerp(ThemeExtension<GlowCardTheme>? other, double t) {
    if (other is! GlowCardTheme) {
      return this;
    }
    return GlowCardTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ??
          backgroundColor,
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
      cursorBehavior: t < 0.5 ? cursorBehavior : other.cursorBehavior,
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
      EditableProperty<String?>(
        label: 'Cursor Behavior',
        value: cursorBehavior.displayName,
        onChanged: (cursorString) {
          final cursor = CursorBehavior.fromString(cursorString);
          if (cursor != null && onChanged != null) {
            onChanged(copyWith(cursorBehavior: cursor));
          }
        },
      ),
    ];
  }
}
