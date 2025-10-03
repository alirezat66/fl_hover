import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'models/split_image_theme.dart';

/// A widget that creates a holographic split image effect.
///
/// The [SplitImage] widget splits an image into multiple vertical columns
/// that animate up and down on hover, creating a dynamic holographic effect.
/// Each column can have independent animation settings including direction,
/// delay, and movement distance.
///
/// Example:
/// ```dart
/// SplitImage(
///   image: AssetImage('assets/my_image.jpg'),
///   theme: SplitImageTheme(
///     columns: 5,
///     animationDuration: Duration(milliseconds: 400),
///     animationCurve: Curves.easeInOut,
///     cellAnimations: {
///       0: CellAnimation(translateY: -20.0, delay: 0),
///       1: CellAnimation(translateY: 15.0, delay: 50),
///       2: CellAnimation(translateY: -25.0, delay: 100),
///       3: CellAnimation(translateY: 20.0, delay: 150),
///       4: CellAnimation(translateY: -15.0, delay: 200),
///     },
///   ),
/// )
/// ```
class SplitImage extends StatefulWidget {
  /// The image to display and split into columns.
  ///
  /// This can be any [ImageProvider] such as [AssetImage], [NetworkImage],
  /// or [FileImage].
  final ImageProvider image;

  /// The theme configuration for the split image effect.
  ///
  /// If not provided, uses the [SplitImageTheme] from the current theme
  /// or defaults to [SplitImageTheme()].
  final SplitImageTheme? theme;

  /// Optional callback when the image is tapped.
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
  List<AnimationController> _controllers = [];
  List<Animation<double>> _animations = [];
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _updateTheme();
    _loadImage();
    _setupAnimations();
  }

  void _setupAnimations() {
    // Dispose old controllers if they exist
    if (_controllers.isNotEmpty) {
      for (var controller in _controllers) {
        controller.dispose();
      }
    }

    _controllers = List.generate(
      _finalTheme.columns,
      (index) => AnimationController(
        vsync: this,
        duration: _finalTheme.animationDuration,
      ),
    );

    _animations = _controllers.map((controller) {
      return CurvedAnimation(
        parent: controller,
        curve: _finalTheme.animationCurve,
      );
    }).toList();
  }

  void _onHover(bool isHovering) {
    setState(() {
      _isHovered = isHovering;
    });

    if (isHovering) {
      final cellAnimations =
          _finalTheme.getCellAnimationsForColumns(_controllers.length);
      for (int col = 0; col < _controllers.length; col++) {
        final cellConfig = cellAnimations[col];
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
    final oldTheme = _finalTheme;
    _updateTheme();
    // If theme changed (e.g., columns count), re-setup animations
    if (oldTheme.columns != _finalTheme.columns ||
        oldTheme.animationDuration != _finalTheme.animationDuration ||
        oldTheme.animationCurve != _finalTheme.animationCurve) {
      _setupAnimations();
    }
  }

  @override
  void didUpdateWidget(SplitImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.theme != oldWidget.theme) {
      _updateTheme();
      _setupAnimations();
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
    return GestureDetector(
      onTap: widget.onTap,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final displayWidth = constraints.maxWidth;
          final displayHeight = displayWidth * 1.3;

          const gap = 0.0;
          final totalGaps = (_finalTheme.columns - 1) * gap;
          final columnWidth = (displayWidth - totalGaps) / _finalTheme.columns;
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
                  final cellAnimations = _finalTheme
                      .getCellAnimationsForColumns(_finalTheme.columns);
                  final cellConfig = cellAnimations[col];
                  final translateYPercent = cellConfig?.translateY ?? 0.0;

                  return AnimatedBuilder(
                    animation: _animations[col],
                    builder: (context, child) {
                      final progress = _animations[col].value;
                      final offsetY =
                          (displayHeight * translateYPercent / 100) * progress;

                      final topPosition = extraSpace + offsetY;
                      final bottomPosition = extraSpace - offsetY;

                      return Positioned(
                        left: col * (columnWidth + gap),
                        top: topPosition,
                        bottom: bottomPosition,
                        child: MouseRegion(
                          cursor: _finalTheme.cursorBehavior.mouseCursor,
                          onEnter: (_) => _onHover(true),
                          onExit: (_) => _onHover(false),
                          child: CustomPaint(
                            size: Size(columnWidth, displayHeight),
                            painter: ImageSlicePainter(
                              image: _resolvedImage!,
                              sliceIndex: col,
                              totalSlices: _finalTheme.columns,
                            ),
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
