import 'package:flutter/material.dart';
import 'models/card_hover_theme.dart';

/// A card that reveals more information and an image overlay on hover.
/// This matches the card__img--hover effect from the HTML/CSS version.
class CardHover extends StatefulWidget {
  final ImageProvider image;
  final String category;
  final String title;
  final String author;
  final String? timeText; // e.g., "15 min"
  final VoidCallback? onAuthorTap;
  final VoidCallback? onLikeTap;
  final CardHoverTheme theme;

  const CardHover({
    Key? key,
    required this.image,
    required this.category,
    required this.title,
    required this.author,
    this.timeText,
    this.onAuthorTap,
    this.onLikeTap,
    this.theme = const CardHoverTheme(),
  }) : super(key: key);

  @override
  State<CardHover> createState() => _CardHoverState();
}

class _CardHoverState extends State<CardHover> {
  bool _isHovering = false;

  void _onHover(bool isHovering) {
    setState(() {
      _isHovering = isHovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
        width: theme.width,
        height: theme.height,
        transform: Matrix4.identity()
          ..scaleByDouble(
              _isHovering ? 1.1 : 1.0, _isHovering ? 1.1 : 1.0, 1.0, 1.0),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          color: theme.infoBackgroundColor,
          borderRadius: theme.borderRadius,
          boxShadow: [_isHovering ? theme.hoverShadow : theme.shadow],
        ),
        child: ClipRRect(
          borderRadius: theme.borderRadius,
          child: Stack(
            children: [
              // Main Image (always visible, top part only)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: theme.imageHeight,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: widget.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              // Hover Image Overlay (covers entire card on hover)
              Positioned.fill(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: widget.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: _isHovering ? theme.overlayOpacity : 0.0,
                    child: Container(color: theme.overlayColor),
                  ),
                ),
              ),

              // Hover Info (like and time) - appears on hover
              if (_isHovering)
                Positioned(
                  top: 16,
                  left: 16,
                  right: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Like button
                      GestureDetector(
                        onTap: widget.onLikeTap,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      // Time info
                      if (widget.timeText != null)
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.access_time,
                                color: const Color(0xFFAD7D52),
                                size: 15,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                widget.timeText!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFFAD7D52),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),

              // Info Content
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                bottom: 0,
                left: 0,
                right: 0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  color: _isHovering
                      ? Colors.transparent
                      : theme.infoBackgroundColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.category.toUpperCase(),
                        style: theme.categoryTextStyle.copyWith(
                          color: _isHovering
                              ? Colors.white70
                              : theme.categoryColor,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.title,
                        style: theme.titleTextStyle.copyWith(
                          color: _isHovering ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text.rich(
                        TextSpan(
                          text: 'by ',
                          style: theme.authorByTextStyle.copyWith(
                            color: _isHovering ? Colors.white70 : Colors.black,
                          ),
                          children: [
                            WidgetSpan(
                              child: InkWell(
                                onTap: widget.onAuthorTap,
                                child: Text(widget.author,
                                    style: theme.authorTextStyle),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
