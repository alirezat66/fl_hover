import 'package:flutter/material.dart';
import 'models/animated_icon_item.dart';
import 'models/animated_icons_theme.dart';

/// A widget that displays icons with animated hover effects.
class AnimatedHoverIcons extends StatefulWidget {
  /// The list of icons to display.
  final List<AnimatedIconItem> icons;

  /// The visual theme of the icons. If null, it will use the theme from the context.
  final AnimatedIconsTheme? theme;

  /// Creates an [AnimatedHoverIcons].
  const AnimatedHoverIcons({
    Key? key,
    required this.icons,
    this.theme,
  }) : super(key: key);

  @override
  State<AnimatedHoverIcons> createState() => _AnimatedHoverIconsState();
}

class _AnimatedHoverIconsState extends State<AnimatedHoverIcons>
    with TickerProviderStateMixin {
  late AnimatedIconsTheme _finalTheme;
  final List<AnimationController> _controllers = [];
  final List<Animation<double>> _hoverAnimations = [];

  @override
  void initState() {
    super.initState();
    _updateTheme();
    _setupAnimations();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateTheme();
    _setupAnimations();
  }

  @override
  void didUpdateWidget(AnimatedHoverIcons oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != oldWidget.theme) {
      _updateTheme();
      _setupAnimations();
    }
    if (widget.icons.length != oldWidget.icons.length) {
      _setupAnimations();
    }
  }

  void _updateTheme() {
    _finalTheme = widget.theme ??
        Theme.of(context).extension<AnimatedIconsTheme>() ??
        const AnimatedIconsTheme();
  }

  void _setupAnimations() {
    // Dispose old controllers
    for (final controller in _controllers) {
      controller.dispose();
    }
    _controllers.clear();
    _hoverAnimations.clear();

    // Create new controllers and animations for each icon
    for (int i = 0; i < widget.icons.length; i++) {
      final controller = AnimationController(
        duration: _finalTheme.animationDuration,
        vsync: this,
      );

      final hoverAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: _finalTheme.animationCurve,
      ));

      _controllers.add(controller);
      _hoverAnimations.add(hoverAnimation);
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onIconHover(int index, bool isHovering) {
    if (isHovering) {
      _controllers[index].forward();
    } else {
      _controllers[index].reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = _finalTheme;

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < widget.icons.length; i++) ...[
            _buildIcon(i),
            if (i < widget.icons.length - 1) SizedBox(width: theme.spacing),
          ],
        ],
      ),
    );
  }

  Widget _buildIcon(int index) {
    final icon = widget.icons[index];
    final theme = _finalTheme;

    return MouseRegion(
      onEnter: (_) => _onIconHover(index, true),
      onExit: (_) => _onIconHover(index, false),
      child: GestureDetector(
        onTap: icon.onTap,
        child: Tooltip(
          message: icon.tooltip ?? '',
          child: AnimatedBuilder(
            animation: _controllers[index],
            builder: (context, child) {
              return Transform.rotate(
                angle: theme.rotationAngle *
                    3.14159 /
                    180, // Convert degrees to radians
                child: Container(
                  width: theme.iconSize,
                  height: theme.iconSize,
                  child: Stack(
                    children: [
                      // Full circle background that gets filled on hover (behind everything)
                      Center(
                        child: AnimatedBuilder(
                          animation: _hoverAnimations[index],
                          builder: (context, child) {
                            return ClipOval(
                              child: Container(
                                width: theme.iconSize,
                                height: theme.iconSize,
                                child: Stack(
                                  children: [
                                    // Base circle (transparent)
                                    Container(
                                      width: theme.iconSize,
                                      height: theme.iconSize,
                                      decoration: const BoxDecoration(
                                        color: Colors.transparent,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    // Filling circle that grows from 7 o'clock (bottom) to 1 o'clock (top)
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      child: Container(
                                        width: theme.iconSize,
                                        height: theme.iconSize *
                                            _hoverAnimations[index].value,
                                        decoration: BoxDecoration(
                                          color: theme.hoverBackgroundColor
                                              .withValues(
                                            alpha: theme.hoverBackgroundOpacity,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // Base background - left half (1 to 7 o'clock) - always visible (on top)
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: theme.iconSize / 2,
                          height: theme.iconSize,
                          decoration: BoxDecoration(
                            color: theme.iconBackgroundColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(50),
                              bottomLeft: Radius.circular(50),
                            ),
                          ),
                        ),
                      ),
                      // Icon
                      Center(
                        child: Transform.rotate(
                          angle: -theme.rotationAngle *
                              3.14159 /
                              180, // Counter-rotate the icon
                          child: Icon(
                            icon.icon,
                            size: theme.iconSize *
                                0.5, // Like CSS font-size: 50px
                            color: theme.iconColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
