import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_hover_effects/src/components/flip_card/models/flip_card_theme.dart';

/// A widget that creates a flip card effect with customizable front and back sides.
/// The card flips when hovered over.
class FlipCard extends StatefulWidget {
  /// The widget to display on the front of the card.
  final Widget front;

  /// The widget to display on the back of the card.
  final Widget back;

  /// Optional theme for customizing the flip card appearance and behavior.
  final FlipCardTheme? theme;

  const FlipCard({
    super.key,
    required this.front,
    required this.back,
    this.theme,
  });

  @override
  State<FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late FlipCardTheme _finalTheme;

  @override
  void initState() {
    super.initState();

    // Initialize with default theme - no context access in initState
    _finalTheme = const FlipCardTheme();

    _controller = AnimationController(
      vsync: this,
      duration:
          _finalTheme.animationDuration ?? const Duration(milliseconds: 600),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Now we can safely access context
    final themeFromContext = Theme.of(context).extension<FlipCardTheme>();
    _finalTheme = widget.theme ?? themeFromContext ?? const FlipCardTheme();

    // Update animation controller when theme changes
    _controller.duration =
        _finalTheme.animationDuration ?? const Duration(milliseconds: 600);
  }

  @override
  void didUpdateWidget(FlipCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != oldWidget.theme) {
      // Update theme from widget or context
      final themeFromContext = Theme.of(context).extension<FlipCardTheme>();
      _finalTheme = widget.theme ?? themeFromContext ?? const FlipCardTheme();

      // Update animation controller when theme changes
      _controller.duration =
          _finalTheme.animationDuration ?? const Duration(milliseconds: 600);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Create animation getter that uses current theme
  Animation<double> get _animation {
    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: _finalTheme.animationCurve ?? Curves.easeInOut,
      ),
    );
  }

  void _onHover(bool isHovered) {
    if (isHovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = _finalTheme;

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.click,
      child: SizedBox(
        width: theme.width ?? 300.0,
        height: theme.height ?? 200.0,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final isFrontVisible = _controller.value < 0.5;
            final angle =
                _controller.value * -math.pi; // Animate from 0 to -180 degrees

            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, theme.perspective ?? 0.001) // Add perspective
                ..rotateY(angle),
              alignment: Alignment.center,
              child: isFrontVisible
                  ? _buildCardFace(widget.front, theme.frontBackgroundColor)
                  : Transform(
                      // This inner transform flips the back content to face the user
                      transform: Matrix4.identity()..rotateY(math.pi),
                      alignment: Alignment.center,
                      child: _buildCardFace(
                          widget.back, theme.backBackgroundColor),
                    ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCardFace(Widget child, Color? backgroundColor) {
    final theme = _finalTheme;

    return Container(
      width: theme.width ?? 300.0,
      height: theme.height ?? 200.0,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: theme.borderRadius,
      ),
      child: Padding(
        padding: theme.padding ?? const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}
