import 'package:flutter/material.dart';
import '../../../playground/playground_theme.dart';
import '../../../playground/playground_property.dart';

/// Defines the visual properties for the [AnimatedArrowButton] widget.
class AnimatedArrowButtonTheme extends ThemeExtension<AnimatedArrowButtonTheme>
    implements PlaygroundTheme {
  /// The text to display on the button
  final String text;

  /// The text style for the button text
  final TextStyle textStyle;

  /// The background color of the button
  final Color backgroundColor;

  /// The shadow color
  final Color shadowColor;

  /// The hover shadow color
  final Color hoverShadowColor;

  /// The arrow color
  final Color arrowColor;

  /// The hover arrow color
  final Color hoverArrowColor;

  /// The button padding
  final EdgeInsets padding;

  /// The skew angle in degrees
  final double skewAngle;

  /// The shadow offset
  final Offset shadowOffset;

  /// The hover shadow offset
  final Offset hoverShadowOffset;

  /// The duration of the animation
  final Duration animationDuration;

  /// The curve for the animation
  final Curve animationCurve;

  /// The arrow animation duration
  final Duration arrowAnimationDuration;

  const AnimatedArrowButtonTheme({
    this.text = 'NEXT',
    this.textStyle = const TextStyle(
      fontSize: 40,
      color: Colors.white,
      fontWeight: FontWeight.w900,
      fontFamily: 'Poppins',
    ),
    this.backgroundColor = const Color(0xFF6225E6),
    this.shadowColor = Colors.black,
    this.hoverShadowColor = const Color(0xFFFBC638),
    this.arrowColor = Colors.white,
    this.hoverArrowColor = const Color(0xFFFBC638),
    this.padding = const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
    this.skewAngle = 0.0,
    this.shadowOffset = const Offset(6, 6),
    this.hoverShadowOffset = const Offset(10, 10),
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeOut,
    this.arrowAnimationDuration = const Duration(milliseconds: 1000),
  });

  @override
  AnimatedArrowButtonTheme copyWith({
    String? text,
    TextStyle? textStyle,
    Color? backgroundColor,
    Color? shadowColor,
    Color? hoverShadowColor,
    Color? arrowColor,
    Color? hoverArrowColor,
    EdgeInsets? padding,
    double? skewAngle,
    Offset? shadowOffset,
    Offset? hoverShadowOffset,
    Duration? animationDuration,
    Curve? animationCurve,
    Duration? arrowAnimationDuration,
  }) {
    return AnimatedArrowButtonTheme(
      text: text ?? this.text,
      textStyle: textStyle ?? this.textStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      shadowColor: shadowColor ?? this.shadowColor,
      hoverShadowColor: hoverShadowColor ?? this.hoverShadowColor,
      arrowColor: arrowColor ?? this.arrowColor,
      hoverArrowColor: hoverArrowColor ?? this.hoverArrowColor,
      padding: padding ?? this.padding,
      skewAngle: skewAngle ?? this.skewAngle,
      shadowOffset: shadowOffset ?? this.shadowOffset,
      hoverShadowOffset: hoverShadowOffset ?? this.hoverShadowOffset,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      arrowAnimationDuration:
          arrowAnimationDuration ?? this.arrowAnimationDuration,
    );
  }

  @override
  AnimatedArrowButtonTheme lerp(
      ThemeExtension<AnimatedArrowButtonTheme>? other, double t) {
    if (other is! AnimatedArrowButtonTheme) {
      return this;
    }
    return AnimatedArrowButtonTheme(
      text: t < 0.5 ? text : other.text,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t) ?? textStyle,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ??
          backgroundColor,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t) ?? shadowColor,
      hoverShadowColor:
          Color.lerp(hoverShadowColor, other.hoverShadowColor, t) ??
              hoverShadowColor,
      arrowColor: Color.lerp(arrowColor, other.arrowColor, t) ?? arrowColor,
      hoverArrowColor: Color.lerp(hoverArrowColor, other.hoverArrowColor, t) ??
          hoverArrowColor,
      padding: EdgeInsets.lerp(padding, other.padding, t) ?? padding,
      skewAngle: lerpDouble(skewAngle, other.skewAngle, t),
      shadowOffset:
          Offset.lerp(shadowOffset, other.shadowOffset, t) ?? shadowOffset,
      hoverShadowOffset:
          Offset.lerp(hoverShadowOffset, other.hoverShadowOffset, t) ??
              hoverShadowOffset,
      animationDuration: Duration(
        milliseconds: lerpDouble(
          animationDuration.inMilliseconds.toDouble(),
          other.animationDuration.inMilliseconds.toDouble(),
          t,
        ).round(),
      ),
      animationCurve: t < 0.5 ? animationCurve : other.animationCurve,
      arrowAnimationDuration: Duration(
        milliseconds: lerpDouble(
          arrowAnimationDuration.inMilliseconds.toDouble(),
          other.arrowAnimationDuration.inMilliseconds.toDouble(),
          t,
        ).round(),
      ),
    );
  }

  static double lerpDouble(double a, double b, double t) {
    return a + (b - a) * t;
  }

  @override
  List<EditableProperty<dynamic>> getEditableProperties(
      [void Function(PlaygroundTheme)? onChanged]) {
    return [
      EditableProperty<String>(
        label: 'Text',
        value: text,
        onChanged: (newText) {
          if (onChanged != null) {
            onChanged(copyWith(text: newText));
          }
        },
      ),
      EditableProperty<Color>(
        label: 'Text Color',
        value: textStyle.color ?? Colors.white,
        onChanged: (color) {
          if (onChanged != null) {
            onChanged(copyWith(
              textStyle: textStyle.copyWith(color: color),
            ));
          }
        },
      ),
      EditableProperty<double>(
        label: 'Font Size',
        value: textStyle.fontSize ?? 40.0,
        onChanged: (fontSize) {
          if (onChanged != null) {
            onChanged(copyWith(
              textStyle: textStyle.copyWith(fontSize: fontSize),
            ));
          }
        },
      ),
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
        label: 'Shadow Color',
        value: shadowColor,
        onChanged: (color) {
          if (onChanged != null) {
            onChanged(copyWith(shadowColor: color));
          }
        },
      ),
      EditableProperty<Color>(
        label: 'Hover Shadow Color',
        value: hoverShadowColor,
        onChanged: (color) {
          if (onChanged != null) {
            onChanged(copyWith(hoverShadowColor: color));
          }
        },
      ),
      EditableProperty<Color>(
        label: 'Arrow Color',
        value: arrowColor,
        onChanged: (color) {
          if (onChanged != null) {
            onChanged(copyWith(arrowColor: color));
          }
        },
      ),
      EditableProperty<Color>(
        label: 'Hover Arrow Color',
        value: hoverArrowColor,
        onChanged: (color) {
          if (onChanged != null) {
            onChanged(copyWith(hoverArrowColor: color));
          }
        },
      ),
      EditableProperty<double>(
        label: 'Skew Angle',
        value: skewAngle,
        onChanged: (angle) {
          if (onChanged != null) {
            onChanged(copyWith(skewAngle: angle));
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
