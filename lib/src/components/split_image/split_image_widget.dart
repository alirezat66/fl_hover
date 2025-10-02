import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'models/split_image_theme.dart';

class SplitImage extends StatefulWidget {
  final ImageProvider image;
  final SplitImageTheme? theme;
  final VoidCallback? onTap;

  const SplitImage({
    super.key,
    required this.image,
    this.theme,
    this.onTap,
  });

  @override
  State<SplitImage> createState() => _SplitImageState();
}

class _SplitImageState extends State<SplitImage> with TickerProviderStateMixin {
  late SplitImageTheme _finalTheme;
  ui.Image? _resolvedImage;
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _loadImage();
    _setupAnimations();
  }

  void _setupAnimations() {
    _controllers = List.generate(
      5,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
      ),
    );

    _animations = _controllers.map((controller) {
      return CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      );
    }).toList();
  }

  void _onHover(bool isHovering) {
    setState(() {
      _isHovered = isHovering;
    });

    if (isHovering) {
      for (int col = 0; col < _controllers.length; col++) {
        final cellConfig = _finalTheme.cellAnimations[col];
        final delay = cellConfig?.delay ?? 0;

        Future.delayed(Duration(milliseconds: delay), () {
          if (mounted && _isHovered) {
            _controllers[col].forward();
          }
        });
      }
    } else {
      for (var controller in _controllers) {
        controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateTheme();
  }

  @override
  void didUpdateWidget(SplitImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != oldWidget.theme) {
      _updateTheme();
    }
    if (widget.image != oldWidget.image) {
      _loadImage();
    }
  }

  void _updateTheme() {
    _finalTheme = widget.theme ??
        Theme.of(context).extension<SplitImageTheme>() ??
        const SplitImageTheme();
  }

  Future<void> _loadImage() async {
    final ImageStream stream = widget.image.resolve(const ImageConfiguration());
    stream.addListener(ImageStreamListener((ImageInfo info, bool _) {
      if (mounted) {
        setState(() {
          _resolvedImage = info.image;
        });
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: _finalTheme.cursorBehavior.mouseCursor,
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final displayWidth = constraints.maxWidth;
            final displayHeight = displayWidth * 1.3;

            const gap = 5.0;
            final totalGaps = (_finalTheme.columns - 1) * gap;
            final columnWidth =
                (displayWidth - totalGaps) / _finalTheme.columns;
            const extraSpace = 60.0;
            final stackHeight = displayHeight + (extraSpace * 2);

            if (_resolvedImage == null) {
              return Container(
                width: displayWidth,
                height: stackHeight,
                color: Colors.amber,
              );
            }

            return Container(
              width: displayWidth,
              height: stackHeight,
              child: Stack(
                children: [
                  ...List.generate(_finalTheme.columns, (col) {
                    final cellConfig = _finalTheme.cellAnimations[col];
                    final translateYPercent = cellConfig?.translateY ?? 0.0;

                    return AnimatedBuilder(
                      animation: _animations[col],
                      builder: (context, child) {
                        final progress = _animations[col].value;
                        final offsetY =
                            (displayHeight * translateYPercent / 100) *
                                progress;

                        final topPosition = extraSpace + offsetY;
                        final bottomPosition = extraSpace - offsetY;

                        return Positioned(
                          left: col * (columnWidth + gap),
                          top: topPosition,
                          bottom: bottomPosition,
                          child: CustomPaint(
                            size: Size(columnWidth, displayHeight),
                            painter: ImageSlicePainter(
                              image: _resolvedImage!,
                              sliceIndex: col,
                              totalSlices: _finalTheme.columns,
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ImageSlicePainter extends CustomPainter {
  final ui.Image image;
  final int sliceIndex;
  final int totalSlices;

  ImageSlicePainter({
    required this.image,
    required this.sliceIndex,
    required this.totalSlices,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final imageWidth = image.width.toDouble();
    final imageHeight = image.height.toDouble();
    final sliceWidth = imageWidth / totalSlices;

    final srcRect = Rect.fromLTWH(
      sliceIndex * sliceWidth,
      0,
      sliceWidth,
      imageHeight,
    );

    final dstRect = Rect.fromLTWH(
      0,
      0,
      size.width,
      size.height,
    );

    canvas.drawImageRect(image, srcRect, dstRect, Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
