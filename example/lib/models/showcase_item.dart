import 'package:example/play_ground_page.dart';
import 'package:flutter_hover_effects/hover_effects.dart';

/// Enum for categorizing the hover effects.
enum ShowcaseCategory {
  card,
  button,
  navigation,
  effect,
  social,
  list,
}

/// A data model to hold the necessary information for each showcase item.
/// This helps in organizing the showcase page and the playground pages.
class ShowcaseItem {
  /// The unique identifier and display name of the widget, e.g., "FlipCard".
  final String name;

  /// The category this widget belongs to.
  final ShowcaseCategory category;

  /// The initial theme instance for the playground page.
  final PlaygroundTheme initialTheme;

  /// A function that builds the widget to be displayed.
  final WidgetBuilderWithTheme widgetBuilder;

  final String defaultCode;

  // In the future, this will be used to build the playground page.
  // final Widget Function() playgroundBuilder;

  ShowcaseItem({
    required this.name,
    required this.category,
    required this.widgetBuilder,
    required this.initialTheme,
    required this.defaultCode,
  });
}
