import 'package:flutter/material.dart';
import '../../../playground/playground_theme.dart';
import '../../../playground/playground_property.dart';
import '../../../models/cursor_behavior.dart';

/// Defines the visual properties for the [SplitImage] widget.
class SplitImageTheme extends ThemeExtension<SplitImageTheme>
    implements PlaygroundTheme {
  /// The number of columns in the grid
  final int columns;

  /// The number of rows in the grid
  final int rows;

  /// The duration of the animation
  final Duration animationDuration;

  /// The curve for the animation
  final Curve animationCurve;

  /// The cursor behavior when hovering
  final CursorBehavior cursorBehavior;

  /// Cell-specific animation configurations
  /// Map of cell index to (translateY percentage, delay in ms)
  final Map<int, CellAnimation> cellAnimations;

  const SplitImageTheme({
    this.columns = 5,
    this.rows = 5,
    this.animationDuration = const Duration(milliseconds: 400),
    this.animationCurve = Curves.easeInOut,
    this.cursorBehavior = CursorBehavior.pointer,
    this.cellAnimations = const {
      0: CellAnimation(translateY: 10.0, delay: 100),
      1: CellAnimation(translateY: -4.0, delay: 100),
      2: CellAnimation(translateY: 6.0, delay: 0),
      3: CellAnimation(translateY: 4.0, delay: 150),
      4: CellAnimation(translateY: -10.0, delay: 50),
    },
  });

  @override
  SplitImageTheme copyWith({
    int? columns,
    int? rows,
    Duration? animationDuration,
    Curve? animationCurve,
    CursorBehavior? cursorBehavior,
    Map<int, CellAnimation>? cellAnimations,
  }) {
    return SplitImageTheme(
      columns: columns ?? this.columns,
      rows: rows ?? this.rows,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      cursorBehavior: cursorBehavior ?? this.cursorBehavior,
      cellAnimations: cellAnimations ?? this.cellAnimations,
    );
  }

  @override
  SplitImageTheme lerp(ThemeExtension<SplitImageTheme>? other, double t) {
    if (other is! SplitImageTheme) {
      return this;
    }
    return SplitImageTheme(
      columns: t < 0.5 ? columns : other.columns,
      rows: t < 0.5 ? rows : other.rows,
      animationDuration: Duration(
        milliseconds: lerpDouble(
          animationDuration.inMilliseconds.toDouble(),
          other.animationDuration.inMilliseconds.toDouble(),
          t,
        ).round(),
      ),
      animationCurve: t < 0.5 ? animationCurve : other.animationCurve,
      cursorBehavior: t < 0.5 ? cursorBehavior : other.cursorBehavior,
      cellAnimations: t < 0.5 ? cellAnimations : other.cellAnimations,
    );
  }

  static double lerpDouble(double a, double b, double t) {
    return a + (b - a) * t;
  }

  @override
  List<EditableProperty<dynamic>> getEditableProperties(
      [void Function(PlaygroundTheme)? onChanged]) {
    return [
      EditableProperty<int>(
        label: 'Columns',
        value: columns,
        onChanged: (cols) {
          if (onChanged != null) {
            onChanged(copyWith(columns: cols));
          }
        },
      ),
      EditableProperty<int>(
        label: 'Rows',
        value: rows,
        onChanged: (r) {
          if (onChanged != null) {
            onChanged(copyWith(rows: r));
          }
        },
      ),
      EditableProperty<int>(
        label: 'Animation Duration (ms)',
        value: animationDuration.inMilliseconds,
        onChanged: (duration) {
          if (onChanged != null) {
            onChanged(copyWith(
              animationDuration: Duration(milliseconds: duration),
            ));
          }
        },
      ),
      EditableProperty<String?>(
        label: 'Animation Curve',
        value: _getCurveDisplayName(animationCurve),
        onChanged: (curveString) {
          final curve = _getCurveFromString(curveString);
          if (curve != null && onChanged != null) {
            onChanged(copyWith(animationCurve: curve));
          }
        },
      ),
      EditableProperty<String?>(
        label: 'Cursor Behavior',
        value: cursorBehavior.displayName,
        onChanged: (cursorString) {
          final cursor = CursorBehavior.fromString(cursorString);
          if (cursor != null && onChanged != null) {
            onChanged(copyWith(cursorBehavior: cursor));
          }
        },
      ),
    ];
  }

  String _getCurveDisplayName(Curve curve) {
    if (curve == Curves.ease) return 'ease';
    if (curve == Curves.easeIn) return 'easeIn';
    if (curve == Curves.easeOut) return 'easeOut';
    if (curve == Curves.easeInOut) return 'easeInOut';
    if (curve == Curves.fastOutSlowIn) return 'fastOutSlowIn';
    if (curve == Curves.bounceIn) return 'bounceIn';
    if (curve == Curves.bounceOut) return 'bounceOut';
    if (curve == Curves.bounceInOut) return 'bounceInOut';
    if (curve == Curves.elasticIn) return 'elasticIn';
    if (curve == Curves.elasticOut) return 'elasticOut';
    if (curve == Curves.elasticInOut) return 'elasticInOut';
    if (curve == Curves.linear) return 'linear';
    return curve.toString();
  }

  Curve? _getCurveFromString(String? curveString) {
    if (curveString == null) return null;
    switch (curveString) {
      case 'ease':
        return Curves.ease;
      case 'easeIn':
        return Curves.easeIn;
      case 'easeOut':
        return Curves.easeOut;
      case 'easeInOut':
        return Curves.easeInOut;
      case 'fastOutSlowIn':
        return Curves.fastOutSlowIn;
      case 'bounceIn':
        return Curves.bounceIn;
      case 'bounceOut':
        return Curves.bounceOut;
      case 'bounceInOut':
        return Curves.bounceInOut;
      case 'elasticIn':
        return Curves.elasticIn;
      case 'elasticOut':
        return Curves.elasticOut;
      case 'elasticInOut':
        return Curves.elasticInOut;
      case 'linear':
        return Curves.linear;
      default:
        return null;
    }
  }
}

/// Configuration for individual cell animation
class CellAnimation {
  final double translateY; // Percentage (e.g., 10.0 = 10%)
  final int delay; // Delay in milliseconds

  const CellAnimation({
    required this.translateY,
    required this.delay,
  });
}
