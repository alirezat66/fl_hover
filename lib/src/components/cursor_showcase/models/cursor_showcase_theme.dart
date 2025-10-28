import 'package:flutter/material.dart';
import '../../../playground/playground_theme.dart';
import '../../../playground/playground_property.dart';

/// Theme for CursorShowcase widget
class CursorShowcaseTheme extends ThemeExtension<CursorShowcaseTheme>
    implements PlaygroundTheme {
  final Color backgroundColor;
  final double borderRadius;
  final EdgeInsets containerPadding;
  final TextStyle titleStyle;
  final TextStyle subtitleStyle;
  final double itemSpacing;
  final EdgeInsets itemPadding;
  final Color itemBackgroundColor;
  final Color itemHoverColor;
  final Color itemBorderColor;
  final Color itemHoverBorderColor;
  final double itemBorderWidth;
  final double itemBorderRadius;
  final Color itemShadowColor;
  final double iconSize;
  final Color iconColor;
  final Color iconHoverColor;
  final TextStyle itemTextStyle;
  final Color textColor;
  final Color textHoverColor;

  const CursorShowcaseTheme({
    this.backgroundColor = Colors.white,
    this.borderRadius = 16.0,
    this.containerPadding = const EdgeInsets.all(24.0),
    this.titleStyle = const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    this.subtitleStyle = const TextStyle(
      fontSize: 14,
      color: Colors.black54,
    ),
    this.itemSpacing = 12.0,
    this.itemPadding = const EdgeInsets.all(16.0),
    this.itemBackgroundColor = const Color(0xFFF5F5F5),
    this.itemHoverColor = const Color(0xFF667EEA),
    this.itemBorderColor = const Color(0xFFE0E0E0),
    this.itemHoverBorderColor = const Color(0xFF667EEA),
    this.itemBorderWidth = 2.0,
    this.itemBorderRadius = 12.0,
    this.itemShadowColor = Colors.black26,
    this.iconSize = 32.0,
    this.iconColor = Colors.black54,
    this.iconHoverColor = Colors.white,
    this.itemTextStyle = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
    ),
    this.textColor = Colors.black87,
    this.textHoverColor = Colors.white,
  });

  @override
  CursorShowcaseTheme copyWith({
    Color? backgroundColor,
    double? borderRadius,
    EdgeInsets? containerPadding,
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    double? itemSpacing,
    EdgeInsets? itemPadding,
    Color? itemBackgroundColor,
    Color? itemHoverColor,
    Color? itemBorderColor,
    Color? itemHoverBorderColor,
    double? itemBorderWidth,
    double? itemBorderRadius,
    Color? itemShadowColor,
    double? iconSize,
    Color? iconColor,
    Color? iconHoverColor,
    TextStyle? itemTextStyle,
    Color? textColor,
    Color? textHoverColor,
  }) {
    return CursorShowcaseTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      containerPadding: containerPadding ?? this.containerPadding,
      titleStyle: titleStyle ?? this.titleStyle,
      subtitleStyle: subtitleStyle ?? this.subtitleStyle,
      itemSpacing: itemSpacing ?? this.itemSpacing,
      itemPadding: itemPadding ?? this.itemPadding,
      itemBackgroundColor: itemBackgroundColor ?? this.itemBackgroundColor,
      itemHoverColor: itemHoverColor ?? this.itemHoverColor,
      itemBorderColor: itemBorderColor ?? this.itemBorderColor,
      itemHoverBorderColor: itemHoverBorderColor ?? this.itemHoverBorderColor,
      itemBorderWidth: itemBorderWidth ?? this.itemBorderWidth,
      itemBorderRadius: itemBorderRadius ?? this.itemBorderRadius,
      itemShadowColor: itemShadowColor ?? this.itemShadowColor,
      iconSize: iconSize ?? this.iconSize,
      iconColor: iconColor ?? this.iconColor,
      iconHoverColor: iconHoverColor ?? this.iconHoverColor,
      itemTextStyle: itemTextStyle ?? this.itemTextStyle,
      textColor: textColor ?? this.textColor,
      textHoverColor: textHoverColor ?? this.textHoverColor,
    );
  }

  @override
  CursorShowcaseTheme lerp(
      ThemeExtension<CursorShowcaseTheme>? other, double t) {
    if (other is! CursorShowcaseTheme) {
      return this;
    }
    return CursorShowcaseTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ??
          backgroundColor,
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t),
      containerPadding:
          EdgeInsets.lerp(containerPadding, other.containerPadding, t) ??
              containerPadding,
      titleStyle: TextStyle.lerp(titleStyle, other.titleStyle, t) ?? titleStyle,
      subtitleStyle: TextStyle.lerp(subtitleStyle, other.subtitleStyle, t) ??
          subtitleStyle,
      itemSpacing: lerpDouble(itemSpacing, other.itemSpacing, t),
      itemPadding:
          EdgeInsets.lerp(itemPadding, other.itemPadding, t) ?? itemPadding,
      itemBackgroundColor:
          Color.lerp(itemBackgroundColor, other.itemBackgroundColor, t) ??
              itemBackgroundColor,
      itemHoverColor:
          Color.lerp(itemHoverColor, other.itemHoverColor, t) ?? itemHoverColor,
      itemBorderColor: Color.lerp(itemBorderColor, other.itemBorderColor, t) ??
          itemBorderColor,
      itemHoverBorderColor:
          Color.lerp(itemHoverBorderColor, other.itemHoverBorderColor, t) ??
              itemHoverBorderColor,
      itemBorderWidth: lerpDouble(itemBorderWidth, other.itemBorderWidth, t),
      itemBorderRadius: lerpDouble(itemBorderRadius, other.itemBorderRadius, t),
      itemShadowColor: Color.lerp(itemShadowColor, other.itemShadowColor, t) ??
          itemShadowColor,
      iconSize: lerpDouble(iconSize, other.iconSize, t),
      iconColor: Color.lerp(iconColor, other.iconColor, t) ?? iconColor,
      iconHoverColor:
          Color.lerp(iconHoverColor, other.iconHoverColor, t) ?? iconHoverColor,
      itemTextStyle: TextStyle.lerp(itemTextStyle, other.itemTextStyle, t) ??
          itemTextStyle,
      textColor: Color.lerp(textColor, other.textColor, t) ?? textColor,
      textHoverColor:
          Color.lerp(textHoverColor, other.textHoverColor, t) ?? textHoverColor,
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
        label: 'Item Background Color',
        value: itemBackgroundColor,
        onChanged: (color) {
          if (onChanged != null) {
            onChanged(copyWith(itemBackgroundColor: color));
          }
        },
      ),
      EditableProperty<Color>(
        label: 'Item Hover Color',
        value: itemHoverColor,
        onChanged: (color) {
          if (onChanged != null) {
            onChanged(copyWith(itemHoverColor: color));
          }
        },
      ),
      EditableProperty<Color>(
        label: 'Icon Color',
        value: iconColor,
        onChanged: (color) {
          if (onChanged != null) {
            onChanged(copyWith(iconColor: color));
          }
        },
      ),
      EditableProperty<Color>(
        label: 'Icon Hover Color',
        value: iconHoverColor,
        onChanged: (color) {
          if (onChanged != null) {
            onChanged(copyWith(iconHoverColor: color));
          }
        },
      ),
      EditableProperty<double>(
        label: 'Icon Size',
        value: iconSize,
        onChanged: (size) {
          if (onChanged != null) {
            onChanged(copyWith(iconSize: size));
          }
        },
      ),
      EditableProperty<double>(
        label: 'Item Spacing',
        value: itemSpacing,
        onChanged: (spacing) {
          if (onChanged != null) {
            onChanged(copyWith(itemSpacing: spacing));
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
    ];
  }
}
