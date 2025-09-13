import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'models/button_3d_social_theme.dart';

/// A 3D social media button with a complex skew and lift effect on hover.
class Button3DSocial extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Button3DSocialTheme theme;
  final Duration animationDuration;

  const Button3DSocial({
    Key? key,
    required this.child,
    required this.onPressed,
    required this.theme,
    this.animationDuration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  State<Button3DSocial> createState() => _Button3DSocialState();
}

class _Button3DSocialState extends State<Button3DSocial> {
  bool _isHovering = false;

  void _onHover(bool isHovering) {
    setState(() {
      _isHovering = isHovering;
    });
  }

  // Transformation matrix for the main 3D skew effect
  static final Matrix4 _skewTransform = Matrix4.identity()
    ..setEntry(3, 2, 0.001) // perspective
    ..rotateZ(-30 * math.pi / 180)
    ..multiply(Matrix4.skewX(0.44)); // skew(25deg) is approx 0.44

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
          transform: Matrix4.translationValues(
            _isHovering ? 20 : 0,
            _isHovering ? -15 : 0,
            0,
          ),
          transformAlignment: Alignment.center,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Bottom Face
              Positioned(
                bottom: -20,
                left: -10,
                child: Transform(
                  transform: Matrix4.skewX(-0.785), // skewX(-45deg)
                  child: AnimatedContainer(
                    duration: widget.animationDuration,
                    width: theme.width,
                    height: 20,
                    color:
                        _isHovering ? theme.hoverBottomColor : theme.depthColor,
                  ),
                ),
              ),

              // Side Face
              Positioned(
                top: 10,
                left: -20,
                child: Transform(
                  transform: Matrix4.skewY(-0.785), // skewY(-45deg)
                  child: AnimatedContainer(
                    duration: widget.animationDuration,
                    width: 20,
                    height: theme.height,
                    color:
                        _isHovering ? theme.hoverSideColor : theme.depthColor,
                  ),
                ),
              ),

              // Main Face
              Transform(
                transform: _skewTransform,
                alignment: Alignment.center,
                child: AnimatedContainer(
                  duration: widget.animationDuration,
                  width: theme.width,
                  height: theme.height,
                  decoration: BoxDecoration(
                    color: _isHovering
                        ? theme.hoverBackgroundColor
                        : theme.backgroundColor,
                    boxShadow: [_isHovering ? theme.hoverShadow : theme.shadow],
                  ),
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: widget.child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
