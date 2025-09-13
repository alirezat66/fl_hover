import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'models/flip_card_theme.dart';

/// A card that flips on hover to reveal content on its back side.
///
/// This widget uses a 3D rotation transform to create a smooth and
/// physically plausible flipping animation.
class FlipCard extends StatefulWidget {
  /// The widget to display on the front of the card.
  final Widget front;

  /// The widget to display on the back of the card.
  final Widget back;

  /// The visual theme of the card.
  final FlipCardTheme theme;

  /// The width of the card.
  final double width;

  /// The height of the card.
  final double height;

  /// The duration of the flip animation.
  final Duration animationDuration;

  const FlipCard({
    Key? key,
    required this.front,
    required this.back,
    this.theme = const FlipCardTheme(),
    this.width = 300,
    this.height = 200,
    this.animationDuration = const Duration(milliseconds: 600),
  }) : super(key: key);

  @override
  State<FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool isHovering) {
    if (isHovering) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.click,
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final isFrontVisible = _controller.value < 0.5;
            final angle =
                _controller.value * -math.pi; // Animate from 0 to -180 degrees

            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // Add perspective
                ..rotateY(angle),
              alignment: Alignment.center,
              child: isFrontVisible
                  ? _buildCardFace(widget.front)
                  : Transform(
                      // This inner transform flips the back content to face the user
                      transform: Matrix4.identity()..rotateY(math.pi),
                      alignment: Alignment.center,
                      child: _buildCardFace(widget.back),
                    ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCardFace(Widget child) {
    return Container(
      width: widget.width,
      height: widget.height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: widget.theme.borderRadius,
      ),
      child: child,
    );
  }
}
