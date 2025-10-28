import 'package:fl_hover/fl_hover.dart';

import '../play_ground_page.dart';
class PlayGroundItem {
  /// A unique identifier used for routing (e.g., 'button-3d').
  final String id;

  /// The display name in the menu (e.g., '3D Button').
  final String title;

  /// The initial theme instance for the playground page.
  final PlaygroundTheme initialTheme;

  /// A function that builds the widget to be displayed.
  final WidgetBuilderWithTheme widgetBuilder;

  PlayGroundItem({
    required this.id,
    required this.title,
    required this.initialTheme,
    required this.widgetBuilder,
  });
}
