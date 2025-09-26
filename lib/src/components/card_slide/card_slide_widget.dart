import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'models/card_slide_theme.dart';

/// A card widget with a stunning two-stage animation on hover.
///
/// On hover, the top panel first slides up to reveal the bottom panel.
/// Immediately after, the top panel rotates away while the bottom panel
/// rotates into the primary view, creating a seamless and dynamic 3D swap effect.
class CardSlide extends StatefulWidget {
  /// The content for the top panel, visible by default.
  final Widget topSlideChild;

  /// The content for the bottom panel, revealed and brought to the front on hover.
  final Widget bottomSlideChild;

  /// The visual theme of the card. If null, it will use the theme from the context.
  final CardSlideTheme? theme;

  const CardSlide({
    Key? key,
    required this.topSlideChild,
    required this.bottomSlideChild,
    this.theme,
  }) : super(key: key);

  @override
  State<CardSlide> createState() => _CardSlideState();
}

class _CardSlideState extends State<CardSlide>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _flipAnimation;

  late CardSlideTheme _finalTheme;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800), // Default duration
    );
    _setupAnimations();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateTheme();
    _controller.duration = _finalTheme.animationDuration;
  }

  @override
  void didUpdateWidget(CardSlide oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != oldWidget.theme) {
      _updateTheme();
      _controller.duration = _finalTheme.animationDuration;
    }
  }

  void _updateTheme() {
    _finalTheme = widget.theme ??
        Theme.of(context).extension<CardSlideTheme>() ??
        const CardSlideTheme();
  }

  void _setupAnimations() {
    // Stage 1: Slide animation (first 40% of the duration)
    _slideAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    );
    // Stage 2: Flip animation (last 60% of the duration)
    _flipAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 1.0, curve: Curves.easeInOut),
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
    final theme = _finalTheme;

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.click,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final slideValue = _slideAnimation.value;
          final flipValue = _flipAnimation.value;

          // Top card starts at (0,0), slides up, and then flips out of view (0 to 90 degrees)
          final topAngle = flipValue * (math.pi / 2);
          final topTransform = Matrix4.identity()
            ..setEntry(3, 2, 0.001) // Perspective
            ..translateByDouble(0.0, -slideValue * theme.slideOffset!, 0.0, 1.0)
            ..rotateX(topAngle);

          // Bottom card starts at a -90 degree angle and flips into view (-90 to 0 degrees)
          final bottomAngle = (1.0 - flipValue) * (-math.pi / 2);
          final bottomTransform = Matrix4.identity()
            ..setEntry(3, 2, 0.001) // Perspective
            ..rotateX(bottomAngle);

          return TweenAnimationBuilder<double>(
            tween: Tween<double>(
              end: _controller.isForwardOrCompleted || _controller.isCompleted
                  ? theme.hoverElevation!
                  : theme.elevation!,
            ),
            duration:
                const Duration(milliseconds: 300), // Fast elevation change
            builder: (context, elevation, _) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  // Sizing widgets: these are invisible but ensure the Stack
                  // is large enough to contain the biggest of the two children.
                  Visibility(
                    visible: false,
                    maintainState: true,
                    child: widget.topSlideChild,
                  ),
                  Visibility(
                    visible: false,
                    maintainState: true,
                    child: widget.bottomSlideChild,
                  ),

                  // Bottom Card (animates into view)
                  Transform(
                    transform: bottomTransform,
                    alignment: Alignment.center,
                    child: _buildCardPanel(
                        elevation: elevation, child: widget.bottomSlideChild),
                  ),

                  // Top Card (animates away)
                  Transform(
                    transform: topTransform,
                    alignment: Alignment.center,
                    child: _buildCardPanel(
                        elevation: elevation, child: widget.topSlideChild),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildCardPanel({required double elevation, required Widget child}) {
    return Material(
      elevation: elevation,
      clipBehavior: Clip.antiAlias,
      color: _finalTheme.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: _finalTheme.borderRadius!),
      child: Padding(
        padding: _finalTheme.padding!,
        child: child,
      ),
    );
  }
}
