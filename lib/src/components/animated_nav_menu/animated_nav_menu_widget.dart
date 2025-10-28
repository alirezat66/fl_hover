import 'package:flutter/material.dart';
import 'models/animated_nav_menu_item.dart';
import 'models/animated_nav_menu_theme.dart';
import 'animated_nav_menu_item_widget.dart';

/// A navigation menu with items that expand to show a title on hover.
class AnimatedNavMenu extends StatelessWidget {
  /// The list of items to display in the menu.
  final List<AnimatedNavMenuItem> items;

  /// The theme for the navigation menu.
  final AnimatedNavMenuTheme? theme;

  const AnimatedNavMenu({
    Key? key,
    required this.items,
    this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = this.theme ??
        Theme.of(context).extension<AnimatedNavMenuTheme>() ??
        const AnimatedNavMenuTheme();

    return Wrap(
      spacing: theme.spacing,
      runSpacing: theme.spacing,
      alignment: WrapAlignment.center,
      children: items.map((item) {
        return AnimatedNavMenuItemWidget(
          item: item,
          theme: theme,
        );
      }).toList(),
    );
  }
}
