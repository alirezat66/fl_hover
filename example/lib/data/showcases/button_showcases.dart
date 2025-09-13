import 'package:flutter/material.dart';
import 'package:hover_effects/hover_effects.dart';
import '../../models/showcase_item.dart';

/// A list of button widgets, showcasing the powerful and customizable
/// new versions of the components.
final List<ShowcaseItem> buttonShowcases = [
  // --- AnimatedArrowButton Showcases ---

  // Default AnimatedArrowButton
  ShowcaseItem(
    title: 'Animated Arrow Button',
    builder: (context) => AnimatedArrowButton(
      onPressed: () {},
      child: const Text('SUBMIT'),
    ),
  ),

  // Customized AnimatedArrowButton
  ShowcaseItem(
    title: 'Arrow Button (Custom)',
    builder: (context) => AnimatedArrowButton(
      onPressed: () {},
      theme: AnimatedArrowButtonTheme(
        decoration: BoxDecoration(
          color: const Color(0xFFE91E63),
          borderRadius: BorderRadius.circular(12),
        ),
        hoverDecoration: BoxDecoration(
          color: const Color(0xFFC2185B),
          borderRadius: BorderRadius.circular(20),
        ),
        skew: -10,
        arrowTheme: const ArrowTheme(
          color: Colors.white,
          hoverColors: [
            Color(0xFFFFC1E3),
            Color(0xFFFF8FA3),
            Color(0xFFFF5C75),
          ],
        ),
        shadowColor: Colors.pink.shade900,
      ),
      child: const Text(
        'LAUNCH',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
    ),
  ),

  // --- AnimatedPlayButton Showcases ---

  // Default AnimatedPlayButton
  ShowcaseItem(
    title: 'Animated Play Button',
    builder: (context) => AnimatedPlayButton(onPressed: () {}),
  ),

  // A customized dark-themed example of AnimatedPlayButton
  ShowcaseItem(
    title: 'Play Button (Dark)',
    builder: (context) => AnimatedPlayButton(
      onPressed: () {},
      theme: const AnimatedPlayButtonTheme(
        size: 80,
        decoration: BoxDecoration(
          color: Color(0xFF212121),
          shape: BoxShape.circle,
        ),
        hoverDecoration: BoxDecoration(
          color: Color(0xFF424242),
          shape: BoxShape.circle,
        ),
        barColor: Colors.white,
        circleColor: Colors.grey,
        hoverBarColor: Colors.cyan,
        hoverCircleColor: Colors.tealAccent,
        shadow: BoxShadow(
          color: Colors.black54,
          blurRadius: 15,
          offset: Offset(0, 5),
        ),
      ),
    ),
  ),

  // A customized gradient, square-shaped example of AnimatedPlayButton
  ShowcaseItem(
    title: 'Play Button (Gradient)',
    builder: (context) => AnimatedPlayButton(
      onPressed: () {},
      theme: const AnimatedPlayButtonTheme(
        size: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        hoverDecoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purpleAccent, Colors.deepPurple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        barColor: Colors.white,
        circleColor: Colors.white70,
        hoverBarColor: Colors.yellow,
        hoverCircleColor: Colors.amber,
        hoverShadow: BoxShadow(
          color: Colors.purple,
          blurRadius: 30,
          spreadRadius: 5,
        ),
      ),
    ),
  ),

  // --- Other Pre-existing Buttons ---

  ShowcaseItem(
    title: '3D Button',
    builder: (context) => Button3D(
      onPressed: () {},
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Text('3D Button'),
      ),
    ),
  ),
  ShowcaseItem(
    title: 'Social Icon Button',
    builder: (context) => SocialIconButton(
      icon: Icons.facebook,
      onPressed: () {},
      theme: const SocialIconButtonTheme(
        hoverFillColor: Color(0xFF1877F2),
      ),
    ),
  ),
  ShowcaseItem(
    title: '3D Social Button',
    builder: (context) => Button3DSocial(
      onPressed: () {},
      theme: const Button3DSocialTheme(
        hoverBackgroundColor: Color(0xFF1DA1F2),
        hoverSideColor: Color(0xFF0C85D0),
        hoverBottomColor: Color(0xFF0A6AA8),
      ),
      child: const Icon(Icons.flutter_dash, color: Color(0xFF1DA1F2), size: 32),
    ),
  ),
];
