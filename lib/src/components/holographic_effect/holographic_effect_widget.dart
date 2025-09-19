import 'package:flutter/material.dart';
import 'models/holographic_effect_theme.dart';

/// A card with a holographic effect that exactly replicates the holographic button implementation.
///
/// This widget creates the exact same visual effect as the holographic button:
/// - Dark background (#111111)
/// - Cyan glow on hover (rgba(0, 255, 255, 0.5))
/// - Scale animation (1.05x)
/// - Animated gradient sweep with exact same timing and easing (500ms easeInOut)
/// - Uses two separate animation controllers like the button
class HolographicEffect extends StatefulWidget {
  /// The content to display inside the card.
  final Widget child;

  /// The visual theme of the card. If null, it will try to use the theme
  /// defined in the application's `ThemeData.extensions`.
  final HolographicEffectTheme? theme;

  /// Optional callback when the card is hovered.
  final VoidCallback? onHover;

  /// Optional callback when the card is no longer hovered.
  final VoidCallback? onHoverExit;

  const HolographicEffect({
    Key? key,
    required this.child,
    this.theme,
    this.onHover,
    this.onHoverExit,
  }) : super(key: key);

  @override
  State<HolographicEffect> createState() => _HolographicEffectState();
}

class _HolographicEffectState extends State<HolographicEffect>
    with TickerProviderStateMixin {
  late AnimationController _hoverController;
  late AnimationController _scaleController;
  late Animation<double> _gradientAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  bool _isHovered = false;

  // We need to store the final theme in the state.
  late HolographicEffectTheme _finalTheme;

  @override
  void initState() {
    super.initState();

    // Animation controller for the gradient movement
    _hoverController = AnimationController(
      duration: const Duration(
          milliseconds: 500), // Will be updated in didChangeDependencies
      vsync: this,
    );

    // Animation controller for scale effect
    _scaleController = AnimationController(
      duration: const Duration(
          milliseconds: 500), // Will be updated in didChangeDependencies
      vsync: this,
    );

    // Gradient position animation (moves from top to bottom like CSS translateY(100%))
    _gradientAnimation = Tween<double>(
      begin: 0.0, // Start at initial position
      end: -1.0, // Move full height down (translateY(100%))
    ).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );

    // Scale animation (1.0 to 1.05)
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    // Opacity animation for the gradient overlay
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateTheme();

    // Update animation controller durations based on theme
    _hoverController.duration =
        _finalTheme.shineDuration ?? const Duration(milliseconds: 500);
    _scaleController.duration =
        _finalTheme.animationDuration ?? const Duration(milliseconds: 500);
  }

  @override
  void didUpdateWidget(HolographicEffect oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != oldWidget.theme) {
      _updateTheme();
    }
  }

  void _updateTheme() {
    final themeFromContext =
        Theme.of(context).extension<HolographicEffectTheme>();
    _finalTheme =
        widget.theme ?? themeFromContext ?? const HolographicEffectTheme();
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });

    if (isHovered) {
      widget.onHover?.call();
      _hoverController.forward();
      _scaleController.forward();
    } else {
      widget.onHoverExit?.call();
      _hoverController.reverse();
      _scaleController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = _finalTheme;

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTap: () {}, // Empty tap handler like the button
        child: AnimatedBuilder(
          animation: Listenable.merge([_hoverController, _scaleController]),
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.backgroundColor ?? const Color(0xFF111111),
                  borderRadius: theme.borderRadius,
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: (theme.glowColor ?? const Color(0xFF00FFFF))
                                .withOpacity(0.5),
                            blurRadius: 20,
                            spreadRadius: 0,
                          ),
                        ]
                      : [],
                ),
                child: ClipRRect(
                  borderRadius: theme.borderRadius!,
                  child: Stack(
                    children: [
                      // Child content - always visible
                      Padding(
                        padding: theme.padding!,
                        child: widget.child,
                      ),
                      // Animated gradient overlay - using large size with proper positioning for thicker effect
                      Positioned(
                        top: -400, // Start well above the container
                        left: -400, // Start well to the left of the container
                        child: AnimatedBuilder(
                          animation: _gradientAnimation,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: -0.785398, // -45 degrees in radians
                              child: Transform.translate(
                                offset: Offset(
                                  0,
                                  _gradientAnimation.value *
                                      1200, // Large sweep distance
                                ),
                                child: Opacity(
                                  opacity: _opacityAnimation.value,
                                  child: Container(
                                    width:
                                        1200, // Much larger size for thicker effect
                                    height:
                                        1200, // Much larger size for thicker effect
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.transparent,
                                          theme.shineColor ??
                                              const Color(
                                                  0x4D00FFFF), // Shine color from theme
                                        ],
                                        stops: const [
                                          0.0,
                                          0.3,
                                          1.0
                                        ], // Exact CSS stops
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
