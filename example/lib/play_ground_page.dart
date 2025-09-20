import 'package:example/data/showcase_data.dart';
import 'package:example/models/showcase_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlaygroundPage extends StatefulWidget {
  final String widgetName;

  const PlaygroundPage({super.key, required this.widgetName});

  @override
  State<PlaygroundPage> createState() => _PlaygroundPageState();
}

class _PlaygroundPageState extends State<PlaygroundPage> {
  late final ShowcaseItem _showcaseItem;

  // This will hold the mutable theme state in the future.
  // late dynamic _currentTheme;

  @override
  void initState() {
    super.initState();
    try {
      _showcaseItem = ShowcaseData.items
          .firstWhere((item) => item.name == widget.widgetName);
      // TODO: Initialize _currentTheme with the default theme of the widget.
    } catch (e) {
      // Handle case where the widget name is not found.
      // For now, we'll just use a placeholder.
      _showcaseItem = ShowcaseItem(
        name: 'Not Found',
        category: ShowcaseCategory.effect,
        widgetBuilder: () => const Center(child: Text('Widget not found')),
        defaultCode: 'Error: Widget not found.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text('${_showcaseItem.name} Playground'),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left Panel: The control panel
          Expanded(
            flex: 1,
            child: Container(
              color: const Color(0xFF252526),
              child: const Center(
                child: Text(
                  'Controls will be here',
                  style: TextStyle(color: Colors.white54),
                ),
              ),
            ),
          ),
          // Right Panel: The showcase stage
          Expanded(
            flex: 2,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Center(
                child: _showcaseItem.widgetBuilder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
