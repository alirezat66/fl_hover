import 'package:flutter/material.dart';
import 'models/sliding_nav_menu_item.dart';
import 'models/sliding_nav_menu_theme.dart';

/// A vertical navigation menu where items reveal a colored background that
/// slides in from a specified direction on hover.
class SlidingNavMenu extends StatelessWidget {
  /// The list of items to display in the menu.
  final List<SlidingNavMenuItem> items;

  /// The visual theme of the menu.
  final SlidingNavMenuTheme theme;

  /// The total width of the menu.
  final double width;

  const SlidingNavMenu({
    Key? key,
    required this.items,
    this.theme = const SlidingNavMenuTheme(),
    this.width = 300.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: theme.menuDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: items.map((item) {
          return _SlidingNavMenuItemWidget(
            item: item,
            theme: theme,
          );
        }).toList(),
      ),
    );
  }
}

/// An individual item widget for [SlidingNavMenu].
class _SlidingNavMenuItemWidget extends StatefulWidget {
  final SlidingNavMenuItem item;
  final SlidingNavMenuTheme theme;

  const _SlidingNavMenuItemWidget({
    Key? key,
    required this.item,
    required this.theme,
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

  Alignment _getAlignment() {
    switch (widget.theme.slideDirection) {
      case AxisDirection.right:
        return Alignment.centerRight;
      case AxisDirection.up:
        return Alignment.topCenter;
      case AxisDirection.down:
        return Alignment.bottomCenter;
      case AxisDirection.left:
      default:
        return Alignment.centerLeft;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final highlightColor = widget.item.highlightColor;
    final isHorizontal = theme.slideDirection == AxisDirection.left ||
        theme.slideDirection == AxisDirection.right;

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.item.onTap,
        child: SizedBox(
          height: theme.itemHeight,
          child: Stack(
            alignment: _getAlignment(),
            children: [
              // Sliding background, animated with AnimatedContainer.
              // It now animates between the `peekSize` and the full size.
              LayoutBuilder(builder: (context, constraints) {
                return AnimatedContainer(
                  duration: theme.animationDuration,
                  curve: Curves.easeOut,
                  width: isHorizontal
                      ? (_isHovering ? constraints.maxWidth : theme.peekSize)
                      : null,
                  height: !isHorizontal
                      ? (_isHovering ? constraints.maxHeight : theme.peekSize)
                      : null,
                  color: highlightColor,
                );
              }),

              // Text content with animated style, positioned to always be on top.
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: AnimatedDefaultTextStyle(
                    duration: theme.animationDuration,
                    style: _isHovering
                        ? theme.itemHoverTextStyle!
                        : theme.itemTextStyle!,
                    child: Text(widget.item.title),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
