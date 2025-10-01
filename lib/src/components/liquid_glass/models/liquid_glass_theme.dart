import 'package:flutter/material.dart';
import '../../../playground/playground_theme.dart';
import '../../../playground/playground_property.dart';

/// Defines the visual properties for the [LiquidGlass] widget.
class LiquidGlassTheme extends ThemeExtension<LiquidGlassTheme>
    implements PlaygroundTheme {
  /// The background color of the glass
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

  /// The liquid gradient colors
  final List<Color> liquidColors;

  /// The liquid effect intensity (0.0 to 1.0)
  final double liquidIntensity;

  /// The liquid animation speed
  final double liquidSpeed;

  /// The duration of the animation
  final Duration animationDuration;

  /// The padding around the card
  final EdgeInsets cardPadding;

  /// The shadow color
  final Color shadowColor;

  /// The shadow blur radius
  final double shadowBlurRadius;

  /// The shadow offset
  final Offset shadowOffset;

  const LiquidGlassTheme({
    this.backgroundColor = Colors.white,
    this.backgroundOpacity = 0.15,
    this.blurAmount = 12.0,
    this.borderColor = Colors.white,
    this.borderWidth = 1.5,
    this.borderRadius = 24.0,
    this.liquidColors = const [
      Color(0xFF667EEA),
      Color(0xFF764BA2),
      Color(0xFFF093FB),
    ],
    this.liquidIntensity = 0.3,
    this.liquidSpeed = 1.0,
    this.animationDuration = const Duration(milliseconds: 300),
    this.cardPadding = const EdgeInsets.all(10.0),
    this.shadowColor = Colors.black26,
    this.shadowBlurRadius = 25.0,
    this.shadowOffset = const Offset(0, 12),
  });

  @override
  LiquidGlassTheme copyWith({
    Color? backgroundColor,
    double? backgroundOpacity,
    double? blurAmount,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    List<Color>? liquidColors,
    double? liquidIntensity,
    double? liquidSpeed,
    Duration? animationDuration,
    EdgeInsets? cardPadding,
    Color? shadowColor,
    double? shadowBlurRadius,
    Offset? shadowOffset,
  }) {
    return LiquidGlassTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      backgroundOpacity: backgroundOpacity ?? this.backgroundOpacity,
      blurAmount: blurAmount ?? this.blurAmount,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      liquidColors: liquidColors ?? this.liquidColors,
      liquidIntensity: liquidIntensity ?? this.liquidIntensity,
      liquidSpeed: liquidSpeed ?? this.liquidSpeed,
      animationDuration: animationDuration ?? this.animationDuration,
      cardPadding: cardPadding ?? this.cardPadding,
      shadowColor: shadowColor ?? this.shadowColor,
      shadowBlurRadius: shadowBlurRadius ?? this.shadowBlurRadius,
      shadowOffset: shadowOffset ?? this.shadowOffset,
    );
  }

  @override
  LiquidGlassTheme lerp(ThemeExtension<LiquidGlassTheme>? other, double t) {
    if (other is! LiquidGlassTheme) {
      return this;
    }
    return LiquidGlassTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ??
          backgroundColor,
      backgroundOpacity:
          lerpDouble(backgroundOpacity, other.backgroundOpacity, t),
      blurAmount: lerpDouble(blurAmount, other.blurAmount, t),
      borderColor: Color.lerp(borderColor, other.borderColor, t) ?? borderColor,
      borderWidth: lerpDouble(borderWidth, other.borderWidth, t),
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t),
      liquidColors: _lerpColorList(liquidColors, other.liquidColors, t),
      liquidIntensity: lerpDouble(liquidIntensity, other.liquidIntensity, t),
      liquidSpeed: lerpDouble(liquidSpeed, other.liquidSpeed, t),
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
        label: 'Liquid Color 1',
        value:
            liquidColors.isNotEmpty ? liquidColors[0] : const Color(0xFF667EEA),
        onChanged: (color) {
          if (onChanged != null) {
            final newColors = List<Color>.from(liquidColors);
            if (newColors.isNotEmpty) {
              newColors[0] = color;
            }
            onChanged(copyWith(liquidColors: newColors));
          }
        },
      ),
      EditableProperty<Color>(
        label: 'Liquid Color 2',
        value:
            liquidColors.length > 1 ? liquidColors[1] : const Color(0xFF764BA2),
        onChanged: (color) {
          if (onChanged != null) {
            final newColors = List<Color>.from(liquidColors);
            if (newColors.length > 1) {
              newColors[1] = color;
            }
            onChanged(copyWith(liquidColors: newColors));
          }
        },
      ),
      EditableProperty<Color>(
        label: 'Liquid Color 3',
        value:
            liquidColors.length > 2 ? liquidColors[2] : const Color(0xFFF093FB),
        onChanged: (color) {
          if (onChanged != null) {
            final newColors = List<Color>.from(liquidColors);
            if (newColors.length > 2) {
              newColors[2] = color;
            }
            onChanged(copyWith(liquidColors: newColors));
          }
        },
      ),
      EditableProperty<double>(
        label: 'Liquid Intensity',
        value: liquidIntensity,
        onChanged: (intensity) {
          if (onChanged != null) {
            onChanged(copyWith(liquidIntensity: intensity));
          }
        },
      ),
      EditableProperty<double>(
        label: 'Liquid Speed',
        value: liquidSpeed,
        onChanged: (speed) {
          if (onChanged != null) {
            onChanged(copyWith(liquidSpeed: speed));
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
