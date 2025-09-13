import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'models/rotating_cube_theme.dart';

/// A widget that displays a continuously rotating 3D cube.
///
/// The cube can be customized with different widgets for each of its six faces.
/// The rotation animation starts automatically and can be paused on hover.
class RotatingCube extends StatefulWidget {
  /// The widget to display on the front face.
  final Widget frontFace;

  /// The widget to display on the back face.
  final Widget backFace;

  /// The widget to display on the top face.
  final Widget topFace;

  /// The widget to display on the bottom face.
  final Widget bottomFace;

  /// The widget to display on the left face.
  final Widget leftFace;

  /// The widget to display on the right face.
  final Widget rightFace;

  /// The visual theme of the cube.
  final RotatingCubeTheme theme;

  /// The duration of one full rotation cycle.
  final Duration animationDuration;

  const RotatingCube({
    Key? key,
    required this.frontFace,
    required this.backFace,
    required this.topFace,
    required this.bottomFace,
    required this.leftFace,
    required this.rightFace,
    this.theme = const RotatingCubeTheme(),
    this.animationDuration = const Duration(seconds: 8),
  }) : super(key: key);

  @override
  State<RotatingCube> createState() => _RotatingCubeState();
}

class _RotatingCubeState extends State<RotatingCube>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool isHovering) {
    if (isHovering) {
      _controller.stop();
    } else {
      _controller.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double perspective = widget.theme.faceSize / 2;

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.grab,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final angleY = _controller.value * 2 * math.pi;
          final angleX = _controller.value * 2 * math.pi;

          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // Add perspective
              ..rotateX(angleX)
              ..rotateY(angleY),
            alignment: Alignment.center,
            child: Stack(
              children: [
                // Front
                _buildFace(
                  widget.frontFace,
                  Matrix4.identity()..translate(0.0, 0.0, perspective),
                ),
                // Back
                _buildFace(
                  widget.backFace,
                  Matrix4.identity()
                    ..translate(0.0, 0.0, -perspective)
                    ..rotateY(math.pi),
                ),
                // Left
                _buildFace(
                  widget.leftFace,
                  Matrix4.identity()
                    ..translate(-perspective, 0.0, 0.0)
                    ..rotateY(-math.pi / 2),
                ),
                // Right
                _buildFace(
                  widget.rightFace,
                  Matrix4.identity()
                    ..translate(perspective, 0.0, 0.0)
                    ..rotateY(math.pi / 2),
                ),
                // Top
                _buildFace(
                  widget.topFace,
                  Matrix4.identity()
                    ..translate(0.0, -perspective, 0.0)
                    ..rotateX(math.pi / 2),
                ),
                // Bottom
                _buildFace(
                  widget.bottomFace,
                  Matrix4.identity()
                    ..translate(0.0, perspective, 0.0)
                    ..rotateX(-math.pi / 2),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFace(Widget child, Matrix4 transform) {
    final theme = widget.theme;
    return Transform(
      transform: transform,
      alignment: Alignment.center,
      child: Container(
        width: theme.faceSize,
        height: theme.faceSize,
        decoration: BoxDecoration(
          border: theme.border,
          borderRadius: BorderRadius.circular(12),
          gradient: theme.backgroundGradient,
        ),
        alignment: Alignment.center,
        child: DefaultTextStyle(
          style: theme.textStyle,
          child: child,
        ),
      ),
    );
  }
}
