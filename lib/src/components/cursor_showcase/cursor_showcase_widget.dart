import 'package:flutter/material.dart';
import '../../models/cursor_behavior.dart';
import 'models/cursor_showcase_theme.dart';

/// A widget that showcases all available cursor behaviors.
class CursorShowcase extends StatelessWidget {
  /// The theme for styling
  final CursorShowcaseTheme? theme;

  const CursorShowcase({
    super.key,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final finalTheme = theme ??
        Theme.of(context).extension<CursorShowcaseTheme>() ??
        const CursorShowcaseTheme();

    return Container(
      padding: finalTheme.containerPadding,
      decoration: BoxDecoration(
        color: finalTheme.backgroundColor,
        borderRadius: BorderRadius.circular(finalTheme.borderRadius),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Cursor Behaviors',
              style: finalTheme.titleStyle,
            ),
            const SizedBox(height: 16),
            Text(
              'Hover over each item to see the cursor change',
              style: finalTheme.subtitleStyle,
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: finalTheme.itemSpacing,
              runSpacing: finalTheme.itemSpacing,
              children: CursorBehavior.values.map((cursor) {
                return _CursorShowcaseItem(
                  cursorBehavior: cursor,
                  theme: finalTheme,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _CursorShowcaseItem extends StatefulWidget {
  final CursorBehavior cursorBehavior;
  final CursorShowcaseTheme theme;

  const _CursorShowcaseItem({
    required this.cursorBehavior,
    required this.theme,
  });

  @override
  State<_CursorShowcaseItem> createState() => _CursorShowcaseItemState();
}

class _CursorShowcaseItemState extends State<_CursorShowcaseItem> {
  bool _isHovered = false;

  IconData _getIconForCursor(CursorBehavior cursor) {
    switch (cursor) {
      case CursorBehavior.auto:
        return Icons.arrow_upward;
      case CursorBehavior.pointer:
        return Icons.touch_app;
      case CursorBehavior.help:
        return Icons.help_outline;
      case CursorBehavior.wait:
        return Icons.hourglass_empty;
      case CursorBehavior.progress:
        return Icons.sync;
      case CursorBehavior.text:
        return Icons.text_fields;
      case CursorBehavior.move:
        return Icons.open_with;
      case CursorBehavior.notAllowed:
        return Icons.block;
      case CursorBehavior.grab:
        return Icons.pan_tool_outlined;
      case CursorBehavior.grabbing:
        return Icons.pan_tool;
      case CursorBehavior.zoomIn:
        return Icons.zoom_in;
      case CursorBehavior.zoomOut:
        return Icons.zoom_out;
      case CursorBehavior.none:
        return Icons.visibility_off;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.cursorBehavior.mouseCursor,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: widget.theme.itemPadding,
        decoration: BoxDecoration(
          color: _isHovered
              ? widget.theme.itemHoverColor
              : widget.theme.itemBackgroundColor,
          borderRadius: BorderRadius.circular(widget.theme.itemBorderRadius),
          border: Border.all(
            color: _isHovered
                ? widget.theme.itemHoverBorderColor
                : widget.theme.itemBorderColor,
            width: widget.theme.itemBorderWidth,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: widget.theme.itemShadowColor,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getIconForCursor(widget.cursorBehavior),
              size: widget.theme.iconSize,
              color: _isHovered
                  ? widget.theme.iconHoverColor
                  : widget.theme.iconColor,
            ),
            const SizedBox(height: 8),
            Text(
              widget.cursorBehavior.displayName,
              style: widget.theme.itemTextStyle.copyWith(
                color: _isHovered
                    ? widget.theme.textHoverColor
                    : widget.theme.textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
