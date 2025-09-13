import 'package:flutter/material.dart';
import 'package:flutter_hover_effects/hover_effects.dart';
import '../../models/showcase_item.dart';

/// A list of navigation menu widgets, showcasing the new and powerful
/// SlidingNavMenu with various themes and slide directions.
final List<ShowcaseItem> navShowcases = [
  // --- SlidingNavMenu Showcases ---

  // Default (Slide from Left) with per-item colors
  ShowcaseItem(
    title: 'Sliding Nav Menu (Per-Item Colors)',
    builder: (context) => SlidingNavMenu(
      items: _buildMultiColorNavItems(),
    ),
  ),

  // New Showcase: Transparent background with "peek" effect
  ShowcaseItem(
    title: 'Sliding Nav Menu (Peek & Transparent)',
    builder: (context) => Container(
      // A background to demonstrate the transparency of the menu
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple, Colors.teal],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: SlidingNavMenu(
          width: 350,
          items: _buildMultiColorNavItems(),
          theme: const SlidingNavMenuTheme(
            // menuDecoration is null, making the background transparent
            menuDecoration: null,
            // 10 pixels of the highlight color will always be visible
            peekSize: 10.0,
            itemTextStyle: TextStyle(color: Colors.white, fontSize: 18),
            itemHoverTextStyle: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
      ),
    ),
  ),

  // Slide from Right with a custom theme
  ShowcaseItem(
    title: 'Sliding Nav Menu (Right)',
    builder: (context) => SlidingNavMenu(
      items: _buildMultiColorNavItems(),
      theme: const SlidingNavMenuTheme(
        slideDirection: AxisDirection.right,
        itemTextStyle: TextStyle(
          color: Colors.black54,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),

  // Slide from Bottom with a dark theme and peek effect
  ShowcaseItem(
    title: 'Sliding Nav Menu (Down + Peek)',
    builder: (context) => SlidingNavMenu(
      items: _buildMultiColorNavItems(),
      theme: const SlidingNavMenuTheme(
        slideDirection: AxisDirection.down,
        peekSize: 5.0,
        menuDecoration: BoxDecoration(color: Color(0xFF212121)),
        itemTextStyle: TextStyle(color: Colors.white70, fontSize: 16),
        itemHoverTextStyle: TextStyle(color: Color(0xFF212121), fontSize: 16),
      ),
    ),
  ),

  // --- Other Pre-existing Nav Menus ---

  ShowcaseItem(
    title: 'Animated Nav Menu',
    builder: (context) => AnimatedNavMenu(
      items: [
        AnimatedNavMenuItem(
            icon: Icons.home,
            title: 'Home',
            onTap: () {},
            hoverGradient: const LinearGradient(
                colors: [Color(0xFFFE6B8B), Color(0xFFFF8E53)])),
        AnimatedNavMenuItem(
            icon: Icons.person,
            title: 'Profile',
            onTap: () {},
            hoverGradient: const LinearGradient(
                colors: [Color(0xFF2196F3), Color(0xFF21CBF3)])),
        AnimatedNavMenuItem(
            icon: Icons.settings,
            title: 'Settings',
            onTap: () {},
            hoverGradient: const LinearGradient(
                colors: [Color(0xFF4CAF50), Color(0xFF8BC34A)])),
      ],
    ),
  ),
  ShowcaseItem(
      title: 'Animated Underline Nav',
      builder: (context) => AnimatedUnderlineNav(
            items: [
              AnimatedUnderlineNavItem(title: 'Home', onTap: () {}),
              AnimatedUnderlineNavItem(title: 'About', onTap: () {}),
              AnimatedUnderlineNavItem(title: 'Contact', onTap: () {}),
            ],
          ))
];

// This function now creates items with unique highlight colors to demonstrate
// the restored per-item customization capability.
List<SlidingNavMenuItem> _buildMultiColorNavItems() {
  return [
    SlidingNavMenuItem(
        title: 'Dashboard', onTap: () {}, highlightColor: Colors.blue),
    SlidingNavMenuItem(
        title: 'Analytics', onTap: () {}, highlightColor: Colors.green),
    SlidingNavMenuItem(
        title: 'Reports', onTap: () {}, highlightColor: Colors.redAccent),
    SlidingNavMenuItem(
        title: 'Settings', onTap: () {}, highlightColor: Colors.purple),
  ];
}
