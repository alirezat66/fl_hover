import 'package:flutter/material.dart';
import 'models/hover_underline_theme.dart';

/// A widget that displays any child with animated underlines on hover.
///
/// The underlines appear above and below the child with a gradient effect,
/// animating from the edges toward the center on hover.
class HoverUnderline extends StatefulWidget {
  /// The child widget to display
  final Widget child;

  /// The theme for styling the widget
  final HoverUnderlineTheme theme;

  /// Callback when the widget is tapped
  final VoidCallback? onTap;

  const HoverUnderline({
    super.key,
    required this.child,
    required this.theme,
    this.onTap,
  });

  @override
  State<HoverUnderline> createState() => _HoverUnderlineState();
}

class _HoverUnderlineState extends State<HoverUnderline>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.theme.animationDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.theme.animationCurve,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleHoverEnter() {
    _controller.forward();
  }

  void _handleHoverExit() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHoverEnter(),
      onExit: (_) => _handleHoverExit(),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: widget.theme.underlineOffset),
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  // Top underline (starts from left, like CSS ::before)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Transform.scale(
                      scaleX: _animation.value,
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: widget.theme.underlineHeight,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: widget.theme.underlineColors,
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Bottom underline (starts from right, like CSS ::after)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Transform.scale(
                      scaleX: _animation.value,
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: widget.theme.underlineHeight,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: widget.theme.underlineColors,
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Child widget
                  widget.child,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
