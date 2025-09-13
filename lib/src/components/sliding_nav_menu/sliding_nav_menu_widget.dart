import 'package:flutter/material.dart';
import 'models/sliding_nav_menu_item.dart';

/// An individual item widget for [SlidingNavMenu].
class _SlidingNavMenuItemWidget extends StatefulWidget {
  final SlidingNavMenuItem item;
  final double itemHeight;
  final TextStyle textStyle;
  final Duration duration;

  const _SlidingNavMenuItemWidget({
    Key? key,
    required this.item,
    required this.itemHeight,
    required this.textStyle,
    required this.duration,
  }) : super(key: key);

  @override
  __SlidingNavMenuItemWidgetState createState() =>
      __SlidingNavMenuItemWidgetState();
}

class __SlidingNavMenuItemWidgetState extends State<_SlidingNavMenuItemWidget> {
  bool _isHovering = false;

  void _onHover(bool isHovering) {
    setState(() {
      _isHovering = isHovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.item.onTap,
        child: Container(
          height: widget.itemHeight,
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: widget.item.highlightColor, width: 5),
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                alignment: Alignment.centerLeft,
                children: [
                  // Sliding background
                  AnimatedContainer(
                    duration: widget.duration,
                    // Animate between 0 and the actual measured width.
                    width: _isHovering ? constraints.maxWidth : 0,
                    color: widget.item.highlightColor,
                  ),
                  // Text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: AnimatedDefaultTextStyle(
                      duration: widget.duration,
                      style: _isHovering
                          ? widget.textStyle.copyWith(color: Colors.white)
                          : widget.textStyle,
                      child: Text(widget.item.title),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

/// A vertical navigation menu where items reveal a colored background that
/// slides in from the left on hover.
class SlidingNavMenu extends StatelessWidget {
  /// The list of items to display in the menu.
  final List<SlidingNavMenuItem> items;

  /// The width of the menu.
  final double width;

  /// The height of each individual menu item.
  final double itemHeight;

  /// The background color of the menu container.
  final Color backgroundColor;

  /// The text style for the menu item titles.
  final TextStyle textStyle;

  /// The duration of the slide animation.
  final Duration animationDuration;

  const SlidingNavMenu({
    Key? key,
    required this.items,
    this.width = 300.0,
    this.itemHeight = 60.0,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.textStyle = const TextStyle(color: Color(0xFF444444), fontSize: 16),
    this.animationDuration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      color: backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: items.map((item) {
          return _SlidingNavMenuItemWidget(
            item: item,
            itemHeight: itemHeight,
            textStyle: textStyle,
            duration: animationDuration,
          );
        }).toList(),
      ),
    );
  }
}
