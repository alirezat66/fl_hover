import 'package:example/models/showcase_item.dart';
import 'package:flutter/material.dart';
import 'package:hover_effects/hover_effects.dart';

final List<ShowcaseItem> miscShowcases = [
  ShowcaseItem(
    title: 'Liquid Morph',
    builder: (context) => LiquidMorph(
      width: 200,
      height: 80,
      child: const Text('MORPH'),
    ),
  ),
  ShowcaseItem(
    title: 'Rotating Cube',
    builder: (context) => const RotatingCube(
      theme: RotatingCubeTheme(faceSize: 120),
      frontFace: Center(child: Text('Front')),
      backFace: Center(child: Text('Back')),
      topFace: Center(child: Text('Top')),
      bottomFace: Center(child: Text('Bottom')),
      leftFace: Center(child: Text('Left')),
      rightFace: Center(child: Text('Right')),
    ),
  ),
  ShowcaseItem(
    title: 'Animated Icon',
    builder: (context) => const AnimatedIconWidget(
      icon: Icons.favorite,
      theme: AnimatedIconTheme(size: 80, iconSize: 40),
    ),
  ),
  ShowcaseItem(
    title: 'Cursor Showcase Box',
    builder: (context) => const CursorShowcaseBox(
      size: 100,
      cursor: SystemMouseCursors.grab,
      child: Text(
        'grab',
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
    ),
  ),
  ShowcaseItem(
    title: 'Scotch Showcase',
    builder: (context) => ScotchShowcase(
      onBuyNow: () {},
      onLearnMore: () {},
    ),
  ),
];
