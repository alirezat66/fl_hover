import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/cursor_showcase_box_theme.dart';

/// A widget designed to showcase a specific `SystemMouseCursor`.
/// It displays a box that, when hovered, changes the system cursor and
/// applies a hover effect to the box itself.
class CursorShowcaseBox extends StatefulWidget {
  /// The mouse cursor to display when hovering over this widget.
  final SystemMouseCursor cursor;

  /// The content to display inside the box, typically the name of the cursor.
  final Widget child;

  /// The visual theme of the box.
  final CursorShowcaseBoxTheme theme;

  /// The duration of the box's hover animation.
  final Duration animationDuration;

  /// The size of the box.
  final double size;

  const CursorShowcaseBox({
    Key? key,
    required this.cursor,
    required this.child,
    this.theme = const CursorShowcaseBoxTheme(),
    this.animationDuration = const Duration(milliseconds: 300),
    this.size = 120.0,
  }) : super(key: key);

  @override
  State<CursorShowcaseBox> createState() => _CursorShowcaseBoxState();
}

class _CursorShowcaseBoxState extends State<CursorShowcaseBox> {
  bool _isHovering = false;

  void _onHover(bool isHovering) {
    setState(() {
      _isHovering = isHovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: widget.cursor,
      child: AnimatedContainer(
        duration: widget.animationDuration,
        width: widget.size,
        height: widget.size,
        decoration: _isHovering
            ? widget.theme.hoverDecoration
            : widget.theme.decoration,
        child: Center(child: widget.child),
      ),
    );
  }
}
