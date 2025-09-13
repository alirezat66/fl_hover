import 'package:flutter/material.dart';
import 'models/social_icon_theme.dart';

/// A circular social media icon button with a fill and lift effect on hover.
class SocialIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final SocialIconButtonTheme theme;
  final Duration animationDuration;

  const SocialIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.theme,
    this.animationDuration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  State<SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<SocialIconButton> {
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
        child: AnimatedContainer(
          duration: widget.animationDuration,
          width: theme.size,
          height: theme.size,
          transform: Matrix4.identity()
            ..translate(0.0, _isHovering ? -10.0 : 0.0, 0.0)
            ..scale(_isHovering ? 1.1 : 1.0),
          transformAlignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.backgroundColor,
            border: theme.border,
            boxShadow: [_isHovering ? theme.hoverShadow : const BoxShadow()],
          ),
          child: ClipOval(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Hover fill effect
                AnimatedPositioned(
                  duration: widget.animationDuration,
                  top: _isHovering ? 0 : theme.size,
                  left: 0,
                  child: Container(
                    width: theme.size,
                    height: theme.size,
                    color: theme.hoverFillColor,
                  ),
                ),
                // Icon
                Icon(
                  widget.icon,
                  size: theme.iconSize,
                  color: _isHovering ? theme.hoverIconColor : theme.iconColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
