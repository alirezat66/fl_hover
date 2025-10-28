import 'package:example/data/showcase_data.dart';
import 'package:example/models/showcase_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShowcasePage extends StatefulWidget {
  const ShowcasePage({super.key});

  @override
  State<ShowcasePage> createState() => _ShowcasePageState();
}

class _ShowcasePageState extends State<ShowcasePage> {
  ShowcaseItem? _selectedItem;
  final List<ShowcaseItem> _allItems = ShowcaseData.items;
  final Map<ShowcaseCategory, List<ShowcaseItem>> _categorizedItems = {};

  @override
  void initState() {
    super.initState();
    _categorizeItems();
    // Select first item by default
    if (_allItems.isNotEmpty) {
      _selectedItem = _allItems.first;
    }
  }

  void _categorizeItems() {
    for (final item in _allItems) {
      _categorizedItems.putIfAbsent(item.category, () => []).add(item);
    }
  }

  void _selectItem(ShowcaseItem item) {
    setState(() {
      _selectedItem = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    if (isMobile) {
      return _buildMobileLayout();
    } else {
      return _buildDesktopLayout();
    }
  }

  Widget _buildDesktopLayout() {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 320,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(2, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Color(0xFF6366F1),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'FL Hover Showcase',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Interactive Showcase',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                // Categories List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemCount: ShowcaseCategory.values.length,
                    itemBuilder: (context, categoryIndex) {
                      final category = ShowcaseCategory.values[categoryIndex];
                      final items = _categorizedItems[category] ?? [];

                      if (items.isEmpty) return const SizedBox.shrink();

                      return _CategorySection(
                        category: category,
                        items: items,
                        selectedItem: _selectedItem,
                        onItemSelected: _selectItem,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: _selectedItem != null
                ? _MainContentArea(selectedItem: _selectedItem!)
                : const Center(
                    child: Text(
                      'Select a widget to preview',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Fl Hover Effects'),
        backgroundColor: const Color(0xFF6366F1),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _selectedItem != null
          ? _MainContentArea(selectedItem: _selectedItem!, isMobile: true)
          : _buildMobileWidgetList(),
    );
  }

  Widget _buildMobileWidgetList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: ShowcaseCategory.values.length,
      itemBuilder: (context, categoryIndex) {
        final category = ShowcaseCategory.values[categoryIndex];
        final items = _categorizedItems[category] ?? [];

        if (items.isEmpty) return const SizedBox.shrink();

        return _CategorySection(
          category: category,
          items: items,
          selectedItem: _selectedItem,
          onItemSelected: _selectItem,
        );
      },
    );
  }
}

class _CategorySection extends StatelessWidget {
  final ShowcaseCategory category;
  final List<ShowcaseItem> items;
  final ShowcaseItem? selectedItem;
  final Function(ShowcaseItem) onItemSelected;

  const _CategorySection({
    required this.category,
    required this.items,
    required this.selectedItem,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              '${category.name} Effects',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6B7280),
                letterSpacing: 0.5,
              ),
            ),
          ),
          // Items List
          ...items.map((item) => _WidgetListItem(
                item: item,
                isSelected: selectedItem?.name == item.name,
                onTap: () => onItemSelected(item),
              )),
        ],
      ),
    );
  }
}

class _WidgetListItem extends StatelessWidget {
  final ShowcaseItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _WidgetListItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color:
            isSelected ? const Color(0xFF6366F1).withValues(alpha: 0.1) : null,
        borderRadius: BorderRadius.circular(8),
        border: isSelected
            ? Border.all(color: const Color(0xFF6366F1).withValues(alpha: 0.3))
            : null,
      ),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color:
                isSelected ? const Color(0xFF6366F1) : const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              item.name[0],
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF6B7280),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        title: Text(
          item.name,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color:
                isSelected ? const Color(0xFF6366F1) : const Color(0xFF374151),
          ),
        ),
        subtitle: Text(
          '${item.category.name} Widget',
          style: TextStyle(
            fontSize: 12,
            color: isSelected
                ? const Color(0xFF6366F1).withValues(alpha: 0.7)
                : const Color(0xFF9CA3AF),
          ),
        ),
        onTap: onTap,
        trailing: isSelected
            ? const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Color(0xFF6366F1),
              )
            : null,
      ),
    );
  }
}

class _MainContentArea extends StatelessWidget {
  final ShowcaseItem selectedItem;
  final bool isMobile;

  const _MainContentArea({required this.selectedItem, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          if (isMobile) ...[
            // Mobile back button
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    // Go back to widget list
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: const Color(0xFF6366F1),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedItem.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      Text(
                        '${selectedItem.category.name} Effect Widget',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ] else ...[
            // Desktop header
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedItem.name,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${selectedItem.category.name} Effect Widget',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
                // Action Buttons
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        context.push('/details/${selectedItem.name}');
                      },
                      icon: const Icon(Icons.tune),
                      label: const Text('Customize'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6366F1),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: () {
                        // TODO: Copy code functionality
                      },
                      icon: const Icon(Icons.copy),
                      label: const Text('Copy Code'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF6366F1),
                        side: const BorderSide(color: Color(0xFF6366F1)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
          const SizedBox(height: 32),
          // Preview Area
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  color: const Color(0xFFF8F9FA),
                  child: Center(
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: isMobile ? double.infinity : 600,
                        maxHeight: isMobile ? 300 : 400,
                      ),
                      child:
                          selectedItem.widgetBuilder(selectedItem.initialTheme),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Mobile action buttons
          if (isMobile) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      context.push('/details/${selectedItem.name}');
                    },
                    icon: const Icon(Icons.tune),
                    label: const Text('Customize'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Copy code functionality
                    },
                    icon: const Icon(Icons.copy),
                    label: const Text('Copy Code'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF6366F1),
                      side: const BorderSide(color: Color(0xFF6366F1)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
