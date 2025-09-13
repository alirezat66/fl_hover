import 'package:flutter/material.dart';
import 'models/scotch_showcase_theme.dart';
import 'scotch_showcase_background_painter.dart';

/// A widget that replicates the vintage "Scotch Videocassette" product showcase.
class ScotchShowcase extends StatefulWidget {
  final String title;
  final String subtitle;
  final String code;
  final String description;
  final VoidCallback onBuyNow;
  final VoidCallback onLearnMore;
  final ImageProvider? noiseTexture;
  final Widget? hoverOverlay;
  final ScotchShowcaseTheme theme;
  final Duration animationDuration;

  const ScotchShowcase({
    Key? key,
    this.title = 'Scotch',
    this.subtitle = 'VIDEOCASSETTE EG',
    this.code = 'T 120',
    this.description =
        'Designed by the inventors of videotape, this Scotch EG Videocasette gives your superior performance',
    required this.onBuyNow,
    required this.onLearnMore,
    this.noiseTexture,
    this.hoverOverlay,
    this.theme = const ScotchShowcaseTheme(),
    this.animationDuration = const Duration(milliseconds: 200),
  }) : super(key: key);

  @override
  State<ScotchShowcase> createState() => _ScotchShowcaseState();
}

class _ScotchShowcaseState extends State<ScotchShowcase> {
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
      child: Container(
        width: 960,
        height: 580,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(),
        child: Stack(
          children: [
            // Background
            Positioned.fill(
              child: CustomPaint(
                painter: ScotchShowcaseBackgroundPainter(
                  darkColor: theme.darkColor,
                  midDarkColor: theme.midDarkColor,
                ),
              ),
            ),
            // Noise Texture
            if (widget.noiseTexture != null)
              Positioned.fill(
                child: Opacity(
                  opacity: 0.1,
                  child: Image(
                    image: widget.noiseTexture!,
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.repeat,
                  ),
                ),
              ),

            // Hover Overlay (e.g., GIF)
            if (widget.hoverOverlay != null)
              Positioned.fill(
                child: AnimatedOpacity(
                  duration: widget.animationDuration,
                  opacity: _isHovering ? 0.64 : 0.0,
                  child: widget.hoverOverlay!,
                ),
              ),

            // Main Content
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 128, vertical: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Text Content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.title, style: theme.titleStyle),
                            Text(widget.subtitle, style: theme.subtitleStyle),
                            Text(widget.code, style: theme.codeStyle),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: 390,
                              child: Text(widget.description,
                                  style: theme.descriptionStyle),
                            ),
                            const SizedBox(height: 30),
                            _buildBuyButton(isCTA: true),
                          ],
                        ),
                      ),
                      const SizedBox(width: 128),
                      // Sphere
                      _buildSphere(),
                    ],
                  ),
                  _buildLearnMore(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSphere() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onBuyNow,
        child: AnimatedScale(
          duration: widget.animationDuration,
          scale: _isHovering ? 1.1 : 1.0,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: widget.theme.sphereGradient,
              border: Border.all(color: widget.theme.darkColor, width: 3),
              boxShadow: [
                if (_isHovering)
                  const BoxShadow(
                    color: Colors.black54,
                    offset: Offset(16, 16),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBuyButton({bool isCTA = false}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onBuyNow,
        child: Container(
          width: isCTA ? 200 : 128,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.theme.lightColor,
            border:
                isCTA ? null : Border.all(color: widget.theme.midLightColor),
          ),
          child: Text(
            'Buy Now',
            style: TextStyle(
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w900,
              color: widget.theme.darkColor,
              fontSize: isCTA ? 16 : 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLearnMore() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onLearnMore,
        child: Column(
          children: [
            Text(
              'LEARN MORE',
              style: TextStyle(
                  fontFamily: 'Mulish',
                  color: widget.theme.lightColor,
                  fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              '🢓',
              style: TextStyle(color: widget.theme.lightColor, fontSize: 32),
            ),
          ],
        ),
      ),
    );
  }
}
