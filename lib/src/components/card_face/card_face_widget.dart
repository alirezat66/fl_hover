import 'package:flutter/material.dart';
import 'models/card_face_theme.dart';

/// A card with two faces. On hover, the top face shrinks to reveal the bottom face.
///
/// This widget is ideal for displaying a summary on the top face (like a number or icon)
/// and detailed content on the bottom face.
class CardFace extends StatefulWidget {
  /// The content for the bottom face (face1), which is mostly visible.
  final Widget bottomFace;

  /// The content for the top face (face2), which shrinks on hover.
  final Widget topFace;

  /// The background decoration for the top face. A gradient is recommended.
  /// Note: This must be a [BoxDecoration] to allow for border radius changes.
  final BoxDecoration topFaceDecoration;

  /// The visual theme of the card.
  final CardFaceTheme theme;

  /// The duration of the shrink/expand animation.
  final Duration animationDuration;

  const CardFace({
    Key? key,
    required this.bottomFace,
    required this.topFace,
    required this.topFaceDecoration,
    this.theme = const CardFaceTheme(),
    this.animationDuration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  State<CardFace> createState() => _CardFaceState();
}

class _CardFaceState extends State<CardFace> {
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
      child: Container(
        width: theme.width,
        height: theme.height,
        decoration: BoxDecoration(
          boxShadow: [theme.shadow],
          borderRadius: theme.borderRadius,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // Bottom Face (face1)
            Container(
              width: theme.width,
              height: theme.height,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: theme.borderRadius,
              ),
              child: widget.bottomFace,
            ),

            // Top Face (face2)
            AnimatedContainer(
              duration: widget.animationDuration,
              curve: Curves.easeInOut,
              width: theme.width,
              height: _isHovering ? theme.shrunkenHeight : theme.height,
              decoration: widget.topFaceDecoration.copyWith(
                borderRadius: _isHovering
                    ? BorderRadius.only(
                        bottomLeft: theme.borderRadius.bottomLeft,
                        bottomRight: theme.borderRadius.bottomRight,
                      )
                    : theme.borderRadius,
              ),
              alignment: Alignment.center,
              child: widget.topFace,
            ),
          ],
        ),
      ),
    );
  }
}
