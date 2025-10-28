import 'package:flutter/material.dart';
import 'package:fl_hover/fl_hover.dart';

/// Defines the visual properties for the [CardFace] widget.
@immutable
class CardFaceTheme implements PlaygroundTheme {
  /// The width of the card.
  final double width;

  /// The height of the card.
  final double height;

  /// The border radius for the card.
  final BorderRadius borderRadius;

  /// The height of the top face when it's shrunk (on hover).
  final double shrunkenHeight;

  /// The box shadow for the card.
  final BoxShadow shadow;

  /// The duration of the animation when hovering.
  final Duration animationDuration;

  /// The animation curve for the hover animation.
  final Curve animationCurve;

  /// Creates a theme for the card face widget.
  const CardFaceTheme({
    this.width = 300.0,
    this.height = 400.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(15)),
    this.shrunkenHeight = 60.0,
    this.shadow = const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.5),
      blurRadius: 60,
      spreadRadius: 0,
      offset: Offset(0, 15),
    ),
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOut,
  });

  CardFaceTheme copyWith({
    double? width,
    double? height,
    BorderRadius? borderRadius,
    double? shrunkenHeight,
    BoxShadow? shadow,
    Duration? animationDuration,
    Curve? animationCurve,
  }) {
    return CardFaceTheme(
      width: width ?? this.width,
      height: height ?? this.height,
      borderRadius: borderRadius ?? this.borderRadius,
      shrunkenHeight: shrunkenHeight ?? this.shrunkenHeight,
      shadow: shadow ?? this.shadow,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
    );
  }

  @override
  List<EditableProperty> getEditableProperties(
    void Function(PlaygroundTheme newTheme) onUpdate,
  ) {
    return [
      EditableProperty<double>(
        label: 'Width',
        value: width,
        min: 150,
        max: 600,
        onChanged: (value) =>
            onUpdate(copyWith(width: (value as num).toDouble())),
      ),
      EditableProperty<double>(
        label: 'Height',
        value: height,
        min: 150,
        max: 600,
        onChanged: (value) =>
            onUpdate(copyWith(height: (value as num).toDouble())),
      ),
      EditableProperty<BorderRadius?>(
        label: 'Border Radius',
        value: borderRadius,
        onChanged: (value) =>
            onUpdate(copyWith(borderRadius: value as BorderRadius?)),
      ),
      EditableProperty<double>(
        label: 'Shrunken Height',
        value: shrunkenHeight,
        min: 20,
        max: 200,
        onChanged: (value) => onUpdate(
          copyWith(shrunkenHeight: (value as num).toDouble()),
        ),
      ),
      EditableProperty<Color>(
        label: 'Shadow Color',
        value: shadow.color,
        onChanged: (value) => onUpdate(
          copyWith(
            shadow: BoxShadow(
              color: value as Color,
              blurRadius: shadow.blurRadius,
              spreadRadius: shadow.spreadRadius,
              offset: shadow.offset,
            ),
          ),
        ),
      ),
      EditableProperty<double>(
        label: 'Shadow Blur',
        value: shadow.blurRadius,
        min: 0,
        max: 100,
        onChanged: (value) => onUpdate(
          copyWith(
            shadow: BoxShadow(
              color: shadow.color,
              blurRadius: (value as num).toDouble(),
              spreadRadius: shadow.spreadRadius,
              offset: shadow.offset,
            ),
          ),
        ),
      ),
      EditableProperty<double>(
        label: 'Shadow Offset Y',
        value: shadow.offset.dy,
        min: -50,
        max: 100,
        onChanged: (value) => onUpdate(
          copyWith(
            shadow: BoxShadow(
              color: shadow.color,
              blurRadius: shadow.blurRadius,
              spreadRadius: shadow.spreadRadius,
              offset: Offset(0, (value as num).toDouble()),
            ),
          ),
        ),
      ),
      EditableProperty<Duration?>(
        label: 'Animation Duration',
        value: animationDuration,
        onChanged: (value) =>
            onUpdate(copyWith(animationDuration: value as Duration?)),
      ),
      EditableProperty<String>(
        label: 'Animation Curve',
        value: _curveToString(animationCurve),
        onChanged: (value) {
          final curve = _stringToCurve(value as String);
          if (curve != null) {
            onUpdate(copyWith(animationCurve: curve));
          }
        },
      ),
    ];
  }

  /// Converts a Curve to a string representation
  String _curveToString(Curve curve) {
    if (curve == Curves.easeInOut) return 'easeInOut';
    if (curve == Curves.easeIn) return 'easeIn';
    if (curve == Curves.easeOut) return 'easeOut';
    if (curve == Curves.linear) return 'linear';
    if (curve == Curves.fastOutSlowIn) return 'fastOutSlowIn';
    if (curve == Curves.bounceIn) return 'bounceIn';
    if (curve == Curves.bounceOut) return 'bounceOut';
    if (curve == Curves.elasticIn) return 'elasticIn';
    if (curve == Curves.elasticOut) return 'elasticOut';
    return 'easeInOut';
  }

  /// Converts a string to a Curve
  Curve? _stringToCurve(String curveName) {
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
        return null;
    }
  }
}
