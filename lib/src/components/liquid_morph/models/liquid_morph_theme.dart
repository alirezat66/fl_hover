import 'package:flutter/material.dart';
import '../../../playground/playground_theme.dart';
import '../../../playground/playground_property.dart';

/// Defines the visual properties for the [LiquidMorph] widget.
class LiquidMorphTheme extends ThemeExtension<LiquidMorphTheme>
    implements PlaygroundTheme {
  /// The background color of the button
  final Color backgroundColor;

  /// The width of the button
  final double width;

  /// The height of the button
  final double height;

  /// The border radius in normal state
  final double borderRadius;

  /// The border radius in hover state
  final double hoverBorderRadius;

  /// The colors for the conic gradient
  final List<Color> gradientColors;

  /// The stops for the conic gradient
  final List<double> gradientStops;

  /// The duration of the animation
  final Duration animationDuration;

  /// The curve for the animation
  final Curve animationCurve;

  const LiquidMorphTheme({
    this.backgroundColor = const Color(0xFF0a2342),
    this.width = 250.0,
    this.height = 100.0,
    this.borderRadius = 50.0,
    this.hoverBorderRadius = 10.0,
    this.gradientColors = const [
      Color(0xFF00FFFF), // Cyan
      Color(0xFF0a2342), // Dark blue
      Color(0xFF00FFFF), // Cyan
    ],
    this.gradientStops = const [0.0, 0.33, 0.67],
    this.animationDuration = const Duration(milliseconds: 600),
    this.animationCurve = Curves.easeInOutCubic,
  });

  @override
  LiquidMorphTheme copyWith({
    Color? backgroundColor,
    double? width,
    double? height,
    double? borderRadius,
    double? hoverBorderRadius,
    List<Color>? gradientColors,
    List<double>? gradientStops,
    Duration? animationDuration,
    Curve? animationCurve,
  }) {
    return LiquidMorphTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      width: width ?? this.width,
      height: height ?? this.height,
      borderRadius: borderRadius ?? this.borderRadius,
      hoverBorderRadius: hoverBorderRadius ?? this.hoverBorderRadius,
      gradientColors: gradientColors ?? this.gradientColors,
      gradientStops: gradientStops ?? this.gradientStops,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
    );
  }

  @override
  LiquidMorphTheme lerp(ThemeExtension<LiquidMorphTheme>? other, double t) {
    if (other is! LiquidMorphTheme) {
      return this;
    }
    return LiquidMorphTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ??
          backgroundColor,
      width: lerpDouble(width, other.width, t),
      height: lerpDouble(height, other.height, t),
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t),
      hoverBorderRadius:
          lerpDouble(hoverBorderRadius, other.hoverBorderRadius, t),
      gradientColors: _lerpColorList(gradientColors, other.gradientColors, t),
      gradientStops: _lerpDoubleList(gradientStops, other.gradientStops, t),
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

  static double lerpDouble(double a, double b, double t) {
    return a + (b - a) * t;
  }

  List<Color> _lerpColorList(List<Color> a, List<Color> b, double t) {
    if (a.length != b.length) {
      return t < 0.5 ? a : b;
    }
    return List.generate(a.length, (index) {
      return Color.lerp(a[index], b[index], t) ?? a[index];
    });
  }

  List<double> _lerpDoubleList(List<double> a, List<double> b, double t) {
    if (a.length != b.length) {
      return t < 0.5 ? a : b;
    }
    return List.generate(a.length, (index) {
      return lerpDouble(a[index], b[index], t);
    });
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
        label: 'Width',
        value: width,
        onChanged: (width) {
          if (onChanged != null) {
            onChanged(copyWith(width: width));
          }
        },
      ),
      EditableProperty<double>(
        label: 'Height',
        value: height,
        onChanged: (height) {
          if (onChanged != null) {
            onChanged(copyWith(height: height));
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
        label: 'Hover Border Radius',
        value: hoverBorderRadius,
        onChanged: (radius) {
          if (onChanged != null) {
            onChanged(copyWith(hoverBorderRadius: radius));
          }
        },
      ),
      EditableProperty<Color>(
        label: 'Gradient Color 1',
        value: gradientColors.isNotEmpty ? gradientColors[0] : Colors.cyan,
        onChanged: (color) {
          if (onChanged != null) {
            onChanged(copyWith(
              gradientColors: [
                color,
                gradientColors.length > 1 ? gradientColors[1] : Colors.blue,
                gradientColors.length > 2 ? gradientColors[2] : Colors.cyan,
              ],
            ));
          }
        },
      ),
      EditableProperty<Color>(
        label: 'Gradient Color 2',
        value: gradientColors.length > 1 ? gradientColors[1] : Colors.blue,
        onChanged: (color) {
          if (onChanged != null) {
            onChanged(copyWith(
              gradientColors: [
                gradientColors.isNotEmpty ? gradientColors[0] : Colors.cyan,
                color,
                gradientColors.length > 2 ? gradientColors[2] : Colors.cyan,
              ],
            ));
          }
        },
      ),
      EditableProperty<Color>(
        label: 'Gradient Color 3',
        value: gradientColors.length > 2 ? gradientColors[2] : Colors.cyan,
        onChanged: (color) {
          if (onChanged != null) {
            onChanged(copyWith(
              gradientColors: [
                gradientColors.isNotEmpty ? gradientColors[0] : Colors.cyan,
                gradientColors.length > 1 ? gradientColors[1] : Colors.blue,
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
    if (curve == Curves.fastOutSlowIn) return 'fastOutSlowIn';
    if (curve == Curves.bounceIn) return 'bounceIn';
    if (curve == Curves.bounceOut) return 'bounceOut';
    if (curve == Curves.bounceInOut) return 'bounceInOut';
    if (curve == Curves.elasticIn) return 'elasticIn';
    if (curve == Curves.elasticOut) return 'elasticOut';
    if (curve == Curves.elasticInOut) return 'elasticInOut';
    if (curve == Curves.linear) return 'linear';
    if (curve == Curves.easeInOutCubic) return 'easeInOutCubic';
    return curve.toString(); // Fallback for custom curves
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
      case 'easeInOutCubic':
        return Curves.easeInOutCubic;
      default:
        return null;
    }
  }
}
