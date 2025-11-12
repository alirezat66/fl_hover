import 'package:flutter/material.dart';

import 'glitch_clippers.dart';
import 'models/glitch_image_theme.dart';

class GlitchImage extends StatefulWidget {
  const GlitchImage({
    super.key,
    required this.image,
    this.theme = const GlitchImageTheme(),
    this.onTap,
  });

  final ImageProvider image;
  final GlitchImageTheme theme;
  final VoidCallback? onTap;

  @override
  State<GlitchImage> createState() => _GlitchImageState();
}

class _GlitchImageState extends State<GlitchImage>
    with SingleTickerProviderStateMixin {
  static const Duration _glitchDuration = Duration(milliseconds: 2000);
  static const double _maxOffsetPx = 40;
  static const double _sliceIntensity = 1.0;
  static const Color _primaryShiftColor = Color(0xff56c7f4);
  static const Color _secondaryShiftColor = Color(0xffec5f67);
  static const Color _overlayColor = Color(0xffaf4949);

  late final AnimationController _controller;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _glitchDuration,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _start() {
    if (_isHovered) return;
    setState(() => _isHovered = true);
    _controller.repeat();
  }

  void _stop() {
    if (!_isHovered) return;
    setState(() => _isHovered = false);
    _controller.stop();
    _controller.reset();
  }

  Image _buildImage() => Image(
        image: widget.image,
        fit: BoxFit.cover,
        gaplessPlayback: true,
      );

  double _offsetScale(double base) {
    // CSS values were based on 40px max offset
    return base * (_maxOffsetPx / 40.0);
  }

  Widget _buildLayer1(double value) {
    final offset = Offset(_offsetScale(40), 0);
    return Transform.translate(
      offset: offset,
      child: Transform.scale(
        scaleX: -1,
        scaleY: -1,
        child: ClipPath(
          clipper: GlitchClipper1(
            animationValue: value,
            intensity: _sliceIntensity,
          ),
          child: _buildImage(),
        ),
      ),
    );
  }

  Widget _buildLayer2(double value) {
    final offset = Offset(_offsetScale(-10), 0);
    return Transform.translate(
      offset: offset,
      child: ClipPath(
        clipper: GlitchClipper2(
          animationValue: value,
          intensity: _sliceIntensity,
        ),
        child: _buildImage(),
      ),
    );
  }

  Widget _buildLayer3(double value) {
    final offset = Offset(0, _offsetScale(-5));
    return Transform.translate(
      offset: offset,
      child: Transform.scale(
        scaleX: -1,
        scaleY: -1,
        child: ClipPath(
          clipper: GlitchClipper3(
            animationValue: value,
            intensity: _sliceIntensity,
          ),
          child: _buildImage(),
        ),
      ),
    );
  }

  Widget _buildLayer4(double value) {
    final visible = value <= 0.055;
    final opacity = visible ? 0.25 : 0.0;
    final offset =
        visible ? Offset(_offsetScale(10), _offsetScale(5)) : Offset.zero;
    return Transform.translate(
      offset: offset,
      child: Opacity(
        opacity: opacity,
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            _overlayColor.withValues(alpha: _overlayColor.a * 0.6),
            BlendMode.overlay,
          ),
          child: _buildImage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _start(),
      onExit: (_) => _stop(),
      child: GestureDetector(
        onTap: widget.onTap,
        child: SizedBox(
          width: theme.width,
          height: theme.height,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final value = _controller.value;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                decoration: BoxDecoration(
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: _primaryShiftColor.withValues(
                                alpha: _primaryShiftColor.a * 0.18),
                            blurRadius: 22,
                            spreadRadius: 2,
                          ),
                        ]
                      : const [],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.hardEdge,
                    children: [
                      _buildImage(),
                      if (_isHovered) ...[
                        _buildLayer1(value),
                        _buildLayer2(value),
                        _buildLayer3(value),
                        _buildLayer4(value),
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: _secondaryShiftColor.withValues(
                                    alpha: _secondaryShiftColor.a * 0.1),
                              ),
                            ),
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
