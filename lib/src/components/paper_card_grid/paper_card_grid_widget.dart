import 'package:flutter/material.dart';
import 'models/paper_card_grid_theme.dart';

/// A widget that creates a paper-like card grid with blur effect on hover.
class PaperCardGrid extends StatefulWidget {
  /// The list of card items to display
  final List<Widget> items;

  /// The theme for styling the widget
  final PaperCardGridTheme? theme;

  /// Callback when a card is tapped
  final void Function(int index)? onCardTap;

  const PaperCardGrid({
    super.key,
    required this.items,
    this.theme,
    this.onCardTap,
  });

  @override
  State<PaperCardGrid> createState() => _PaperCardGridState();
}

class _PaperCardGridState extends State<PaperCardGrid>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _blurAnimation;

  late PaperCardGridTheme _finalTheme;

  int? _hoveredIndex;

  @override
  void initState() {
    super.initState();
    _updateTheme();
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
      _setupAnimations();
    }
  }

  @override
  void didUpdateWidget(PaperCardGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != oldWidget.theme) {
      _updateTheme();
      _controller.duration = _finalTheme.animationDuration;
      _setupAnimations();
    }
  }

  void _updateTheme() {
    _finalTheme = widget.theme ??
        Theme.of(context).extension<PaperCardGridTheme>() ??
        const PaperCardGridTheme();
  }

  void _setupAnimations() {
    _blurAnimation = CurvedAnimation(
      parent: _controller,
      curve: _finalTheme.animationCurve,
    );
  }

  void _onCardHover(int index, bool isHovering) {
    if (isHovering) {
      _hoveredIndex = index;
      _controller.forward();
    } else {
      _hoveredIndex = null;
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _finalTheme.backgroundColor,
      ),
      child: AnimatedBuilder(
        animation: _blurAnimation,
        builder: (context, child) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _finalTheme.crossAxisCount,
              crossAxisSpacing: _finalTheme.gridSpacing,
              mainAxisSpacing: _finalTheme.gridSpacing,
              childAspectRatio: 0.8, // Adjust based on your content
            ),
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              final isHovered = _hoveredIndex == index;
              final shouldBlur = _hoveredIndex != null && !isHovered;

              return MouseRegion(
                onEnter: (_) => _onCardHover(index, true),
                onExit: (_) => _onCardHover(index, false),
                child: GestureDetector(
                  onTap: () => widget.onCardTap?.call(index),
                  child: AnimatedContainer(
                    duration: _finalTheme.animationDuration,
                    curve: _finalTheme.animationCurve,
                    decoration: BoxDecoration(
                      color: _finalTheme.cardBackgroundColor,
                      borderRadius:
                          BorderRadius.circular(_finalTheme.borderRadius),
                      border: Border.all(
                        color: _finalTheme.borderColor,
                        width: _finalTheme.borderWidth,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: _finalTheme.shadowColor,
                          blurRadius: _finalTheme.shadowBlurRadius,
                          offset: _finalTheme.shadowOffset,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Container(
                          padding: _finalTheme.cardPadding,
                          child: widget.items[index],
                        ),
                        // White overlay for non-hovered items
                        if (shouldBlur)
                          AnimatedOpacity(
                            duration: _finalTheme.animationDuration,
                            curve: _finalTheme.animationCurve,
                            opacity: _blurAnimation.value *
                                _finalTheme.overlayOpacity,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    _finalTheme.borderRadius),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
