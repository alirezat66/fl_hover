import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Extension that adds hover effects to widgets
extension IncreaseHoverExt on Widget {
  /// Increases the widget's size on hover with a smooth animation
  ///
  /// [scaleFactor] - The scale factor to apply on hover (e.g., 1.2 for 20% increase)
  /// [duration] - The duration of the animation
  ///
  /// Example:
  /// ```dart
  /// Icon(Icons.favorite)
  ///   .increaseSizeOnHover(1.3)
  /// ```
  Widget increaseSizeOnHover(
    double scaleFactor, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    AlignmentGeometry alignment = Alignment.center,
    SystemMouseCursor cursor = SystemMouseCursors.click,
  }) {
    bool isHovered = false;
    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          cursor: cursor,
          onEnter: (event) {
            setState(() {
              isHovered = true;
            });
          },
          onExit: (event) {
            setState(() {
              isHovered = false;
            });
          },
          child: AnimatedContainer(
            duration: duration,
            curve: curve,
            transformAlignment: alignment,
            transform: isHovered
                ? Matrix4.diagonal3Values(scaleFactor, scaleFactor, 1.0)
                : Matrix4.diagonal3Values(1.0, 1.0, 1.0),
            child: this,
          ),
        );
      },
    );
  }

  /// Changes the widget to a different widget on hover
  ///
  /// This extension only works with Image widgets
  ///
  /// [hoverWidget] - The widget to show when hovering
  /// [duration] - The duration of the fade transition
  ///
  /// Example:
  /// ```dart
  /// Image.asset('assets/images/profile.png')
  ///   .changeWidgetOnHover(Image.asset('assets/images/profile_hover.png'))
  /// ```
  Widget changeWidgetOnHover(
    Widget hoverWidget, {
    Duration duration = const Duration(milliseconds: 300),
    AnimatedSwitcherTransitionBuilder? transitionBuilder,
    SystemMouseCursor cursor = SystemMouseCursors.click,
  }) {
    // Validate that this widget is Image
    assert(
      this is Image,
      'changeWidgetOnHover can only be used with Image widgets. '
      'Current widget type: $runtimeType',
    );

    bool isHovered = false;
    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          cursor: cursor,
          onEnter: (event) {
            setState(() {
              isHovered = true;
            });
          },
          onExit: (event) {
            setState(() {
              isHovered = false;
            });
          },
          child: AnimatedSwitcher(
            duration: duration,
            transitionBuilder: transitionBuilder ??
                (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
            child: isHovered
                ? KeyedSubtree(
                    key: const ValueKey('hover'),
                    child: hoverWidget,
                  )
                : KeyedSubtree(
                    key: const ValueKey('normal'),
                    child: this,
                  ),
          ),
        );
      },
    );
  }
}
