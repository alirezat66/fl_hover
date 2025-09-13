import 'package:flutter/material.dart';
import 'animated_play_button_painter.dart';
import 'models/animated_play_button_theme.dart';

/// A play/pause button that morphs on hover, now fully customizable.
class AnimatedPlayButton extends StatefulWidget {
  final VoidCallback onPressed;
  final AnimatedPlayButtonTheme? theme;

  const AnimatedPlayButton({
    Key? key,
    required this.onPressed,
    this.theme,
  }) : super(key: key);

  @override
  State<AnimatedPlayButton> createState() => _AnimatedPlayButtonState();
}

class _AnimatedPlayButtonState extends State<AnimatedPlayButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _hoverController;
  late AnimatedPlayButtonTheme _theme;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _theme = widget.theme ?? const AnimatedPlayButtonTheme();
    _hoverController.duration = _theme.animationDuration;
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _onHover(bool isHovering) {
    if (isHovering) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedBuilder(
          animation: _hoverController,
          builder: (context, child) {
            final currentDecoration = BoxDecoration.lerp(
              _theme.decoration,
              _theme.hoverDecoration,
              _hoverController.value,
            );
            final currentShadow = BoxShadow.lerp(
              _theme.shadow,
              _theme.hoverShadow,
              _hoverController.value,
            );

            return Container(
              width: _theme.size,
              height: _theme.size,
              decoration: currentDecoration?.copyWith(
                boxShadow: currentShadow != null ? [currentShadow] : null,
              ),
              child: CustomPaint(
                painter: AnimatedPlayButtonPainter(
                  hoverAnimation: _hoverController,
                  theme: _theme,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
