import 'package:example/data/showcase_data.dart';
import 'package:example/models/showcase_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ShowcasePage extends StatelessWidget {
  const ShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = ShowcaseData.items;
    const categories = ShowcaseCategory.values;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Hover Effects Showcase'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final categoryItems =
              items.where((item) => item.category == category).toList();

          if (categoryItems.isEmpty) {
            return const SizedBox.shrink();
          }

          return _CategorySection(
            category: category,
            items: categoryItems,
          );
        },
      ),
    );
  }
}

/// A widget to display a category title and a grid of items for that category.
class _CategorySection extends StatelessWidget {
  final ShowcaseCategory category;
  final List<ShowcaseItem> items;

  const _CategorySection({required this.category, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${category.name} Effects',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 24),
          // Replaced Wrap with a responsive GridView.builder
          GridView.builder(
            shrinkWrap: true, // Necessary inside a ListView
            physics:
                const NeverScrollableScrollPhysics(), // Parent handles scrolling
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 320.0, // Max width of each item
              childAspectRatio:
                  0.75, // Enforces the portrait aspect ratio (width / height)
              crossAxisSpacing: 24.0,
              mainAxisSpacing: 24.0,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return _ShowcaseCard(item: items[index]);
            },
          ),
        ],
      ),
    );
  }
}

/// The card widget for each item in the showcase grid.
class _ShowcaseCard extends StatelessWidget {
  final ShowcaseItem item;

  const _ShowcaseCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // The SizedBox with fixed dimensions is no longer needed, as the GridView's delegate
    // now controls the size and aspect ratio of its children.
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Showcase Area
          Expanded(
            child: Container(
              color: Colors.black.withOpacity(0.2),
              alignment: Alignment.center,
              child: item.widgetBuilder(),
            ),
          ),
          // 2. Title and Actions
          Container(
            padding: const EdgeInsets.all(12.0),
            color: theme.cardColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    item.name,
                    style: theme.textTheme.titleLarge?.copyWith(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        // Navigate to the playground page using go_router
                        context.push('/details/${item.name}');
                      },
                      child: const Text('See More'),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.copy_all_outlined),
                      tooltip: 'Copy Default Code',
                      onPressed: () {
                        Clipboard.setData(
                            ClipboardData(text: item.defaultCode));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Default code copied to clipboard!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
