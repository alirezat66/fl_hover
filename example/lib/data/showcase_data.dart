import 'package:example/models/showcase_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hover_effects/hover_effects.dart';

/// A centralized data provider for all showcase items.
/// This keeps the UI layer clean and separates data from presentation.
class ShowcaseData {
  // A helper function to create a simple placeholder widget for cards.

  /// Returns the complete list of all showcase items.
  static final List<ShowcaseItem> items = [
    ShowcaseItem(
      name: 'HolographicEffect',
      category: ShowcaseCategory.card,
      widgetBuilder: (theme) => HolographicCard(
        theme: theme as HolographicEffectTheme,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Text('Holographic Effect'),
        ),
      ),
      defaultCode: """
HolographicEffect(
  child: Text('Hover Me'),
)
""",
      initialTheme: const HolographicEffectTheme(),
    ),
  ];
}
