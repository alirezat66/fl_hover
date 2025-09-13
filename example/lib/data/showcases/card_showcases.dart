import 'package:flutter/material.dart';
import 'package:flutter_hover_effects/hover_effects.dart';
import '../../models/showcase_item.dart';

/// A list of card widgets, correctly wrapped in ShowcaseItem objects
/// according to the correct data model.
final List<ShowcaseItem> cardShowcases = [
  // Showcase for the new, responsive HolographicCard.
  ShowcaseItem(
    title: 'Holographic Card',
    builder: (context) => HolographicCard(
      child: SizedBox(
        width: 350,
        height: 220,
        child: Center(
          child: Text(
            'Holographic Card',
            style: TextStyle(
              color: Colors.cyan.withOpacity(0.8),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  ),

  // Showcase for the new, responsive and animated CardSlide.
  ShowcaseItem(
    title: 'Card Slide',
    builder: (context) => CardSlide(
      topSlideChild: Container(
        width: 320,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF2a9d8f),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.diamond_outlined, color: Colors.white, size: 60),
            SizedBox(height: 16),
            Text(
              'Premium Plan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      bottomSlideChild: Container(
        width: 320,
        padding: const EdgeInsets.all(24),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Features',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF264653),
              ),
            ),
            SizedBox(height: 12),
            Text('✓ Unlimited Projects'),
            SizedBox(height: 4),
            Text('✓ 24/7 Support'),
            SizedBox(height: 4),
            Text('✓ Advanced Analytics'),
            SizedBox(height: 4),
            Text('✓ 100GB Storage'),
          ],
        ),
      ),
    ),
  ),

  // Other cards wrapped correctly.
  ShowcaseItem(
    title: 'Flip Card',
    builder: (context) => FlipCard(
      width: 320,
      height: 200,
      front: Container(
        color: Colors.blue,
        child: const Center(
            child: Text('Front', style: TextStyle(color: Colors.white))),
      ),
      back: Container(
        color: Colors.orange,
        child: const Center(
            child: Text('Back', style: TextStyle(color: Colors.white))),
      ),
    ),
  ),
  ShowcaseItem(
    title: 'Card Face',
    builder: (context) => CardFace(
      bottomFace: const Center(child: Text('Bottom Face Content')),
      topFace: const Center(
        child: Text('Top Face', style: TextStyle(color: Colors.white)),
      ),
      topFaceDecoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple, Colors.blue.shade800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    ),
  ),
  ShowcaseItem(
    title: 'Card Skew',
    builder: (context) => CardSkew(
      child: const Center(
        child: Text(
          'Skew Card',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    ),
  ),
  ShowcaseItem(
    title: 'Card Hover',
    builder: (context) => const CardHover(
      image: NetworkImage(
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500'),
      category: 'Technology',
      title: 'A New Era of Design',
      author: 'John Doe',
    ),
  ),
  ShowcaseItem(
    title: 'Paper Card',
    builder: (context) => PaperCard(
      child: SizedBox(
        width: 250,
        height: 150,
        child: Center(
          child: Text(
            'Paper Card',
            style: TextStyle(
              fontSize: 24,
              color: Colors.grey[800],
            ),
          ),
        ),
      ),
    ),
  ),
];
