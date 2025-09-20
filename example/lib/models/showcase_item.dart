import 'package:flutter/material.dart';

/// Enum for categorizing the hover effects.
enum ShowcaseCategory {
  card,
  button,
  navigation,
  effect,
}

/// A data model to hold the necessary information for each showcase item.
/// This helps in organizing the showcase page and the playground pages.
class ShowcaseItem {
  /// The unique identifier and display name of the widget, e.g., "FlipCard".
  final String name;

  /// The category this widget belongs to.
  final ShowcaseCategory category;

  /// A builder function that returns an instance of the hover widget.
  /// This is used to display the preview in the main showcase grid.
  final Widget Function() widgetBuilder;

  /// The default code snippet for the widget.
  /// This is used for the "Copy Default Code" button.
  final String defaultCode;

  // In the future, this will be used to build the playground page.
  // final Widget Function() playgroundBuilder;

  ShowcaseItem({
    required this.name,
    required this.category,
    required this.widgetBuilder,
    required this.defaultCode,
  });
}
