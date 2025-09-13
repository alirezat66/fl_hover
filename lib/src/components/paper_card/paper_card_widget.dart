import 'package:flutter/material.dart';
import 'models/paper_card_theme.dart';

/// A card widget with a "paper" aesthetic, featuring a border and a shadow
/// that grows on hover.
class PaperCard extends StatefulWidget {
  /// The content to display inside the card.
  final Widget child;

  /// The visual theme of the card.
  final PaperCardTheme theme;

  /// The duration of the shadow animation.
  final Duration animationDuration;

  /// The padding inside the card.
  final EdgeInsets padding;

  const PaperCard({
    Key? key,
    required this.child,
    this.theme = const PaperCardTheme(),
    this.animationDuration = const Duration(milliseconds: 150),
    this.padding = const EdgeInsets.all(24.0),
  }) : super(key: key);

  @override
  State<PaperCard> createState() => _PaperCardState();
}

class _PaperCardState extends State<PaperCard> {
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
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: widget.animationDuration,
        padding: widget.padding,
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          border: Border.all(
            color: theme.borderColor,
            width: theme.borderWidth,
          ),
          borderRadius: theme.borderRadius,
          boxShadow: [
            _isHovering ? theme.hoverShadow : theme.shadow,
          ],
        ),
        child: widget.child,
      ),
    );
  }
}
