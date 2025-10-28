import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'models/glow_glass_card_theme.dart';

/// A glassmorphism card with an animated glow effect that follows the pointer.
class GlowGlassCard extends StatefulWidget {
  /// The content to display inside the card
  final Widget child;

  /// The theme for styling the card
  final GlowGlassCardTheme? theme;

  /// Callback when the card is tapped
  final VoidCallback? onTap;

  const GlowGlassCard({
    super.key,
    required this.child,
    this.theme,
    this.onTap,
  });

  @override
  State<GlowGlassCard> createState() => _GlowGlassCardState();
}

class _GlowGlassCardState extends State<GlowGlassCard> {
  Offset _pointerPosition = Offset.zero;
  bool _isHovered = false;
  late GlowGlassCardTheme _finalTheme;

  @override
  void initState() {
    super.initState();
    _updateTheme();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateTheme();
  }

  @override
  void didUpdateWidget(GlowGlassCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != oldWidget.theme) {
      _updateTheme();
    }
  }

  void _updateTheme() {
    _finalTheme = widget.theme ??
        Theme.of(context).extension<GlowGlassCardTheme>() ??
        const GlowGlassCardTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _finalTheme.cardPadding,
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            _isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            _isHovered = false;
          });
        },
        onHover: (event) {
          setState(() {
            final RenderBox? box = context.findRenderObject() as RenderBox?;
            if (box != null) {
              final localPosition = box.globalToLocal(event.position);
              _pointerPosition = localPosition -
                  Offset(box.size.width / 2, box.size.height / 2);
            }
          });
        },
        child: _buildCardContent(context),
      ),
    );
  }

  Widget _buildCardContent(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Stack(
        children: [
          // Glass card with backdrop filter
          ClipRRect(
            borderRadius: BorderRadius.circular(_finalTheme.borderRadius),
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(
                sigmaX: _finalTheme.blurAmount,
                sigmaY: _finalTheme.blurAmount,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: _finalTheme.backgroundColor.withValues(
                    alpha: _finalTheme.backgroundOpacity,
                  ),
                  borderRadius: BorderRadius.circular(_finalTheme.borderRadius),
                  border: Border.all(
                    color: _finalTheme.borderColor.withValues(alpha: 0.3),
                    width: _finalTheme.borderWidth,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _finalTheme.shadowColor,
                      blurRadius: _finalTheme.shadowBlurRadius,
                      offset: _finalTheme.shadowOffset,
                    ),
                  ],
                ),
                child: widget.child,
              ),
            ),
          ),
          // Glow effect
          Positioned.fill(
            child: AnimatedOpacity(
              opacity: _isHovered ? _finalTheme.glowOpacity : 0.0,
              duration: _finalTheme.animationDuration,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(_finalTheme.borderRadius),
                child: CustomPaint(
                  painter: GlassGlowPainter(
                    pointerPosition: _pointerPosition,
                    color: _finalTheme.glowColor,
                    strokeWidth: _finalTheme.glowStrokeWidth,
                    blurRadius: _finalTheme.glowBlurRadius,
                    borderRadius: _finalTheme.borderRadius,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter for the glass glow effect
class GlassGlowPainter extends CustomPainter {
  final Offset pointerPosition;
  final Color color;
  final double strokeWidth;
  final double blurRadius;
  final double borderRadius;

  GlassGlowPainter({
    required this.pointerPosition,
    required this.color,
    required this.strokeWidth,
    required this.blurRadius,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final angle =
        math.atan2(pointerPosition.dy, pointerPosition.dx) * 180 / math.pi + 70;
    final adjustedAngle = (angle + 360) % 360;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(1, 1, size.width - 2, size.height - 2),
          Radius.circular(borderRadius - 2),
        ),
      );

    final shaderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = SweepGradient(
        colors: [
          Colors.transparent,
          color.withValues(alpha: 0.15),
          color.withValues(alpha: 0.8),
          color,
          color.withValues(alpha: 0.8),
          color.withValues(alpha: 0.15),
          Colors.transparent,
        ],
        stops: const [0.0, 0.2, 0.4, 0.5, 0.6, 0.8, 1.0],
        transform: GradientRotation(adjustedAngle * math.pi / 180),
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurRadius);

    canvas.drawPath(path, shaderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
