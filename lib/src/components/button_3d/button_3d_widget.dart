import 'package:flutter/material.dart';
import 'button_3d_painter.dart';
import 'models/button_3d_theme.dart';

/// A customizable 3D button with a press-down animation effect.
///
/// This widget recreates the 3D button CSS effect using a [CustomPainter]
/// for high performance and a clean, animated user experience.
class Button3D extends StatefulWidget {
  /// The content to display inside the button. Typically a [Text] widget.
  final Widget child;

  /// The callback that is executed when the button is tapped.
  final VoidCallback onPressed;

  /// The visual theme of the button.
  final Button3DTheme theme;

  /// The height of the button.
  final double height;

  /// The width of the button. If null, it will size to its child.
  final double? width;

  /// The duration of the press and hover animations.
  final Duration animationDuration;

  const Button3D({
    Key? key,
    required this.child,
    required this.onPressed,
    this.theme = const Button3DTheme(),
    this.height = 60,
    this.width,
    this.animationDuration = const Duration(milliseconds: 175),
  }) : super(key: key);

  @override
  State<Button3D> createState() => _Button3DState();
}

class _Button3DState extends State<Button3D> with TickerProviderStateMixin {
  late final AnimationController _pressController;
  late final Animation<double> _pressAnimation;

  late final AnimationController _hoverController;
  late final Animation<double> _hoverAnimation;

  bool _isTapped = false;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _pressAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _pressController,
      curve: Curves.elasticOut,
      reverseCurve: Curves.elasticIn,
    ));

    _hoverController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _hoverAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    ));
  }

  @override
  void dispose() {
    _pressController.dispose();
    _hoverController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _isTapped = true;
    _pressController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    if (_isTapped) {
      _pressController.reverse().then((_) {
        widget.onPressed();
      });
      _isTapped = false;
    }
  }

  void _onTapCancel() {
    if (_isTapped) {
      _pressController.reverse();
      _isTapped = false;
    }
  }

  void _onHover(bool isHovering) {
    if (isHovering) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: AnimatedBuilder(
          animation: Listenable.merge([_pressAnimation, _hoverAnimation]),
          builder: (context, child) {
            final pressDepth = _pressAnimation.value * widget.theme.depth;
            return SizedBox(
              width: widget.width,
              height: widget.height +
                  widget.theme.depth, // Total height including depth
              child: Stack(
                alignment: Alignment.center, // Align non-positioned children
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: Button3DPainter(
                        pressAnimationValue: _pressAnimation.value,
                        hoverAnimationValue: _hoverAnimation.value,
                        theme: widget.theme,
                      ),
                    ),
                  ),
                  // This widget is NOT positioned. This allows the Stack to size
                  // itself to this child's content when no width is provided.
                  // We use Padding to handle the vertical "press" animation.
                  Padding(
                    padding: EdgeInsets.only(
                      top: pressDepth,
                      bottom: widget.theme.depth - pressDepth,
                    ),
                    child: DefaultTextStyle(
                      style: widget.theme.textStyle,
                      child: child!,
                    ),
                  ),
                ],
              ),
            );
          },
          child: widget.child,
        ),
      ),
    );
  }
}
