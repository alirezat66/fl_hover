import 'package:flutter/material.dart';

class HolographicButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final double width;
  final double height;

  const HolographicButton({
    super.key,
    this.text = 'HOLOGRAM',
    this.onPressed,
    this.width = 300,
    this.height = 200,
  });

  @override
  State<HolographicButton> createState() => _HolographicButtonState();
}

class _HolographicButtonState extends State<HolographicButton>
    with TickerProviderStateMixin {
  late AnimationController _hoverController;
  late AnimationController _scaleController;
  late Animation<double> _gradientAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    // Animation controller for the gradient movement
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Animation controller for scale effect
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Gradient position animation (moves from top to bottom like CSS translateY(100%))
    _gradientAnimation = Tween<double>(
      begin: 0.0, // Start at initial position
      end: -1.0, // Move full height down (translateY(100%))
    ).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );

    // Scale animation (1.0 to 1.05)
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    // Opacity animation for the gradient overlay
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });

    if (isHovered) {
      _hoverController.forward();
      _scaleController.forward();
    } else {
      _hoverController.reverse();
      _scaleController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedBuilder(
          animation: Listenable.merge([_hoverController, _scaleController]),
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  color: const Color(0xFF111111),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow:
                      _isHovered
                          ? [
                            BoxShadow(
                              color: const Color(0xFF00FFFF).withOpacity(0.5),
                              blurRadius: 20,
                              spreadRadius: 0,
                            ),
                          ]
                          : [],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    children: [
                      // Main button content
                      Center(
                        child: Text(
                          widget.text,
                          style: const TextStyle(
                            color: Color(0xFF00FFFF),
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Animated gradient overlay - exactly like CSS ::before
                      Positioned(
                        top: -widget.height * 0.5, // -50% like CSS
                        left: -widget.width * 0.5, // -50% like CSS
                        child: AnimatedBuilder(
                          animation: _gradientAnimation,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: -0.785398, // -45 degrees in radians
                              child: Transform.translate(
                                offset: Offset(
                                  0,
                                  _gradientAnimation.value * widget.height * 2,
                                ), // translateY(100%) of 200% height
                                child: Opacity(
                                  opacity: _opacityAnimation.value,
                                  child: Container(
                                    width:
                                        widget.width * 2, // 200% width like CSS
                                    height:
                                        widget.height *
                                        2, // 200% height like CSS
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.transparent,
                                          Color(
                                            0x4D00FFFF,
                                          ), // rgba(0, 255, 255, 0.3)
                                        ],
                                        stops: [
                                          0.0,
                                          0.3,
                                          1.0,
                                        ], // Exact CSS stops
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
