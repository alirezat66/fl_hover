import 'package:flutter/material.dart';
import '../../../playground/playground_theme.dart';
import '../../../playground/playground_property.dart';
import '../../../models/cursor_behavior.dart';

/// Defines the visual properties for the [SplitImage] widget.
///
/// This theme controls all aspects of the holographic split image effect,
/// including the number of columns, animation timing, and individual column
/// movement patterns.
class SplitImageTheme extends ThemeExtension<SplitImageTheme>
    implements PlaygroundTheme {
  /// The number of vertical columns to split the image into.
  ///
  /// Each column animates independently on hover. Default is 5 columns.
  final int columns;

  /// The number of rows in the grid (currently not used in rendering).
  ///
  /// Reserved for future use. Default is 5.
  final int rows;

  /// The duration of the animation when hovering.
  ///
  /// Controls how long it takes for columns to move to their final position
  /// and back. Default is 400 milliseconds.
  final Duration animationDuration;

  /// The animation curve to use for column movements.
  ///
  /// Defines the easing function for the animation. Common values include
  /// [Curves.easeInOut], [Curves.bounceOut], [Curves.elasticOut], etc.
  /// Default is [Curves.easeInOut].
  final Curve animationCurve;

  /// The mouse cursor to display when hovering over the image.
  ///
  /// Default is [CursorBehavior.pointer].
  final CursorBehavior cursorBehavior;

  /// Configuration for each column's animation.
  ///
  /// A map where the key is the column index (0-based) and the value is
  /// a [CellAnimation] object defining the movement and delay for that column.
  ///
  /// Example:
  /// ```dart
  /// cellAnimations: {
  ///   0: CellAnimation(translateY: 10.0, delay: 100),  // Move down 10%, delay 100ms
  ///   1: CellAnimation(translateY: -4.0, delay: 100),  // Move up 4%, delay 100ms
  ///   2: CellAnimation(translateY: 6.0, delay: 0),     // Move down 6%, no delay
  /// }
  /// ```
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

/// Configuration for individual column animation in [SplitImage].
///
/// Each column can have its own movement direction, distance, and timing.
/// This allows for creating complex wave-like or staggered animation patterns.
class CellAnimation {
  /// The vertical movement distance as a percentage of image height.
  ///
  /// Positive values move the column down, negative values move it up.
  /// For example:
  /// - `10.0` moves the column down by 10% of the image height
  /// - `-15.0` moves the column up by 15% of the image height
  /// - `0.0` keeps the column stationary
  final double translateY;

  /// The delay before starting the animation, in milliseconds.
  ///
  /// This allows columns to animate in sequence rather than all at once.
  /// For example:
  /// - `0` starts immediately
  /// - `100` waits 100ms before starting
  /// - `200` waits 200ms before starting
  final int delay;

  /// Creates a cell animation configuration.
  ///
  /// Example:
  /// ```dart
  /// CellAnimation(
  ///   translateY: -20.0,  // Move up 20% of image height
  ///   delay: 150,         // Wait 150ms before starting
  /// )
  /// ```
  const CellAnimation({
    required this.translateY,
    required this.delay,
  });
}
