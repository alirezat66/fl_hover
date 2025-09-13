import 'package:flutter/material.dart';
import 'models/animated_nav_menu_item.dart';
import 'animated_nav_menu_item_widget.dart';

/// A navigation menu with items that expand to show a title on hover.
class AnimatedNavMenu extends StatelessWidget {
  /// The list of items to display in the menu.
  final List<AnimatedNavMenuItem> items;

  /// The size (width and height) of the collapsed menu items.
  final double itemSize;

  /// The width of the menu items when expanded on hover.
  final double itemHoverWidth;

  /// The spacing between menu items.
  final double spacing;

  /// The duration for the expand/collapse animation.
  final Duration animationDuration;

  const AnimatedNavMenu({
    Key? key,
    required this.items,
    this.itemSize = 60.0,
    this.itemHoverWidth = 180.0,
    this.spacing = 25.0,
    this.animationDuration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      alignment: WrapAlignment.center,
      children: items.map((item) {
        return AnimatedNavMenuItemWidget(
          item: item,
          size: itemSize,
          hoverWidth: itemHoverWidth,
          duration: animationDuration,
        );
      }).toList(),
    );
  }
}
