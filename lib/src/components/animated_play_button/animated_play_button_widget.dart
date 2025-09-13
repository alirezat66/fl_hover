import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'models/animated_play_button_theme.dart';

/// A play/pause button that morphs on hover.
class AnimatedPlayButton extends StatefulWidget {
  final VoidCallback onPressed;
  final AnimatedPlayButtonTheme theme;
  final Duration animationDuration;

  const AnimatedPlayButton({
    Key? key,
    required this.onPressed,
    this.theme = const AnimatedPlayButtonTheme(),
    this.animationDuration = const Duration(milliseconds: 400),
  }) : super(key: key);

  @override
  State<AnimatedPlayButton> createState() => _AnimatedPlayButtonState();
}

class _AnimatedPlayButtonState extends State<AnimatedPlayButton> {
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
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          width: theme.size,
          height: theme.size,
          decoration: BoxDecoration(
            color: theme.backgroundColor,
            shape: BoxShape.circle,
            boxShadow: [theme.shadow],
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                _buildBar(isLeft: true),
                _buildBar(isLeft: false),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBar({required bool isLeft}) {
    final theme = widget.theme;
    final angle = isLeft ? 45.0 : -45.0;
    final circleEndMargin = theme.size * 0.52;

    return Transform.rotate(
      angle: angle * (math.pi / 180),
      child: AnimatedContainer(
        duration: widget.animationDuration,
        curve: Curves.easeInOut,
        width: theme.size * 0.64,
        height: theme.size * 0.12,
        decoration: BoxDecoration(
          color: _isHovering ? theme.hoverBarColor : theme.barColor,
          borderRadius: BorderRadius.circular(theme.size * 0.06),
        ),
        child: Stack(
          children: [
            _buildCircle(
              isCircleLeft: true,
              endMargin: _isHovering ? circleEndMargin : 0,
            ),
            _buildCircle(
              isCircleLeft: false,
              endMargin: _isHovering ? 0 : circleEndMargin,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircle({required bool isCircleLeft, required double endMargin}) {
    final theme = widget.theme;
    return AnimatedPositioned(
      duration: widget.animationDuration,
      curve: Curves.easeInOut,
      left: isCircleLeft ? endMargin : null,
      right: !isCircleLeft ? endMargin : null,
      top: 0,
      bottom: 0,
      child: AnimatedContainer(
        duration: widget.animationDuration,
        width: theme.size * 0.12,
        height: theme.size * 0.12,
        decoration: BoxDecoration(
          color: _isHovering ? theme.hoverCircleColor : theme.circleColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
