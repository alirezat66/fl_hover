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
    ShowcaseItem(
      name: 'FlipCard',
      category: ShowcaseCategory.card,
      widgetBuilder: (theme) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: FlipCard(
          theme: theme as FlipCardTheme,
          front: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.credit_card, size: 48, color: Colors.white),
                SizedBox(height: 16),
                Text(
                  'Front Side',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Hover to flip',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          back: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.info_outline, size: 48, color: Colors.white),
                SizedBox(height: 16),
                Text(
                  'Back Side',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Flip card effect',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      defaultCode: """
FlipCard(
  front: Container(child: Text('Front')),
  back: Container(child: Text('Back')),
)
""",
      initialTheme: const FlipCardTheme(),
    ),
    ShowcaseItem(
      name: 'CardFace',
      category: ShowcaseCategory.card,
      widgetBuilder: (theme) => CardFace(
        theme: theme as CardFaceTheme,
        bottomFace: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.description, size: 40, color: Colors.black87),
              SizedBox(height: 12),
              Text(
                'Details go here',
                style: TextStyle(color: Colors.black87),
              ),
            ],
          ),
        ),
        topFace: const Text(
          'Summary',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        topFaceDecoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      defaultCode: """
CardFace(
  theme: const CardFaceTheme(),
  bottomFace: Center(child: Text('Details')),
  topFace: Text('Summary', style: TextStyle(color: Colors.white)),
  topFaceDecoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
    ),
  ),
)
""",
      initialTheme: const CardFaceTheme(),
    ),
    ShowcaseItem(
      name: 'CardSlide',
      category: ShowcaseCategory.card,
      widgetBuilder: (theme) => CardSlide(
        theme: theme as CardSlideTheme,
        topSlideChild: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.swipe, size: 48, color: Colors.blue),
              SizedBox(height: 16),
              Text(
                'Top Panel',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Hover to slide',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        bottomSlideChild: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.flip, size: 48, color: Colors.green),
              SizedBox(height: 16),
              Text(
                'Bottom Panel',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Slide & flip effect',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
      defaultCode: """
CardSlide(
  theme: const CardSlideTheme(),
  topSlideChild: Center(child: Text('Top Panel')),
  bottomSlideChild: Center(child: Text('Bottom Panel')),
)
""",
      initialTheme: const CardSlideTheme(),
    ),
  ];
}
