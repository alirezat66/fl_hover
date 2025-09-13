import 'package:flutter/material.dart';
import 'models/animated_underline_nav_item.dart';
import 'underline_painter.dart';

/// An individual item widget for [AnimatedUnderlineNav].
class _AnimatedUnderlineNavItemWidget extends StatefulWidget {
  final AnimatedUnderlineNavItem item;
  final Duration duration;
  final Color defaultColor;
  final Color hoverColor;
  final TextStyle textStyle;

  const _AnimatedUnderlineNavItemWidget({
    Key? key,
    required this.item,
    required this.duration,
    required this.defaultColor,
    required this.hoverColor,
    required this.textStyle,
  }) : super(key: key);

  @override
  __AnimatedUnderlineNavItemWidgetState createState() =>
      __AnimatedUnderlineNavItemWidgetState();
}

class __AnimatedUnderlineNavItemWidgetState
    extends State<_AnimatedUnderlineNavItemWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool isHovering) {
    setState(() {
      _isHovering = isHovering;
    });
    if (isHovering) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.item.onTap,
        child: SizedBox(
          width: 125,
          height: 50,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // The text
              AnimatedDefaultTextStyle(
                duration: widget.duration,
                style: widget.textStyle.copyWith(
                  color: _isHovering ? widget.hoverColor : widget.defaultColor,
                ),
                child: Text(widget.item.title),
              ),
              // The underline painter
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: UnderlinePainter(
                        animationValue: _controller.value,
                        color: widget.hoverColor,
                        strokeWidth: 1.5,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// A horizontal navigation menu where items draw a curvy underline on hover.
class AnimatedUnderlineNav extends StatelessWidget {
  /// The list of items to display in the menu.
  final List<AnimatedUnderlineNavItem> items;

  /// The spacing between menu items.
  final double spacing;

  /// The default color for the item text.
  final Color defaultColor;

  /// The color for the item text and underline on hover.
  final Color hoverColor;

  /// The text style for the menu item titles.
  final TextStyle textStyle;

  /// The duration of the underline animation.
  final Duration animationDuration;

  const AnimatedUnderlineNav({
    Key? key,
    required this.items,
    this.spacing = 30.0,
    this.defaultColor = const Color(0xFF777777),
    this.hoverColor = const Color(0xFFd94f5c),
    this.textStyle = const TextStyle(fontSize: 22),
    this.animationDuration = const Duration(seconds: 1),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      alignment: WrapAlignment.center,
      children: items.map((item) {
        return _AnimatedUnderlineNavItemWidget(
          item: item,
          duration: animationDuration,
          defaultColor: defaultColor,
          hoverColor: hoverColor,
          textStyle: textStyle,
        );
      }).toList(),
    );
  }
}
