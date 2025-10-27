import 'package:flutter/material.dart';
import 'models/card_slide_theme.dart';

/// A card widget with a simple slide animation on hover.
///
/// On hover, the top panel slides up while the bottom panel slides down,
/// creating a smooth vertical transition effect similar to the HTML/CSS version.
///
/// ## Use Cases:
/// - **Team Member Cards**: Show photo on top, details on bottom
/// - **Product Cards**: Show image on top, specs on bottom
/// - **Service Cards**: Show icon on top, description on bottom
///
/// Example:
/// ```dart
/// CardSlide(
///   theme: const CardSlideTheme(),
///   topWidget: ClipRRect(
///     borderRadius: BorderRadius.circular(12),
///     child: Image.network('https://example.com/photo.jpg'),
///   ),
///   bottomWidget: Column(
///     children: [
///       Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
///       Text('Role'),
///       Text('Bio...'),
///     ],
///   ),
/// )
/// ```
class CardSlide extends StatefulWidget {
  /// The widget displayed on the top panel (slides up on hover).
  ///
  /// This can be any widget, such as:
  /// - An image (for team member/product cards)
  /// - An icon
  /// - A colored container
  final Widget topWidget;

  /// The widget displayed on the bottom panel (slides down on hover).
  ///
  /// This can be any widget, such as:
  /// - Text content (title, subtitle, description)
  /// - A list of features
  /// - Action buttons
  final Widget bottomWidget;

  /// The visual theme of the card. If null, it will use the theme from the context.
  final CardSlideTheme? theme;

  const CardSlide({
    Key? key,
    required this.topWidget,
    required this.bottomWidget,
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
                // Bottom panel - slides down on hover
                Transform.translate(
                  offset: Offset(
                      0,
                      slideValue *
                          (theme.cardHeight ?? 100) *
                          (theme.coveragePercentage ?? 0.1)),
                  child: _buildBottomPanel(),
                ),

                // Top panel - slides up on hover (z-index: 1)
                Transform.translate(
                  offset: Offset(
                      0,
                      -slideValue *
                          (theme.cardHeight ?? 100) *
                          (theme.coveragePercentage ?? 0.1)),
                  child: _buildTopPanel(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTopPanel() {
    return ClipRRect(
      borderRadius: _finalTheme.borderRadius ?? BorderRadius.zero,
      child: Container(
        width: _finalTheme.cardWidth,
        height: _finalTheme.cardHeight,
        child: widget.topWidget,
      ),
    );
  }

  Widget _buildBottomPanel() {
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
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: widget.bottomWidget,
      ),
    );
  }
}
