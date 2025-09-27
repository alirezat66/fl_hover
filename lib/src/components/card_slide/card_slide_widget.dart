import 'package:flutter/material.dart';
import 'models/card_slide_theme.dart';

/// A card widget with a simple slide animation on hover.
///
/// On hover, the top panel slides up while the bottom panel slides down,
/// creating a smooth vertical transition effect similar to the HTML/CSS version.
class CardSlide extends StatefulWidget {
  /// The icon widget for the top panel (usually an icon).
  final Widget icon;

  /// The title text for the bottom panel.
  final String title;

  /// The subtitle text for the bottom panel.
  final String subtitle;

  /// The visual theme of the card. If null, it will use the theme from the context.
  final CardSlideTheme? theme;

  const CardSlide({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.theme,
  }) : super(key: key);

  @override
  State<CardSlide> createState() => _CardSlideState();
}

class _CardSlideState extends State<CardSlide>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _slideAnimation;

  late CardSlideTheme _finalTheme;

  @override
  void initState() {
    super.initState();
    _updateTheme(); // Initialize theme first
    _controller = AnimationController(
      vsync: this,
      duration: _finalTheme.animationDuration,
    );
    _setupAnimations();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final oldTheme = _finalTheme;
    _updateTheme();
    if (oldTheme != _finalTheme) {
      _controller.duration = _finalTheme.animationDuration;
      _setupAnimations(); // Re-setup animations with new theme
    }
  }

  @override
  void didUpdateWidget(CardSlide oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != oldWidget.theme) {
      _updateTheme();
      _controller.duration = _finalTheme.animationDuration;
      _setupAnimations(); // Re-setup animations with new theme
    }
  }

  void _updateTheme() {
    _finalTheme = widget.theme ??
        Theme.of(context).extension<CardSlideTheme>() ??
        const CardSlideTheme();
  }

  void _setupAnimations() {
    _slideAnimation = CurvedAnimation(
      parent: _controller,
      curve: _finalTheme.animationCurve ?? Curves.easeInOut,
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

          return Container(
            width: theme.cardWidth,
            height: theme.cardHeight,
            child: Stack(
              children: [
                // slide2 (content panel) - starts at 0, goes to +100px on hover
                Transform.translate(
                  offset: Offset(0, slideValue * 100),
                  child: _buildContentPanel(),
                ),

                // slide1 (icon panel) - starts at 0, goes to -100px on hover
                // This should be on top (z-index: 1 in CSS)
                Transform.translate(
                  offset: Offset(0, -slideValue * 100),
                  child: _buildIconPanel(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildIconPanel() {
    return Container(
      width: _finalTheme.cardWidth,
      height: _finalTheme.cardHeight,
      decoration: BoxDecoration(
        color: _finalTheme.iconBackgroundColor,
        borderRadius: _finalTheme.borderRadius,
      ),
      child: Center(
        child: widget.icon,
      ),
    );
  }

  Widget _buildContentPanel() {
    return Container(
      width: _finalTheme.cardWidth,
      height: _finalTheme.cardHeight,
      decoration: BoxDecoration(
        color: _finalTheme.backgroundColor,
        borderRadius: _finalTheme.borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Padding(
        padding: _finalTheme.padding!,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: _finalTheme.titleTextStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              widget.subtitle,
              style: _finalTheme.subtitleTextStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Container(
              width: 30,
              height: 4,
              decoration: BoxDecoration(
                color: _finalTheme.iconBackgroundColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
