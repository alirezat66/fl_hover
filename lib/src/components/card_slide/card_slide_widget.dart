import 'package:flutter/material.dart';
import 'models/card_slide_theme.dart';

/// A card widget with a slide effect on hover.
///
/// It consists of two panels. The top panel slides up on hover to reveal
/// the content of the bottom panel.
class CardSlide extends StatefulWidget {
  /// The widget to display on the top sliding panel.
  final Widget topSlide;

  /// The widget to display on the bottom panel, revealed on hover.
  final Widget bottomSlide;

  /// The visual theme of the card.
  final CardSlideTheme theme;

  /// The duration of the slide animation.
  final Duration animationDuration;

  const CardSlide({
    Key? key,
    required this.topSlide,
    required this.bottomSlide,
    this.theme = const CardSlideTheme(),
    this.animationDuration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  State<CardSlide> createState() => _CardSlideState();
}

class _CardSlideState extends State<CardSlide> {
  bool _isHovering = false;

  void _onHover(bool isHovering) {
    setState(() {
      _isHovering = isHovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final slideOffset = theme.height - 100;

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.click,
      child: SizedBox(
        width: theme.width,
        height: theme.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Bottom Slide (the content revealed on hover)
            AnimatedPositioned(
              duration: widget.animationDuration,
              curve: Curves.easeInOut,
              top: _isHovering ? 100 : slideOffset,
              child: AnimatedContainer(
                duration: widget.animationDuration,
                width: theme.width,
                height: 250,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  boxShadow: [if (_isHovering) theme.bottomSlideShadow],
                ),
                child: widget.bottomSlide,
              ),
            ),
            // Top Slide
            AnimatedPositioned(
              duration: widget.animationDuration,
              curve: Curves.easeInOut,
              top: _isHovering ? 0 : 100,
              child: SizedBox(
                width: theme.width,
                height: 250,
                child: widget.topSlide,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
