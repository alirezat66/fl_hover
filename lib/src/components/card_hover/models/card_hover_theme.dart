import 'package:flutter/material.dart';
import 'package:flutter_hover_effects/hover_effects.dart';

/// Defines the visual properties for the [CardHover] widget.
@immutable
class CardHoverTheme extends ThemeExtension<CardHoverTheme>
    implements PlaygroundTheme {
  final double width;
  final double height;
  final double imageHeight;
  final BorderRadius borderRadius;
  final BoxShadow shadow;
  final BoxShadow hoverShadow;
  final Color infoBackgroundColor;
  final Color categoryColor;
  final TextStyle categoryTextStyle;
  final TextStyle titleTextStyle;
  final TextStyle authorByTextStyle;
  final TextStyle authorTextStyle;
  final Color overlayColor;
  final double overlayOpacity;
  final Duration animationDuration;
  final Curve animationCurve;

  const CardHoverTheme({
    this.width = 250.0,
    this.height = 370.0,
    this.imageHeight = 235.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.shadow = const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.1),
      blurRadius: 10,
      spreadRadius: -7,
      offset: Offset(0, 13),
    ),
    this.hoverShadow = const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.1),
      blurRadius: 18,
      spreadRadius: -8,
      offset: Offset(0, 30),
    ),
    this.infoBackgroundColor = Colors.white,
    this.categoryColor = const Color(0xFF868686),
    this.categoryTextStyle = const TextStyle(
        fontFamily: 'Raleway',
        fontSize: 13,
        letterSpacing: 2,
        fontWeight: FontWeight.w500),
    this.titleTextStyle =
        const TextStyle(fontFamily: 'RobotoSlab', fontSize: 18),
    this.authorByTextStyle = const TextStyle(
        fontFamily: 'Raleway', fontSize: 12, fontWeight: FontWeight.w500),
    this.authorTextStyle =
        const TextStyle(color: Color(0xFFAD7D52), fontWeight: FontWeight.w600),
    this.overlayColor = Colors.white,
    this.overlayOpacity = 0.3,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeOut,
  });

  @override
  ThemeExtension<CardHoverTheme> copyWith({
    double? width,
    double? height,
    double? imageHeight,
    BorderRadius? borderRadius,
    BoxShadow? shadow,
    BoxShadow? hoverShadow,
    Color? infoBackgroundColor,
    Color? categoryColor,
    TextStyle? categoryTextStyle,
    TextStyle? titleTextStyle,
    TextStyle? authorByTextStyle,
    TextStyle? authorTextStyle,
    Color? overlayColor,
    double? overlayOpacity,
    Duration? animationDuration,
    Curve? animationCurve,
  }) {
    return CardHoverTheme(
      width: width ?? this.width,
      height: height ?? this.height,
      imageHeight: imageHeight ?? this.imageHeight,
      borderRadius: borderRadius ?? this.borderRadius,
      shadow: shadow ?? this.shadow,
      hoverShadow: hoverShadow ?? this.hoverShadow,
      infoBackgroundColor: infoBackgroundColor ?? this.infoBackgroundColor,
      categoryColor: categoryColor ?? this.categoryColor,
      categoryTextStyle: categoryTextStyle ?? this.categoryTextStyle,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      authorByTextStyle: authorByTextStyle ?? this.authorByTextStyle,
      authorTextStyle: authorTextStyle ?? this.authorTextStyle,
      overlayColor: overlayColor ?? this.overlayColor,
      overlayOpacity: overlayOpacity ?? this.overlayOpacity,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
    );
  }

  @override
  ThemeExtension<CardHoverTheme> lerp(
    ThemeExtension<CardHoverTheme>? other,
    double t,
  ) {
    if (other is! CardHoverTheme) {
      return this;
    }
    return CardHoverTheme(
      width: lerpDouble(width, other.width, t) ?? width,
      height: lerpDouble(height, other.height, t) ?? height,
      imageHeight: lerpDouble(imageHeight, other.imageHeight, t) ?? imageHeight,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t) ??
          borderRadius,
      shadow: BoxShadow.lerp(shadow, other.shadow, t) ?? shadow,
      hoverShadow:
          BoxShadow.lerp(hoverShadow, other.hoverShadow, t) ?? hoverShadow,
      infoBackgroundColor:
          Color.lerp(infoBackgroundColor, other.infoBackgroundColor, t) ??
              infoBackgroundColor,
      categoryColor:
          Color.lerp(categoryColor, other.categoryColor, t) ?? categoryColor,
      categoryTextStyle:
          TextStyle.lerp(categoryTextStyle, other.categoryTextStyle, t) ??
              categoryTextStyle,
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t) ??
          titleTextStyle,
      authorByTextStyle:
          TextStyle.lerp(authorByTextStyle, other.authorByTextStyle, t) ??
              authorByTextStyle,
      authorTextStyle:
          TextStyle.lerp(authorTextStyle, other.authorTextStyle, t) ??
              authorTextStyle,
      overlayColor:
          Color.lerp(overlayColor, other.overlayColor, t) ?? overlayColor,
      overlayOpacity:
          lerpDouble(overlayOpacity, other.overlayOpacity, t) ?? overlayOpacity,
      // Duration and Curve can't be linearly interpolated
      animationDuration: t > 0.5 ? other.animationDuration : animationDuration,
      animationCurve: t > 0.5 ? other.animationCurve : animationCurve,
    );
  }

  // Helper function for lerpDouble
  static double? lerpDouble(double? a, double? b, double t) {
    if (a == null || b == null) return t < 0.5 ? a : b;
    return a + (b - a) * t;
  }

  @override
  List<EditableProperty> getEditableProperties(
    void Function(PlaygroundTheme newTheme) onUpdate,
  ) {
    return [
      EditableProperty<double?>(
        label: 'Width',
        value: width,
        min: 200.0,
        max: 400.0,
        onChanged: (value) => onUpdate(
            copyWith(width: (value as num).toDouble()) as PlaygroundTheme),
      ),
      EditableProperty<double?>(
        label: 'Height',
        value: height,
        min: 300.0,
        max: 500.0,
        onChanged: (value) => onUpdate(
            copyWith(height: (value as num).toDouble()) as PlaygroundTheme),
      ),
      EditableProperty<double?>(
        label: 'Image Height',
        value: imageHeight,
        min: 150.0,
        max: 300.0,
        onChanged: (value) => onUpdate(
            copyWith(imageHeight: (value as num).toDouble())
                as PlaygroundTheme),
      ),
      EditableProperty<BorderRadius?>(
        label: 'Border Radius',
        value: borderRadius,
        onChanged: (value) => onUpdate(
            copyWith(borderRadius: value as BorderRadius?) as PlaygroundTheme),
      ),
      EditableProperty<Color?>(
        label: 'Overlay Color',
        value: overlayColor,
        onChanged: (value) => onUpdate(
            copyWith(overlayColor: value as Color?) as PlaygroundTheme),
      ),
      EditableProperty<double?>(
        label: 'Overlay Opacity',
        value: overlayOpacity,
        min: 0.0,
        max: 1.0,
        onChanged: (value) => onUpdate(
            copyWith(overlayOpacity: (value as num).toDouble())
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
