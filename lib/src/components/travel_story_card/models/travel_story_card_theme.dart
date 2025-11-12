import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:fl_hover/src/playground/playground_property.dart';
import 'package:fl_hover/src/playground/playground_theme.dart';

class TravelStoryCardTheme extends ThemeExtension<TravelStoryCardTheme>
    implements PlaygroundTheme {
  final double width;
  final double height;
  final double borderRadius;
  final double topSectionRatio;
  final double initialTiltDegrees;
  final Duration animationDuration;
  final Curve animationCurve;
  final Color topGradientStart;
  final Color topGradientEnd;
  final Color bottomGradientStart;
  final Color bottomGradientEnd;

  const TravelStoryCardTheme({
    this.width = 280,
    this.height = 460,
    this.borderRadius = 18,
    this.topSectionRatio = 0.45,
    this.initialTiltDegrees = -60,
    this.animationDuration = const Duration(milliseconds: 550),
    this.animationCurve = Curves.easeOut,
    this.topGradientStart = const Color(0xffeba65b),
    this.topGradientEnd = const Color(0xffd99267),
    this.bottomGradientStart = const Color(0xffeba65b),
    this.bottomGradientEnd = const Color(0xffd99267),
  });

  @override
  TravelStoryCardTheme copyWith({
    double? width,
    double? height,
    double? borderRadius,
    double? topSectionRatio,
    double? initialTiltDegrees,
    Duration? animationDuration,
    Curve? animationCurve,
    Color? topGradientStart,
    Color? topGradientEnd,
    Color? bottomGradientStart,
    Color? bottomGradientEnd,
  }) {
    return TravelStoryCardTheme(
      width: width ?? this.width,
      height: height ?? this.height,
      borderRadius: borderRadius ?? this.borderRadius,
      topSectionRatio: topSectionRatio ?? this.topSectionRatio,
      initialTiltDegrees: initialTiltDegrees ?? this.initialTiltDegrees,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      topGradientStart: topGradientStart ?? this.topGradientStart,
      topGradientEnd: topGradientEnd ?? this.topGradientEnd,
      bottomGradientStart: bottomGradientStart ?? this.bottomGradientStart,
      bottomGradientEnd: bottomGradientEnd ?? this.bottomGradientEnd,
    );
  }

  @override
  TravelStoryCardTheme lerp(
      ThemeExtension<TravelStoryCardTheme>? other, double t) {
    if (other is! TravelStoryCardTheme) return this;
    return TravelStoryCardTheme(
      width: lerpDouble(width, other.width, t) ?? width,
      height: lerpDouble(height, other.height, t) ?? height,
      borderRadius:
          lerpDouble(borderRadius, other.borderRadius, t) ?? borderRadius,
      topSectionRatio: lerpDouble(topSectionRatio, other.topSectionRatio, t) ??
          topSectionRatio,
      initialTiltDegrees:
          lerpDouble(initialTiltDegrees, other.initialTiltDegrees, t) ??
              initialTiltDegrees,
      animationDuration: t < 0.5 ? animationDuration : other.animationDuration,
      animationCurve: t < 0.5 ? animationCurve : other.animationCurve,
      topGradientStart:
          Color.lerp(topGradientStart, other.topGradientStart, t) ??
              topGradientStart,
      topGradientEnd:
          Color.lerp(topGradientEnd, other.topGradientEnd, t) ?? topGradientEnd,
      bottomGradientStart:
          Color.lerp(bottomGradientStart, other.bottomGradientStart, t) ??
              bottomGradientStart,
      bottomGradientEnd:
          Color.lerp(bottomGradientEnd, other.bottomGradientEnd, t) ??
              bottomGradientEnd,
    );
  }

  @override
  List<EditableProperty> getEditableProperties(
      void Function(PlaygroundTheme newTheme) onUpdate) {
    return [
      EditableProperty<double>(
        label: 'Animation Duration (ms)',
        value: animationDuration.inMilliseconds.toDouble(),
        min: 200,
        max: 5000,
        onChanged: (value) => onUpdate(
          copyWith(
            animationDuration: Duration(milliseconds: (value as num).round()),
          ),
        ),
      ),
      EditableProperty<String?>(
        label: 'Animation Curve',
        value: _getCurveDisplayName(animationCurve),
        onChanged: (curveName) {
          final curve = _curveFromString(curveName);
          if (curve != null) {
            onUpdate(copyWith(animationCurve: curve));
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
    if (curve == Curves.linear) return 'linear';
    if (curve == Curves.easeInOutCubic) return 'easeInOutCubic';
    if (curve == Curves.bounceOut) return 'bounceOut';
    if (curve == Curves.elasticOut) return 'elasticOut';
    return curve.toString();
  }

  Curve? _curveFromString(String? name) {
    switch (name) {
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
      case 'linear':
        return Curves.linear;
      case 'easeInOutCubic':
        return Curves.easeInOutCubic;
      case 'bounceOut':
        return Curves.bounceOut;
      case 'elasticOut':
        return Curves.elasticOut;
      default:
        return null;
    }
  }
}
