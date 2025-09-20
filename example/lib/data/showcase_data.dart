import 'package:example/models/showcase_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hover_effects/hover_effects.dart';

/// A centralized data provider for all showcase items.
/// This keeps the UI layer clean and separates data from presentation.
class ShowcaseData {
  // A helper function to create a simple placeholder widget for cards.
  static Widget _buildPlaceholder(
      {required Color color, required String text}) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  // A helper function for buttons that don't need to do anything in the showcase.
  static void _doNothing() {}

  /// Returns the complete list of all showcase items.
  static final List<ShowcaseItem> items = [
    ShowcaseItem(
      name: 'HolographicEffect',
      category: ShowcaseCategory.card,
      widgetBuilder: () => const HolographicCard(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Text('Holographic Effect'),
        ),
      ),
      defaultCode: """
HolographicEffect(
  child: Text('Hover Me'),
)
""",
    ),
    ShowcaseItem(
      name: 'FlipCard',
      category: ShowcaseCategory.card,
      widgetBuilder: () => FlipCard(
        front: _buildPlaceholder(color: Colors.indigo, text: 'Front'),
        back: _buildPlaceholder(color: Colors.blue, text: 'Back'),
        width: 250,
        height: 150,
      ),
      defaultCode: """
FlipCard(
  front: MyFrontWidget(),
  back: MyBackWidget(),
)
""",
    ),
    ShowcaseItem(
      name: 'Button3D',
      category: ShowcaseCategory.button,
      widgetBuilder: () => const Button3D(
        width: 200,
        height: 50,
        onPressed: _doNothing,
        child: Text('Click Me'),
      ),
      defaultCode: """
const Button3D(
  onPressed: _myFunction,
  child: Text('Click Me'),
)
""",
    ),
    ShowcaseItem(
      name: 'LiquidMorph',
      category: ShowcaseCategory.effect,
      widgetBuilder: () => const LiquidMorph(
        width: 200,
        height: 80,
        child: Text('Hover Me'),
      ),
      defaultCode: """
const LiquidMorph(
  onPressed: _myFunction,
  child: Text('Hover Me'),
)
""",
    ),
    ShowcaseItem(
      name: 'PaperCard',
      category: ShowcaseCategory.card,
      widgetBuilder: () => const PaperCard(
        child: Center(child: Text('Paper Card')),
      ),
      defaultCode: """
const PaperCard(
  child: MyContentWidget(),
)
""",
    ),
  ];
}
