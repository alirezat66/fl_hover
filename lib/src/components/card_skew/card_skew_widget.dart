import 'package:flutter/material.dart';
import 'models/card_skew_theme.dart';
import 'card_skew_painter.dart';

/// A card with a skewed background that straightens on hover.
///
/// It also features floating glassmorphic orbs for added visual flair.
class CardSkew extends StatefulWidget {
  final Widget child;
  final int gradientIndex;
  final CardSkewTheme theme;
  final Duration animationDuration;

  const CardSkew({
    Key? key,
    required this.child,
    this.gradientIndex = 0,
    this.theme = const CardSkewTheme(),
    this.animationDuration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  State<CardSkew> createState() => _CardSkewState();
}

class _CardSkewState extends State<CardSkew>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _skewAnimation;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _skewAnimation = Tween<double>(begin: 0.2, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool isHovering) {
    setState(() {
      _isHovering = isHovering;
    });
    if (_isHovering) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final gradient = theme.backgroundGradients[
        widget.gradientIndex % theme.backgroundGradients.length];

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
            // The skewed background
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  size: Size(theme.width, theme.height),
                  painter: CardSkewPainter(
                    skewFactor: _skewAnimation.value,
                    gradient: gradient,
                  ),
                );
              },
            ),

            // The content
            AnimatedContainer(
              duration: widget.animationDuration,
              curve: Curves.easeInOut,
              transform:
                  Matrix4.translationValues(_isHovering ? -25.0 : 0.0, 0, 0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                ),
                child: widget.child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
