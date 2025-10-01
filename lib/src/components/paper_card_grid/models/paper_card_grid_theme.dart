import 'package:flutter/material.dart';
import '../../../playground/playground_theme.dart';
import '../../../playground/playground_property.dart';

/// Defines the visual properties for the [PaperCardGrid] widget.
class PaperCardGridTheme extends ThemeExtension<PaperCardGridTheme>
    implements PlaygroundTheme {
  /// The background color of the container
  final Color backgroundColor;

  /// The background color of individual cards
  final Color cardBackgroundColor;

  /// The border color of cards
  final Color borderColor;

  /// The border width of cards
  final double borderWidth;

  /// The border radius of cards
  final double borderRadius;

  /// The padding inside each card
  final EdgeInsets cardPadding;

  /// The spacing between grid items
  final double gridSpacing;

  /// The number of columns in the grid
  final int crossAxisCount;

  /// The overlay opacity for non-hovered items
  final double overlayOpacity;

  /// The duration of the blur animation
  final Duration animationDuration;

  /// The curve for the animation
  final Curve animationCurve;

  /// The shadow color
  final Color shadowColor;

  /// The shadow blur radius
  final double shadowBlurRadius;

  /// The shadow offset
  final Offset shadowOffset;

  /// The elevation of cards
  final double cardElevation;

  const PaperCardGridTheme({
    this.backgroundColor = const Color(0xFFF6EEE3),
    this.cardBackgroundColor = Colors.white,
    this.borderColor = const Color(0xFFE5DECF),
    this.borderWidth = 1.0,
    this.borderRadius = 8.0,
    this.cardPadding = const EdgeInsets.all(16.0),
    this.gridSpacing = 16.0,
    this.crossAxisCount = 3,
    this.overlayOpacity = 0.8,
    this.animationDuration = const Duration(milliseconds: 150),
    this.animationCurve = Curves.easeInOut,
    this.shadowColor = Colors.black26,
    this.shadowBlurRadius = 8.0,
    this.shadowOffset = const Offset(0, 4),
    this.cardElevation = 4.0,
  });

  @override
  PaperCardGridTheme copyWith({
    Color? backgroundColor,
    Color? cardBackgroundColor,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    EdgeInsets? cardPadding,
    double? gridSpacing,
    int? crossAxisCount,
    double? overlayOpacity,
    Duration? animationDuration,
    Curve? animationCurve,
    Color? shadowColor,
    double? shadowBlurRadius,
    Offset? shadowOffset,
    double? cardElevation,
  }) {
    return PaperCardGridTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      cardBackgroundColor: cardBackgroundColor ?? this.cardBackgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      cardPadding: cardPadding ?? this.cardPadding,
      gridSpacing: gridSpacing ?? this.gridSpacing,
      crossAxisCount: crossAxisCount ?? this.crossAxisCount,
      overlayOpacity: overlayOpacity ?? this.overlayOpacity,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      shadowColor: shadowColor ?? this.shadowColor,
      shadowBlurRadius: shadowBlurRadius ?? this.shadowBlurRadius,
      shadowOffset: shadowOffset ?? this.shadowOffset,
      cardElevation: cardElevation ?? this.cardElevation,
    );
  }

  @override
  PaperCardGridTheme lerp(ThemeExtension<PaperCardGridTheme>? other, double t) {
    if (other is! PaperCardGridTheme) {
      return this;
    }
    return PaperCardGridTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ??
          backgroundColor,
      cardBackgroundColor:
          Color.lerp(cardBackgroundColor, other.cardBackgroundColor, t) ??
              cardBackgroundColor,
      borderColor: Color.lerp(borderColor, other.borderColor, t) ?? borderColor,
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t),
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t),
      cardPadding:
          EdgeInsets.lerp(cardPadding, other.cardPadding, t) ?? cardPadding,
      gridSpacing: lerpDouble(gridSpacing, other.gridSpacing, t),
      crossAxisCount: t < 0.5 ? crossAxisCount : other.crossAxisCount,
      overlayOpacity: lerpDouble(overlayOpacity, other.overlayOpacity, t),
      animationDuration: Duration(
        milliseconds: lerpDouble(
          animationDuration.inMilliseconds.toDouble(),
          other.animationDuration.inMilliseconds.toDouble(),
          t,
        ).round(),
      ),
      animationCurve: t < 0.5 ? animationCurve : other.animationCurve,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t) ?? shadowColor,
      shadowBlurRadius: lerpDouble(shadowBlurRadius, other.shadowBlurRadius, t),
      shadowOffset:
          Offset.lerp(shadowOffset, other.shadowOffset, t) ?? shadowOffset,
      cardElevation: lerpDouble(cardElevation, other.cardElevation, t),
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
        label: 'Card Background Color',
        value: cardBackgroundColor,
        onChanged: (color) {
          if (onChanged != null) {
            onChanged(copyWith(cardBackgroundColor: color));
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
      EditableProperty<double>(
        label: 'Grid Spacing',
        value: gridSpacing,
        onChanged: (spacing) {
          if (onChanged != null) {
            onChanged(copyWith(gridSpacing: spacing));
          }
        },
      ),
      EditableProperty<int>(
        label: 'Cross Axis Count',
        value: crossAxisCount,
        onChanged: (count) {
          if (onChanged != null) {
            onChanged(copyWith(crossAxisCount: count));
          }
        },
      ),
      EditableProperty<double>(
        label: 'Overlay Opacity',
        value: overlayOpacity,
        onChanged: (opacity) {
          if (onChanged != null) {
            onChanged(copyWith(overlayOpacity: opacity));
          }
        },
      ),
      EditableProperty<double>(
        label: 'Card Elevation',
        value: cardElevation,
        onChanged: (elevation) {
          if (onChanged != null) {
            onChanged(copyWith(cardElevation: elevation));
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
        label: 'Animation Curve',
        value: _getCurveDisplayName(animationCurve),
        onChanged: (curveString) {
          final curve = _getCurveFromString(curveString);
          if (curve != null && onChanged != null) {
            onChanged(copyWith(animationCurve: curve));
          }
        },
      ),
    ];
  }

  String _getCurveDisplayName(Curve curve) {
    if (curve == Curves.ease) return 'ease';
    if (curve == Curves.easeIn) return 'easeIn';
    if (curve == Curves.easeOut) return 'easeOut';
    if (curve == Curves.easeInOut) return 'easeInOut';
    if (curve == Curves.fastOutSlowIn) return 'fastOutSlowIn';
    if (curve == Curves.bounceIn) return 'bounceIn';
    if (curve == Curves.bounceOut) return 'bounceOut';
    if (curve == Curves.bounceInOut) return 'bounceInOut';
    if (curve == Curves.elasticIn) return 'elasticIn';
    if (curve == Curves.elasticOut) return 'elasticOut';
    if (curve == Curves.elasticInOut) return 'elasticInOut';
    if (curve == Curves.linear) return 'linear';
    return curve.toString();
  }

  Curve? _getCurveFromString(String? curveString) {
    if (curveString == null) return null;
    switch (curveString) {
      case 'ease':
        return Curves.ease;
      case 'easeIn':
        return Curves.easeIn;
      case 'easeOut':
        return Curves.easeOut;
      case 'easeInOut':
        return Curves.easeInOut;
      case 'fastOutSlowIn':
        return Curves.fastOutSlowIn;
      case 'bounceIn':
        return Curves.bounceIn;
      case 'bounceOut':
        return Curves.bounceOut;
      case 'bounceInOut':
        return Curves.bounceInOut;
      case 'elasticIn':
        return Curves.elasticIn;
      case 'elasticOut':
        return Curves.elasticOut;
      case 'elasticInOut':
        return Curves.elasticInOut;
      case 'linear':
        return Curves.linear;
      default:
        return null;
    }
  }
}
