import 'package:flutter/material.dart';
import 'models/hover_underline_theme.dart';

/// A text widget that shows an animated underline and overline on hover.
/// The lines animate from the outside towards the center.
class HoverUnderline extends StatefulWidget {
  /// The text to display.
  final String text;

  /// The visual theme of the widget.
  final HoverUnderlineTheme theme;

  /// The duration of the line animation.
  final Duration animationDuration;

  const HoverUnderline({
    Key? key,
    required this.text,
    this.theme = const HoverUnderlineTheme(),
    this.animationDuration = const Duration(milliseconds: 400),
  }) : super(key: key);

  @override
  State<HoverUnderline> createState() => _HoverUnderlineState();
}

class _HoverUnderlineState extends State<HoverUnderline> {
  bool _isHovering = false;

  void _onHover(bool isHovering) {
    setState(() {
      _isHovering = isHovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.text,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAnimatedLine(isOverline: true),
          SizedBox(height: theme.lineGap),
          Text(widget.text, style: theme.textStyle),
          SizedBox(height: theme.lineGap),
          _buildAnimatedLine(isOverline: false),
        ],
      ),
    );
  }

  Widget _buildAnimatedLine({required bool isOverline}) {
    final theme = widget.theme;
    return Stack(
      children: [
        // This is a dummy text to measure the width correctly for the Stack.
        // It's transparent so it's not visible.
        Text(
          widget.text,
          style: theme.textStyle.copyWith(color: Colors.transparent),
        ),
        // The animated line is built inside a Positioned.fill and LayoutBuilder
        // to get the exact width of the parent Stack.
        Positioned.fill(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return AnimatedAlign(
                duration: widget.animationDuration,
                curve: Curves.easeOut,
                alignment: _isHovering
                    ? Alignment.center
                    : (isOverline
                        ? Alignment.centerLeft
                        : Alignment.centerRight),
                child: AnimatedContainer(
                  duration: widget.animationDuration,
                  // Animate between 0 and the actual measured width.
                  width: _isHovering ? constraints.maxWidth : 0,
                  height: theme.lineHeight,
                  decoration: BoxDecoration(
                    gradient: theme.lineGradient,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
