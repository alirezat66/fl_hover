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
  final Color topGradientStart;
  final Color topGradientEnd;
  final Color bottomGradientStart;
  final Color bottomGradientEnd;
  final Duration animationDuration;

  const TravelStoryCardTheme({
    this.width = 300,
    this.height = 460,
    this.borderRadius = 18,
    this.topSectionRatio = 0.45,
    this.topGradientStart = const Color(0xffeba65b),
    this.topGradientEnd = const Color(0xffd99267),
    this.bottomGradientStart = const Color(0xffeba65b),
    this.bottomGradientEnd = const Color(0xffd99267),
    this.animationDuration = const Duration(milliseconds: 550),
  });

  @override
  TravelStoryCardTheme copyWith({
    double? width,
    double? height,
    double? borderRadius,
    double? topSectionRatio,
    Color? topGradientStart,
    Color? topGradientEnd,
    Color? bottomGradientStart,
    Color? bottomGradientEnd,
    Duration? animationDuration,
  }) {
    return TravelStoryCardTheme(
      width: width ?? this.width,
      height: height ?? this.height,
      borderRadius: borderRadius ?? this.borderRadius,
      topSectionRatio: topSectionRatio ?? this.topSectionRatio,
      topGradientStart: topGradientStart ?? this.topGradientStart,
      topGradientEnd: topGradientEnd ?? this.topGradientEnd,
      bottomGradientStart: bottomGradientStart ?? this.bottomGradientStart,
      bottomGradientEnd: bottomGradientEnd ?? this.bottomGradientEnd,
      animationDuration: animationDuration ?? this.animationDuration,
    );
  }

  @override
  TravelStoryCardTheme lerp(
      ThemeExtension<TravelStoryCardTheme>? other, double t) {
    if (other is! TravelStoryCardTheme) return this;
    return TravelStoryCardTheme(
      width: lerpDouble(width, other.width, t) ?? width,
      height: lerpDouble(height, other.height, t) ?? height,
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t) ?? borderRadius,
      topSectionRatio:
          lerpDouble(topSectionRatio, other.topSectionRatio, t) ?? topSectionRatio,
      topGradientStart:
          Color.lerp(topGradientStart, other.topGradientStart, t) ?? topGradientStart,
      topGradientEnd:
          Color.lerp(topGradientEnd, other.topGradientEnd, t) ?? topGradientEnd,
      bottomGradientStart: Color.lerp(
              bottomGradientStart, other.bottomGradientStart, t) ??
          bottomGradientStart,
      bottomGradientEnd:
          Color.lerp(bottomGradientEnd, other.bottomGradientEnd, t) ??
              bottomGradientEnd,
      animationDuration:
          t < 0.5 ? animationDuration : other.animationDuration,
    );
  }

  @override
  List<EditableProperty> getEditableProperties(
      void Function(PlaygroundTheme newTheme) onUpdate) {
    return [
      EditableProperty<double>(
        label: 'Width',
        value: width,
        min: 220,
        max: 380,
        onChanged: (value) =>
            onUpdate(copyWith(width: (value as num).toDouble())),
      ),
      EditableProperty<double>(
        label: 'Height',
        value: height,
        min: 360,
        max: 520,
        onChanged: (value) =>
            onUpdate(copyWith(height: (value as num).toDouble())),
      ),
    ];
  }
}
