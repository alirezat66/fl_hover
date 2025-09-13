import 'package:flutter/material.dart';

/// Defines the visual properties for the [CardHover] widget.
@immutable
class CardHoverTheme {
  final double width;
  final double height;
  final double image_height;
  final BorderRadius borderRadius;
  final BoxShadow shadow;
  final BoxShadow hoverShadow;
  final Color infoBackgroundColor;
  final Color categoryColor;
  final TextStyle categoryTextStyle;
  final TextStyle titleTextStyle;
  final TextStyle authorByTextStyle;
  final TextStyle authorTextStyle;

  const CardHoverTheme({
    this.width = 250.0,
    this.height = 370.0,
    this.image_height = 235.0,
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
  });
}
