import 'package:flutter/material.dart';
import 'models/animated_nav_menu_item.dart';

/// The individual item widget for [AnimatedNavMenu].
/// Manages its own hover state and animations.
class AnimatedNavMenuItemWidget extends StatefulWidget {
  final AnimatedNavMenuItem item;
  final double size;
  final double hoverWidth;
  final Duration duration;

  const AnimatedNavMenuItemWidget({
    Key? key,
    required this.item,
    required this.size,
    required this.hoverWidth,
    required this.duration,
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
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.item.onTap,
        child: AnimatedContainer(
          duration: widget.duration,
          curve: Curves.easeInOut,
          width: _isHovering ? widget.hoverWidth : widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.size),
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
                duration: widget.duration,
                opacity: _isHovering ? 1.0 : 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: widget.item.hoverGradient,
                    borderRadius: BorderRadius.circular(widget.size),
                  ),
                ),
              ),
              // Static white background
              if (!_isHovering)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(widget.size),
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
                width: widget.hoverWidth,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Icon
                    AnimatedScale(
                      duration: widget.duration,
                      scale: _isHovering ? 0 : 1,
                      child: Icon(
                        widget.item.icon,
                        color: const Color(0xFF777777),
                        size: widget.size * 0.45,
                      ),
                    ),
                    // Title
                    AnimatedScale(
                      duration: widget.duration,
                      scale: _isHovering ? 1 : 0,
                      child: Text(
                        widget.item.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: widget.size * 0.25,
                          letterSpacing: 0.1,
                          fontWeight: FontWeight.bold,
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
