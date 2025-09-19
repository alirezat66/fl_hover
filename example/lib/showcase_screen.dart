import 'package:example/data/showcase_data.dart';
import 'package:example/widgets/glow_card.dart';
import 'package:example/widgets/holographic_button.dart';
import 'package:example/widgets/holographic_card.dart';
import 'package:example/widgets/showcase_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hover_effects/hover_effects.dart';

/// The main screen that displays a grid of all showcased widgets.
class ShowcaseScreen extends StatelessWidget {
  const ShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1E),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Hover Effects Showcase',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: HolographicEffect(
                child: Text(
                  'HOLOGRAM',
                  style: TextStyle(
                    color: Color(0xFF00FFFF), // Cyan color like CSS
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: HolographicEffect(
                      theme: HolographicEffectTheme(
                        glowColor: Color(0x99FF00FF),
                        shineColor: Color(0x66FF00FF),
                        shineDuration: Duration(seconds: 2),
                      ),
                      child: Center(
                        child: Text(
                          'HOLOGRAM',
                          style: TextStyle(
                            color: Color(0xFF00FFFF), // Cyan color like CSS
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 24),
                  Expanded(
                    child: HolographicEffect(
                      child: Text(
                        'HOLOGRAM',
                        style: TextStyle(
                          color: Color(0xFF00FFFF), // Cyan color like CSS
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GlowCard(
                      borderColor: Colors.white,
                      child: Text(
                        'HOLOGRAM',
                        style: TextStyle(
                          color: Color(0xFF00FFFF), // Cyan color like CSS
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 24),
                  Expanded(
                    child: GlowCard(
                      child: Text(
                        'HOLOGRAM',
                        style: TextStyle(
                          color: Color(0xFF00FFFF), // Cyan color like CSS
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ) /* LayoutBuilder(
        builder: (context, constraints) {
          // Determine the number of columns based on screen width
          final crossAxisCount =
              (constraints.maxWidth / 350).floor().clamp(1, 5);

          return GridView.builder(
            padding: const EdgeInsets.all(24.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 24.0,
              mainAxisSpacing: 24.0,
              childAspectRatio: 1.0,
            ),
            itemCount: allShowcases.length,
            itemBuilder: (context, index) {
              final item = allShowcases[index];
              return ShowcaseCard(item: item);
            },
          );
        },
      ) */
      ,
    );
  }
}
