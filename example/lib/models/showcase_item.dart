import 'package:flutter/material.dart';

/// A data model to represent a single widget showcase.
class ShowcaseItem {
  /// The title of the widget to be displayed on the card.
  final String title;

  /// A builder function that returns the widget instance to be showcased.
  final WidgetBuilder builder;

  const ShowcaseItem({
    required this.title,
    required this.builder,
  });
}
