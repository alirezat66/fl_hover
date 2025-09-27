import 'package:flutter/material.dart';
import '../../../playground/playground_theme.dart';
import '../../../playground/playground_property.dart';

/// Defines the visual properties for the [HoverUnderline] widget.
class HoverUnderlineTheme extends ThemeExtension<HoverUnderlineTheme>
    implements PlaygroundTheme {
  /// The text style for the text
  final TextStyle textStyle;

  /// The height of the underline
  final double underlineHeight;

  /// The padding around the text for underlines
  final double underlineOffset;

  /// The colors for the gradient underline
  final List<Color> underlineColors;

  /// The duration of the animation
  final Duration animationDuration;

  /// The curve for the animation
  final Curve animationCurve;

  const HoverUnderlineTheme({
    this.textStyle = const TextStyle(
      fontSize: 32,
      color: Colors.black,
      fontWeight: FontWeight.normal,
    ),
    this.underlineHeight = 2.0,
    this.underlineOffset = 0.0,
    this.underlineColors = const [
      Color(0xFFFF0000), // Red
      Color(0xFF00FFFF), // Cyan
    ],
    this.animationDuration = const Duration(milliseconds: 400),
    this.animationCurve = Curves.easeOut,
  });

  @override
  HoverUnderlineTheme copyWith({
    TextStyle? textStyle,
    double? underlineHeight,
    double? underlineOffset,
    List<Color>? underlineColors,
    Duration? animationDuration,
    Curve? animationCurve,
  }) {
    return HoverUnderlineTheme(
      textStyle: textStyle ?? this.textStyle,
      underlineHeight: underlineHeight ?? this.underlineHeight,
      underlineOffset: underlineOffset ?? this.underlineOffset,
      underlineColors: underlineColors ?? this.underlineColors,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
    );
  }

  @override
  HoverUnderlineTheme lerp(
      ThemeExtension<HoverUnderlineTheme>? other, double t) {
    if (other is! HoverUnderlineTheme) {
      return this;
    }

    return HoverUnderlineTheme(
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t) ?? textStyle,
      underlineHeight: lerpDouble(underlineHeight, other.underlineHeight, t),
      underlineOffset: lerpDouble(underlineOffset, other.underlineOffset, t),
      underlineColors:
          _lerpColorList(underlineColors, other.underlineColors, t),
      animationDuration: Duration(
        milliseconds: lerpDouble(
          animationDuration.inMilliseconds.toDouble(),
          other.animationDuration.inMilliseconds.toDouble(),
          t,
        ).round(),
      ),
      animationCurve: t < 0.5 ? animationCurve : other.animationCurve,
    );
  }

  List<Color> _lerpColorList(List<Color> a, List<Color> b, double t) {
    if (a.length != b.length) {
      return t < 0.5 ? a : b;
    }

    return List.generate(a.length, (index) {
      return Color.lerp(a[index], b[index], t) ?? a[index];
    });
  }

  static double lerpDouble(double a, double b, double t) {
    return a + (b - a) * t;
  }

  @override
  List<EditableProperty<dynamic>> getEditableProperties(
      [void Function(PlaygroundTheme)? onChanged]) {
    return [
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
        value: textStyle.fontSize ?? 32.0,
        onChanged: (fontSize) {
          if (onChanged != null) {
            onChanged(copyWith(
              textStyle: textStyle.copyWith(fontSize: fontSize),
            ));
          }
        },
      ),
      EditableProperty<FontWeight>(
        label: 'Font Weight',
        value: textStyle.fontWeight ?? FontWeight.normal,
        onChanged: (fontWeight) {
          if (onChanged != null) {
            onChanged(copyWith(
              textStyle: textStyle.copyWith(fontWeight: fontWeight),
            ));
          }
        },
      ),
      EditableProperty<double>(
        label: 'Underline Height',
        value: underlineHeight,
        onChanged: (height) {
          if (onChanged != null) {
            onChanged(copyWith(underlineHeight: height));
          }
        },
      ),
      EditableProperty<double>(
        label: 'Underline Padding',
        value: underlineOffset,
        onChanged: (offset) {
          if (onChanged != null) {
            onChanged(copyWith(underlineOffset: offset));
          }
        },
      ),
      EditableProperty<Color>(
        label: 'Underline Color 1',
        value: underlineColors.isNotEmpty ? underlineColors[0] : Colors.red,
        onChanged: (color) {
          if (onChanged != null) {
            onChanged(copyWith(
              underlineColors: [
                color,
                underlineColors.length > 1 ? underlineColors[1] : Colors.cyan,
              ],
            ));
          }
        },
      ),
      EditableProperty<Color>(
        label: 'Underline Color 2',
        value: underlineColors.length > 1 ? underlineColors[1] : Colors.cyan,
        onChanged: (color) {
          if (onChanged != null) {
            onChanged(copyWith(
              underlineColors: [
                underlineColors.isNotEmpty ? underlineColors[0] : Colors.red,
                color,
              ],
            ));
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
    if (curve == Curves.linear) return 'linear';
    if (curve == Curves.fastOutSlowIn) return 'fastOutSlowIn';
    if (curve == Curves.bounceIn) return 'bounceIn';
    if (curve == Curves.bounceOut) return 'bounceOut';
    if (curve == Curves.bounceInOut) return 'bounceInOut';
    if (curve == Curves.elasticIn) return 'elasticIn';
    if (curve == Curves.elasticOut) return 'elasticOut';
    if (curve == Curves.elasticInOut) return 'elasticInOut';
    return 'easeOut';
  }

  Curve? _getCurveFromString(String? curveString) {
    switch (curveString) {
      case 'ease':
        return Curves.ease;
      case 'easeIn':
        return Curves.easeIn;
      case 'easeOut':
        return Curves.easeOut;
      case 'easeInOut':
        return Curves.easeInOut;
      case 'linear':
        return Curves.linear;
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
      default:
        return null;
    }
  }
}
