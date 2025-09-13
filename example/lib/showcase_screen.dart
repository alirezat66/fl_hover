import 'package:example/data/showcase_data.dart';
import 'package:example/widgets/showcase_card.dart';
import 'package:flutter/material.dart';

/// The main screen that displays a grid of all showcased widgets.
class ShowcaseScreen extends StatelessWidget {
  const ShowcaseScreen({Key? key}) : super(key: key);

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
      body: LayoutBuilder(
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
      ),
    );
  }
}
