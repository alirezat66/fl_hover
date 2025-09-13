import 'package:example/models/showcase_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A reusable card widget to display a single showcase item.
class ShowcaseCard extends StatelessWidget {
  final ShowcaseItem item;

  const ShowcaseCard({Key? key, required this.item}) : super(key: key);

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: item.title)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF3AE885),
          content: Text(
            "'${item.title}' copied to clipboard!",
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF2C2C2E),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFF444446), width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy_rounded,
                      size: 20, color: Colors.white70),
                  tooltip: 'Copy widget name',
                  onPressed: () => _copyToClipboard(context),
                ),
              ],
            ),
          ),
          const Divider(color: Color(0xFF444446), height: 1),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                fit: BoxFit.contain,
                child: item.builder(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
