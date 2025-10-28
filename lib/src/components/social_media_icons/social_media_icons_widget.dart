import 'package:flutter/material.dart';
import 'models/social_media_icon.dart';
import 'models/social_media_icons_theme.dart';
import '../sliding_nav_menu/models/fill_direction.dart';

/// A widget that displays icons with animated color fill hover effects.
class AnimatedFillIcon extends StatefulWidget {
  /// The list of icons to display.
  final List<AnimatedFillIconItem> icons;

  /// The visual theme of the icons. If null, it will use the theme from the context.
  final AnimatedFillIconTheme? theme;

  /// Creates an [AnimatedFillIcon].
  const AnimatedFillIcon({
    Key? key,
    required this.icons,
    this.theme,
  }) : super(key: key);

  @override
  State<AnimatedFillIcon> createState() => _AnimatedFillIconState();
}

class _AnimatedFillIconState extends State<AnimatedFillIcon>
    with TickerProviderStateMixin {
  late AnimatedFillIconTheme _finalTheme;
  final List<AnimationController> _controllers = [];
  final List<Animation<double>> _scaleAnimations = [];
  final List<Animation<double>> _translateAnimations = [];
  final List<Animation<double>> _rotationAnimations = [];
  final List<Animation<double>> _pulseAnimations = [];

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
  void didUpdateWidget(AnimatedFillIcon oldWidget) {
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
        Theme.of(context).extension<AnimatedFillIconTheme>() ??
        const AnimatedFillIconTheme();
  }

  void _setupAnimations() {
    // Dispose old controllers
    for (final controller in _controllers) {
      controller.dispose();
    }
    _controllers.clear();
    _scaleAnimations.clear();
    _translateAnimations.clear();
    _rotationAnimations.clear();
    _pulseAnimations.clear();

    // Create new controllers and animations for each icon
    for (int i = 0; i < widget.icons.length; i++) {
      final controller = AnimationController(
        duration: _finalTheme.animationDuration,
        vsync: this,
      );

      final scaleAnimation = Tween<double>(
        begin: 1.0,
        end: _finalTheme.hoverScale,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: _finalTheme.animationCurve,
      ));

      final translateAnimation = Tween<double>(
        begin: 0.0,
        end: _finalTheme.hoverTranslateY,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: _finalTheme.animationCurve,
      ));

      final rotationAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0, // 360 degrees
      ).animate(CurvedAnimation(
        parent: controller,
        curve: _finalTheme.animationCurve,
      ));

      final pulseAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ));

      _controllers.add(controller);
      _scaleAnimations.add(scaleAnimation);
      _translateAnimations.add(translateAnimation);
      _rotationAnimations.add(rotationAnimation);
      _pulseAnimations.add(pulseAnimation);
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
              return Transform.translate(
                offset: Offset(0, _translateAnimations[index].value),
                child: Transform.scale(
                  scale: _scaleAnimations[index].value,
                  child: Container(
                    width: theme.iconSize,
                    height: theme.iconSize,
                    decoration: BoxDecoration(
                      color: theme.iconBackgroundColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.borderColor,
                        width: theme.borderWidth,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: _pulseAnimations[index].value *
                              theme.hoverElevation,
                          offset: Offset(0, _pulseAnimations[index].value * 15),
                        ),
                        // Pulse effect
                        if (_pulseAnimations[index].value > 0)
                          BoxShadow(
                            color: Colors.white.withValues(
                                alpha:
                                    0.7 * (1 - _pulseAnimations[index].value)),
                            blurRadius: _pulseAnimations[index].value * 20,
                            spreadRadius: _pulseAnimations[index].value * 10,
                          ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Background circle with color fill animation
                        Container(
                          width: theme.iconSize,
                          height: theme.iconSize,
                          decoration: BoxDecoration(
                            color: theme.iconBackgroundColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: theme.borderColor,
                              width: theme.borderWidth,
                            ),
                          ),
                          child: ClipOval(
                            child: Stack(
                              children: [
                                // Base white background
                                Container(
                                  width: theme.iconSize,
                                  height: theme.iconSize,
                                  color: theme.iconBackgroundColor,
                                ),
                                // Animated color fill based on direction
                                Positioned(
                                  bottom: theme.fillDirection ==
                                          FillDirection.bottomToTop
                                      ? 0
                                      : null,
                                  top: theme.fillDirection ==
                                          FillDirection.topToBottom
                                      ? 0
                                      : null,
                                  left: theme.fillDirection ==
                                          FillDirection.leftToRight
                                      ? 0
                                      : null,
                                  right: theme.fillDirection ==
                                          FillDirection.rightToLeft
                                      ? 0
                                      : null,
                                  child: AnimatedContainer(
                                    duration: theme.animationDuration,
                                    curve: theme.animationCurve,
                                    width: theme.fillDirection.isHorizontal
                                        ? _controllers[index].value *
                                            theme.iconSize
                                        : theme.iconSize,
                                    height: theme.fillDirection.isVertical
                                        ? _controllers[index].value *
                                            theme.iconSize
                                        : theme.iconSize,
                                    decoration: BoxDecoration(
                                      color: icon.hoverColor,
                                      borderRadius:
                                          _getBorderRadiusForDirection(
                                              theme.fillDirection),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Icon
                        Center(
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001) // perspective
                              ..rotateY(_rotationAnimations[index].value *
                                  2 *
                                  3.14159), // 360 degrees on Y axis
                            child: AnimatedContainer(
                              duration: theme.animationDuration,
                              curve: theme.animationCurve,
                              child: Icon(
                                icon.icon,
                                size: 35, // Like CSS font-size: 35px
                                color: _controllers[index].value > 0.5
                                    ? Colors.white
                                    : theme.iconColor,
                              ),
                            ),
                          ),
                        ),
                        // Ripple effect (like CSS :after)
                        if (_controllers[index].value > 0)
                          Center(
                            child: AnimatedContainer(
                              duration: theme.animationDuration,
                              curve: theme.animationCurve,
                              width: _controllers[index].value * 100,
                              height: _controllers[index].value * 100,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
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
      ),
    );
  }

  BorderRadius _getBorderRadiusForDirection(FillDirection direction) {
    switch (direction) {
      case FillDirection.bottomToTop:
        return const BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        );
      case FillDirection.topToBottom:
        return const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        );
      case FillDirection.leftToRight:
        return const BorderRadius.only(
          topLeft: Radius.circular(50),
          bottomLeft: Radius.circular(50),
        );
      case FillDirection.rightToLeft:
        return const BorderRadius.only(
          topRight: Radius.circular(50),
          bottomRight: Radius.circular(50),
        );
      case FillDirection.centerHorizontal:
        return const BorderRadius.only(
          topLeft: Radius.circular(50),
          bottomLeft: Radius.circular(50),
        );
      case FillDirection.centerVertical:
        return const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        );
    }
  }
}
