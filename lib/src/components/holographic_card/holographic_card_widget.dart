import 'package:flutter/material.dart';
import 'holographic_card_painter.dart';
import 'models/holographic_card_theme.dart';

/// A card with a stunning holographic shimmer effect on hover.
///
/// Recreates the holographic CSS effect using a [CustomPainter] to draw
/// a sweeping gradient over the card when the mouse enters its region.
class HolographicCard extends StatefulWidget {
  /// The content to display inside the card.
  final Widget child;

  /// The visual theme of the card.
  final HolographicCardTheme theme;

  /// The width of the card.
  final double width;

  /// The height of the card.
  final double height;

  /// The duration of the hover scale animation.
  final Duration scaleDuration;

  /// The duration of one full sweep of the holographic shine.
  final Duration shineDuration;

  const HolographicCard({
    Key? key,
    required this.child,
    this.theme = const HolographicCardTheme(),
    this.width = 300,
    this.height = 200,
    this.scaleDuration = const Duration(milliseconds: 300),
    this.shineDuration = const Duration(seconds: 2),
  }) : super(key: key);

  @override
  State<HolographicCard> createState() => _HolographicCardState();
}

class _HolographicCardState extends State<HolographicCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shineController;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _shineController = AnimationController(
      vsync: this,
      duration: widget.shineDuration,
    );
  }

  @override
  void dispose() {
    _shineController.dispose();
    super.dispose();
  }

  void _onHover(bool isHovering) {
    setState(() {
      _isHovering = isHovering;
    });
    if (_isHovering) {
      _shineController.repeat();
    } else {
      _shineController.stop();
      _shineController.value = 0; // Reset animation
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: widget.scaleDuration,
        curve: Curves.easeOut,
        transform: Matrix4.identity()..scale(_isHovering ? 1.05 : 1.0),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: widget.theme.borderRadius,
          boxShadow: _isHovering
              ? [
                  BoxShadow(
                    color: widget.theme.glowColor,
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: AnimatedBuilder(
            animation: _shineController,
            builder: (context, child) {
              return CustomPaint(
                painter: HolographicCardPainter(
                  shineAnimationValue: _shineController.value,
                  theme: widget.theme,
                ),
                child: Center(
                  child: DefaultTextStyle(
                    style: widget.theme.textStyle,
                    child: child!,
                  ),
                ),
              );
            },
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
