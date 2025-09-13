import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'models/animated_icon_theme.dart';

/// An icon widget with a rotating container and a slide-in background effect on hover.
class AnimatedIconWidget extends StatefulWidget {
  final IconData icon;
  final AnimatedIconTheme theme;
  final Duration animationDuration;

  const AnimatedIconWidget({
    Key? key,
    required this.icon,
    this.theme = const AnimatedIconTheme(),
    this.animationDuration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  State<AnimatedIconWidget> createState() => _AnimatedIconWidgetState();
}

class _AnimatedIconWidgetState extends State<AnimatedIconWidget> {
  bool _isHovering = false;

  void _onHover(bool isHovering) {
    setState(() {
      _isHovering = isHovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.click,
      child: Transform.rotate(
        angle: 45 * (math.pi / 180),
        child: Container(
          width: theme.size,
          height: theme.size,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: Stack(
              children: [
                // Static background (left half)
                Positioned(
                  left: 0,
                  top: 0,
                  width: theme.size / 2,
                  height: theme.size,
                  child: Container(color: theme.leftBackgroundColor),
                ),

                // Hover slide-in background
                AnimatedPositioned(
                  duration: widget.animationDuration,
                  curve: Curves.easeOut,
                  top: _isHovering ? 0 : theme.size,
                  right: 0,
                  child: Container(
                    width: theme.size,
                    height: theme.size,
                    color: theme.hoverOverlayColor.withOpacity(0.7),
                  ),
                ),

                // Icon
                Center(
                  child: Transform.rotate(
                    angle: -45 * (math.pi / 180),
                    child: Icon(
                      widget.icon,
                      size: theme.iconSize,
                      color: theme.iconColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
