import 'package:flutter/material.dart';

class _Keyframe {
  const _Keyframe({required this.progress, required this.top, required this.bottom});

  final double progress;
  final double top;
  final double bottom;
}

Path _pathFromFrame(_Keyframe frame, Size size, double intensity) {
  double top = frame.top;
  double bottom = frame.bottom;

  // Ensure at least a small thickness
  if ((bottom - top).abs() < 0.5) {
    final center = (top + bottom) / 2;
    final spread = 1.5 * intensity;
    top = (center - spread).clamp(0.0, 100.0);
    bottom = (center + spread).clamp(0.0, 100.0);
  } else {
    final center = (top + bottom) / 2;
    final half = ((bottom - top).abs() / 2) * intensity;
    top = (center - half).clamp(0.0, 100.0);
    bottom = (center + half).clamp(0.0, 100.0);
  }

  if (bottom <= top) {
    bottom = top + 1;
  }

  final topPx = size.height * (top / 100.0);
  final bottomPx = size.height * (bottom / 100.0);
  return Path()..addRect(Rect.fromLTRB(0, topPx, size.width, bottomPx));
}

_Keyframe _frameForValue(List<_Keyframe> frames, double value) {
  for (final frame in frames) {
    if (value <= frame.progress) {
      return frame;
    }
  }
  return frames.last;
}

abstract class GlitchClipperBase extends CustomClipper<Path> {
  GlitchClipperBase({required this.animationValue, required this.intensity});

  final double animationValue;
  final double intensity;

  List<_Keyframe> get frames;

  @override
  Path getClip(Size size) {
    final frame = _frameForValue(frames, animationValue);
    return _pathFromFrame(frame, size, intensity);
  }

  @override
  bool shouldReclip(covariant GlitchClipperBase oldClipper) {
    return animationValue != oldClipper.animationValue ||
        intensity != oldClipper.intensity;
  }
}

class GlitchClipper1 extends GlitchClipperBase {
  GlitchClipper1({required super.animationValue, required super.intensity});

  @override
  List<_Keyframe> get frames => const [
        _Keyframe(progress: 0.00, top: 2, bottom: 5),
        _Keyframe(progress: 0.20, top: 15, bottom: 15),
        _Keyframe(progress: 0.30, top: 10, bottom: 20),
        _Keyframe(progress: 0.40, top: 1, bottom: 2),
        _Keyframe(progress: 0.50, top: 33, bottom: 33),
        _Keyframe(progress: 0.55, top: 44, bottom: 44),
        _Keyframe(progress: 0.60, top: 20, bottom: 50),
        _Keyframe(progress: 0.65, top: 70, bottom: 70),
        _Keyframe(progress: 0.70, top: 80, bottom: 80),
        _Keyframe(progress: 0.80, top: 50, bottom: 55),
        _Keyframe(progress: 0.85, top: 60, bottom: 65),
        _Keyframe(progress: 0.95, top: 72, bottom: 78),
        _Keyframe(progress: 1.00, top: 2, bottom: 5),
      ];
}

class GlitchClipper2 extends GlitchClipperBase {
  GlitchClipper2({required super.animationValue, required super.intensity});

  @override
  List<_Keyframe> get frames => const [
        _Keyframe(progress: 0.00, top: 25, bottom: 30),
        _Keyframe(progress: 0.10, top: 3, bottom: 3),
        _Keyframe(progress: 0.15, top: 5, bottom: 20),
        _Keyframe(progress: 0.17, top: 20, bottom: 20),
        _Keyframe(progress: 0.19, top: 40, bottom: 40),
        _Keyframe(progress: 0.33, top: 52, bottom: 59),
        _Keyframe(progress: 0.35, top: 60, bottom: 60),
        _Keyframe(progress: 0.40, top: 75, bottom: 75),
        _Keyframe(progress: 0.45, top: 40, bottom: 65),
        _Keyframe(progress: 0.49, top: 45, bottom: 50),
        _Keyframe(progress: 0.50, top: 14, bottom: 33),
        _Keyframe(progress: 0.55, top: 15, bottom: 35),
        _Keyframe(progress: 0.60, top: 15, bottom: 15),
        _Keyframe(progress: 0.70, top: 60, bottom: 65),
        _Keyframe(progress: 0.80, top: 80, bottom: 85),
        _Keyframe(progress: 0.90, top: 55, bottom: 65),
        _Keyframe(progress: 1.00, top: 25, bottom: 30),
      ];
}

class GlitchClipper3 extends GlitchClipperBase {
  GlitchClipper3({required super.animationValue, required super.intensity});

  @override
  List<_Keyframe> get frames => const [
        _Keyframe(progress: 0.00, top: 1, bottom: 3),
        _Keyframe(progress: 0.05, top: 9, bottom: 10),
        _Keyframe(progress: 0.11, top: 5, bottom: 6),
        _Keyframe(progress: 0.20, top: 20, bottom: 20),
        _Keyframe(progress: 0.25, top: 10, bottom: 10),
        _Keyframe(progress: 0.35, top: 25, bottom: 30),
        _Keyframe(progress: 0.42, top: 15, bottom: 16),
        _Keyframe(progress: 0.48, top: 39, bottom: 40),
        _Keyframe(progress: 0.50, top: 20, bottom: 21),
        _Keyframe(progress: 0.56, top: 55, bottom: 60),
        _Keyframe(progress: 0.61, top: 30, bottom: 31),
        _Keyframe(progress: 0.68, top: 69, bottom: 70),
        _Keyframe(progress: 0.72, top: 40, bottom: 41),
        _Keyframe(progress: 0.77, top: 75, bottom: 80),
        _Keyframe(progress: 0.81, top: 50, bottom: 51),
        _Keyframe(progress: 0.86, top: 90, bottom: 90),
        _Keyframe(progress: 0.90, top: 60, bottom: 60),
        _Keyframe(progress: 0.92, top: 99, bottom: 100),
        _Keyframe(progress: 0.94, top: 70, bottom: 71),
        _Keyframe(progress: 1.00, top: 1, bottom: 3),
      ];
}
