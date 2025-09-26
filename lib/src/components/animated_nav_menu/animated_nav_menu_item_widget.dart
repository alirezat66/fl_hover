import 'package:flutter/material.dart';
import 'models/animated_nav_menu_item.dart';
import 'models/animated_nav_menu_theme.dart';

/// The individual item widget for [AnimatedNavMenu].
/// Manages its own hover state and animations.
class AnimatedNavMenuItemWidget extends StatefulWidget {
  final AnimatedNavMenuItem item;
  final AnimatedNavMenuTheme theme;

  const AnimatedNavMenuItemWidget({
    Key? key,
    required this.item,
    required this.theme,
  }) : super(key: key);

  @override
  State<AnimatedNavMenuItemWidget> createState() =>
      _AnimatedNavMenuItemWidgetState();
}

class _AnimatedNavMenuItemWidgetState extends State<AnimatedNavMenuItemWidget> {
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
        onTap: widget.item.onTap,
        child: AnimatedContainer(
          duration: theme.animationDuration,
          curve: Curves.easeInOut,
          width: _isHovering ? theme.itemHoverWidth : theme.itemSize,
          height: theme.itemSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(theme.itemSize),
            boxShadow: [
              if (_isHovering)
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  spreadRadius: 0,
                )
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background gradient revealed on hover
              AnimatedOpacity(
                duration: theme.animationDuration,
                opacity: _isHovering ? 1.0 : 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: widget.item.hoverGradient,
                    borderRadius: BorderRadius.circular(theme.itemSize),
                  ),
                ),
              ),
              // Static white background
              if (!_isHovering)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(theme.itemSize),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 25,
                        offset: const Offset(0, 10),
                      )
                    ],
                  ),
                ),
              // Icon and Title
              SizedBox(
                width: theme.itemHoverWidth,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Icon
                    AnimatedScale(
                      duration: theme.animationDuration,
                      scale: _isHovering ? 0 : 1,
                      child: Icon(
                        widget.item.icon,
                        color: theme.iconColor,
                        size: theme.itemSize * theme.iconSize,
                      ),
                    ),
                    // Title
                    AnimatedScale(
                      duration: theme.animationDuration,
                      scale: _isHovering ? 1 : 0,
                      child: Text(
                        widget.item.title,
                        style: TextStyle(
                          color: theme.textColor,
                          fontSize: theme.itemSize * theme.textSize,
                          letterSpacing: 0.1,
                          fontWeight: theme.textWeight,
                          textBaseline: TextBaseline.alphabetic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
