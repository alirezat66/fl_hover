import 'package:example/showcase_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const HoverEffectsShowcaseApp());
}

class HoverEffectsShowcaseApp extends StatelessWidget {
  const HoverEffectsShowcaseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hover Effects Showcase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1C1C1E),
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
      ),
      home: const ShowcaseScreen(),
    );
  }
}
