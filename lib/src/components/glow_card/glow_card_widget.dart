import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'models/glow_card_theme.dart';

/// A card widget with an animated glow effect that follows the pointer.
class GlowCard extends StatefulWidget {
  /// The content to display inside the card
  final Widget child;

  /// The theme for styling the card
  final GlowCardTheme? theme;

  /// Callback when the card is tapped
  final VoidCallback? onTap;

  const GlowCard({
    super.key,
    required this.child,
    this.theme,
    this.onTap,
  });

  @override
  State<GlowCard> createState() => _GlowCardState();
}

class _GlowCardState extends State<GlowCard> {
  Offset _pointerPosition = Offset.zero;
  bool _isHovered = false;
  late GlowCardTheme _finalTheme;

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
  void didUpdateWidget(GlowCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != oldWidget.theme) {
      _updateTheme();
    }
  }

  void _updateTheme() {
    _finalTheme = widget.theme ??
        Theme.of(context).extension<GlowCardTheme>() ??
        const GlowCardTheme();
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
          // Card with static border
          Container(
            decoration: BoxDecoration(
              color: _finalTheme.backgroundColor,
              borderRadius: BorderRadius.circular(_finalTheme.borderRadius),
              border: Border.all(
                color: _finalTheme.borderColor,
                width: _finalTheme.borderWidth,
              ),
            ),
            child: widget.child,
          ),
          // Glow effect
          Positioned.fill(
            child: AnimatedOpacity(
              opacity: _isHovered ? _finalTheme.glowOpacity : 0.0,
              duration: _finalTheme.animationDuration,
              child: CustomPaint(
                painter: GlowPainter(
                  pointerPosition: _pointerPosition,
                  color: _finalTheme.glowColor,
                  strokeWidth: _finalTheme.glowStrokeWidth,
                  blurRadius: _finalTheme.glowBlurRadius,
                  borderRadius: _finalTheme.borderRadius,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter for the glow effect
class GlowPainter extends CustomPainter {
  final Offset pointerPosition;
  final Color color;
  final double strokeWidth;
  final double blurRadius;
  final double borderRadius;

  GlowPainter({
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
          color.withValues(alpha: 0.12),
          color,
          Colors.transparent,
        ],
        stops: const [0.0, 0.3, 0.7, 1.0],
        transform: GradientRotation(adjustedAngle * math.pi / 180),
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurRadius);

    canvas.drawPath(path, shaderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
