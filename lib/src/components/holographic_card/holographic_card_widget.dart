import 'package:flutter/material.dart';
import 'holographic_card_painter.dart';
import 'models/holographic_card_theme.dart';

/// A card with a stunning holographic shimmer effect on hover.
///
/// This widget is fully responsive and sizes itself based on its [child].
/// It provides extensive customization through [HolographicCardTheme] and
/// integrates seamlessly with Flutter's theme system via `ThemeExtension`.
class HolographicCard extends StatefulWidget {
  /// The content to display inside the card. The card will size itself to fit this child.
  final Widget child;

  /// The visual theme of the card. If null, it will try to use the theme
  /// defined in the application's `ThemeData.extensions`.
  final HolographicCardTheme? theme;

  const HolographicCard({
    Key? key,
    required this.child,
    this.theme,
  }) : super(key: key);

  @override
  State<HolographicCard> createState() => _HolographicCardState();
}

class _HolographicCardState extends State<HolographicCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _shineController;
  bool _isHovering = false;

  // We need to store the final theme in the state.
  late HolographicCardTheme _finalTheme;

  @override
  void initState() {
    super.initState();
    // Initialize the controller in initState with a default duration.
    // The correct duration will be set in didChangeDependencies.
    _shineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Default temporary duration
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update the theme and set the correct animation duration.
    _updateTheme();
    _shineController.duration = _finalTheme.shineDuration;
  }

  @override
  void didUpdateWidget(HolographicCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != oldWidget.theme) {
      _updateTheme();
      _shineController.duration = _finalTheme.shineDuration;
    }
  }

  void _updateTheme() {
    final themeFromContext =
        Theme.of(context).extension<HolographicCardTheme>();
    _finalTheme =
        widget.theme ?? themeFromContext ?? const HolographicCardTheme();
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
    if (isHovering) {
      // If the animation is already completed, we reset it and play again
      // to ensure the shine happens every time the mouse enters.
      if (_shineController.status == AnimationStatus.completed) {
        _shineController.reset();
      }
      _shineController.forward();
    } else {
      // On exit, we reverse the animation to fade out the shine.
      _shineController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    // The final theme is now sourced from the state.
    final theme = _finalTheme;

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.basic,
      child: AnimatedScale(
        duration: theme.animationDuration!,
        scale: _isHovering ? theme.scaleFactor! : 1.0,
        curve: Curves.easeOut,
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(
            end: _isHovering ? theme.hoverElevation! : theme.elevation!,
          ),
          duration: theme.animationDuration!,
          curve: Curves.easeOut,
          builder: (context, elevation, _) {
            return Material(
              elevation: elevation,
              shadowColor: theme.glowColor,
              shape: RoundedRectangleBorder(borderRadius: theme.borderRadius!),
              clipBehavior: Clip.antiAlias,
              child: AnimatedBuilder(
                animation: _shineController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: HolographicCardPainter(
                      shineAnimationValue: _shineController.value,
                      theme: theme,
                    ),
                    child: child,
                  );
                },
                child: Padding(
                  padding: theme.padding!,
                  child: widget.child,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
