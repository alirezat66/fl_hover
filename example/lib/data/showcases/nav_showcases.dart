import 'package:example/models/showcase_item.dart';
import 'package:flutter/material.dart';
import 'package:hover_effects/hover_effects.dart';

final List<ShowcaseItem> navShowcases = [
  ShowcaseItem(
    title: 'Animated Nav Menu',
    builder: (context) => AnimatedNavMenu(
      items: [
        AnimatedNavMenuItem(
            icon: Icons.home,
            title: 'Home',
            hoverGradient:
                const LinearGradient(colors: [Colors.blue, Colors.purple]),
            onTap: () {}),
        AnimatedNavMenuItem(
            icon: Icons.person,
            title: 'Profile',
            hoverGradient:
                const LinearGradient(colors: [Colors.green, Colors.cyan]),
            onTap: () {}),
        AnimatedNavMenuItem(
            icon: Icons.settings,
            title: 'Settings',
            hoverGradient:
                const LinearGradient(colors: [Colors.orange, Colors.red]),
            onTap: () {}),
      ],
      itemSize: 50,
      itemHoverWidth: 120,
      spacing: 15,
    ),
  ),
  ShowcaseItem(
    title: 'Sliding Nav Menu',
    builder: (context) => SlidingNavMenu(
      width: 250,
      items: [
        SlidingNavMenuItem(
            title: 'Dashboard', onTap: () {}, highlightColor: Colors.blue),
        SlidingNavMenuItem(
            title: 'Analytics', onTap: () {}, highlightColor: Colors.green),
        SlidingNavMenuItem(
            title: 'Reports', onTap: () {}, highlightColor: Colors.orange),
      ],
    ),
  ),
  ShowcaseItem(
    title: 'Animated Underline Nav',
    builder: (context) => AnimatedUnderlineNav(
      items: [
        AnimatedUnderlineNavItem(title: 'About', onTap: () {}),
        AnimatedUnderlineNavItem(title: 'Portfolio', onTap: () {}),
        AnimatedUnderlineNavItem(title: 'Contact', onTap: () {}),
      ],
    ),
  ),
  ShowcaseItem(
    title: 'Hover Underline',
    builder: (context) => const HoverUnderline(
      text: 'Hover Me',
    ),
  ),
];
