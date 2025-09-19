import 'dart:math' as math;

import 'package:flutter/material.dart';

class MyHolographicCard extends StatefulWidget {
  const MyHolographicCard({
    super.key,
    this.text = 'HOLOGRAM',
    this.width = 300,
    this.height = 200,
    this.borderRadius = 15,
    this.fontSize = 32,
  });

  final String text;
  final double width;
  final double height;
  final double borderRadius;
  final double fontSize;

  @override
  State<MyHolographicCard> createState() => _MyHolographicCardState();
}

class _MyHolographicCardState extends State<MyHolographicCard>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(widget.borderRadius);

    // Scale matches the CSS :hover transform: scale(1.05)
    final scale = _hovered ? 1.05 : 1.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        // Mobile: give a brief "hover" feel on tap down/up
        onTapDown: (_) => setState(() => _hovered = true),
        onTapCancel: () => setState(() => _hovered = false),
        onTapUp: (_) => setState(() => _hovered = false),
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: const Color(0xFF111111),
              borderRadius: radius,
              boxShadow: _hovered
                  ? [
                      // 0 0 20px rgba(0,255,255,0.5)
                      const BoxShadow(
                        color: Color(0x8000FFFF),
                        blurRadius: 20,
                        spreadRadius: 0,
                        offset: Offset.zero,
                      ),
                    ]
                  : null,
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Diagonal cyan sweep that animates in/out like ::before
                _DiagonalSweep(isVisible: _hovered),
                // Title text
                Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF00FFFF),
                    fontSize: widget.fontSize,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
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

/// A translucent, rotated gradient bar that slides across the card,
/// approximating the CSS ::before sweep (rotate(-45deg) + translateY).
class _DiagonalSweep extends StatelessWidget {
  const _DiagonalSweep({required this.isVisible});

  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    // Oversized container to cover the card diagonally (similar to 200% size in CSS)
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
      tween: Tween<double>(
          begin: isVisible ? 1.0 : 0.0, end: isVisible ? 1.0 : 0.0),
      builder: (context, t, child) {
        // Opacity transitions like ::before { opacity }
        final opacity = isVisible ? 1.0 : 0.0;

        // Translate along the rotated axis; when visible, slide “through”
        final slide =
            isVisible ? 0.0 : 1.0; // 1.0 means shifted down/out, 0.0 centered

        return AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: opacity,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final h = constraints.maxHeight;

              return Transform.rotate(
                angle: -0.78539816339, // -45deg in radians
                child: FractionalTranslation(
                  translation: Offset(0, slide), // move along Y after rotation
                  child: Container(
                    // ~200% area to mimic CSS width/height: 200%
                    width: w * 2,
                    height: h * 2,
                    decoration: const BoxDecoration(
                      // linear-gradient(0deg, transparent, transparent 30%, rgba(0,255,255,0.3))
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Color.fromARGB(77, 0, 255, 255), // ~0.3 alpha
                        ],
                        stops: [0.0, 0.3, 1.0],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
