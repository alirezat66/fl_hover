import 'package:example/models/showcase_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hover_effects/hover_effects.dart';

/// A centralized data provider for all showcase items.
/// This keeps the UI layer clean and separates data from presentation.
class ShowcaseData {
  // A helper function to create a simple placeholder widget for cards.

  /// Returns the complete list of all showcase items.
  static final List<ShowcaseItem> items = [
    ShowcaseItem(
      name: 'HolographicEffect',
      category: ShowcaseCategory.card,
      widgetBuilder: (theme) => HolographicCard(
        theme: theme as HolographicEffectTheme,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Text('Holographic Effect'),
        ),
      ),
      defaultCode: """
HolographicEffect(
  child: Text('Hover Me'),
)
""",
      initialTheme: const HolographicEffectTheme(),
    ),
    ShowcaseItem(
      name: 'FlipCard',
      category: ShowcaseCategory.card,
      widgetBuilder: (theme) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: FlipCard(
          theme: theme as FlipCardTheme,
          front: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.credit_card, size: 48, color: Colors.white),
                SizedBox(height: 16),
                Text(
                  'Front Side',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Hover to flip',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          back: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.info_outline, size: 48, color: Colors.white),
                SizedBox(height: 16),
                Text(
                  'Back Side',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Flip card effect',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      defaultCode: """
FlipCard(
  front: Container(child: Text('Front')),
  back: Container(child: Text('Back')),
)
""",
      initialTheme: const FlipCardTheme(),
    ),
    ShowcaseItem(
      name: 'CardFace',
      category: ShowcaseCategory.card,
      widgetBuilder: (theme) => CardFace(
        theme: theme as CardFaceTheme,
        bottomFace: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.description, size: 40, color: Colors.black87),
              SizedBox(height: 12),
              Text(
                'Details go here',
                style: TextStyle(color: Colors.black87),
              ),
            ],
          ),
        ),
        topFace: const Text(
          'Summary',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        topFaceDecoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      defaultCode: """
CardFace(
  theme: const CardFaceTheme(),
  bottomFace: Center(child: Text('Details')),
  topFace: Text('Summary', style: TextStyle(color: Colors.white)),
  topFaceDecoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
    ),
  ),
)
""",
      initialTheme: const CardFaceTheme(),
    ),
    ShowcaseItem(
      name: 'CardSlide',
      category: ShowcaseCategory.card,
      widgetBuilder: (theme) => CardSlide(
        theme: theme as CardSlideTheme,
        icon: const Icon(
          Icons.person,
          size: 80,
          color: Colors.white,
        ),
        title: 'Hello there!',
        subtitle: 'Trust yourself and keep going.',
      ),
      defaultCode: """
CardSlide(
  theme: const CardSlideTheme(),
  icon: Icon(Icons.person, size: 80, color: Colors.white),
  title: 'Hello there!',
  subtitle: 'Trust yourself and keep going.',
)
""",
      initialTheme: const CardSlideTheme(),
    ),
    ShowcaseItem(
      name: 'CardHover',
      category: ShowcaseCategory.card,
      widgetBuilder: (theme) => CardHover(
        theme: theme as CardHoverTheme,
        image: const NetworkImage(
          'https://images.pexels.com/photos/45202/brownie-dessert-cake-sweet-45202.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260',
        ),
        category: 'Recipe',
        title: 'Crisp Spanish tortilla Matzo brei',
        author: 'Celeste Mills',
        timeText: '15 min',
        onAuthorTap: () {},
        onLikeTap: () {},
      ),
      defaultCode: """
CardHover(
  theme: const CardHoverTheme(),
  image: NetworkImage('https://example.com/image.jpg'),
  category: 'Recipe',
  title: 'Crisp Spanish tortilla Matzo brei',
  author: 'Celeste Mills',
  timeText: '15 min',
  onAuthorTap: () {},
  onLikeTap: () {},
)
""",
      initialTheme: const CardHoverTheme(),
    ),
    ShowcaseItem(
      name: 'AnimatedNavMenu',
      category: ShowcaseCategory.navigation,
      widgetBuilder: (theme) => AnimatedNavMenu(
        theme: theme as AnimatedNavMenuTheme,
        items: [
          AnimatedNavMenuItem(
            icon: Icons.home,
            title: 'Home',
            hoverGradient: const LinearGradient(
              colors: [Color(0xFF667eea), Color(0xFF764ba2)],
            ),
            onTap: () {},
          ),
          AnimatedNavMenuItem(
            icon: Icons.search,
            title: 'Search',
            hoverGradient: const LinearGradient(
              colors: [Color(0xFFf093fb), Color(0xFFf5576c)],
            ),
            onTap: () {},
          ),
          AnimatedNavMenuItem(
            icon: Icons.favorite,
            title: 'Favorites',
            hoverGradient: const LinearGradient(
              colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
            ),
            onTap: () {},
          ),
          AnimatedNavMenuItem(
            icon: Icons.person,
            title: 'Profile',
            hoverGradient: const LinearGradient(
              colors: [Color(0xFF43e97b), Color(0xFF38f9d7)],
            ),
            onTap: () {},
          ),
        ],
      ),
      defaultCode: """
AnimatedNavMenu(
  theme: const AnimatedNavMenuTheme(),
  items: [
    AnimatedNavMenuItem(
      icon: Icons.home,
      title: 'Home',
      hoverGradient: LinearGradient(
        colors: [Color(0xFF667eea), Color(0xFF764ba2)],
      ),
      onTap: () {},
    ),
    AnimatedNavMenuItem(
      icon: Icons.search,
      title: 'Search',
      hoverGradient: LinearGradient(
        colors: [Color(0xFFf093fb), Color(0xFFf5576c)],
      ),
      onTap: () {},
    ),
    AnimatedNavMenuItem(
      icon: Icons.favorite,
      title: 'Favorites',
      hoverGradient: LinearGradient(
        colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
      ),
      onTap: () {},
    ),
    AnimatedNavMenuItem(
      icon: Icons.person,
      title: 'Profile',
      hoverGradient: LinearGradient(
        colors: [Color(0xFF43e97b), Color(0xFF38f9d7)],
      ),
      onTap: () {},
    ),
  ],
)
""",
      initialTheme: const AnimatedNavMenuTheme(),
    ),
    ShowcaseItem(
      name: 'SlidingNavMenu',
      category: ShowcaseCategory.navigation,
      widgetBuilder: (theme) => SlidingNavMenu(
        theme: theme as SlidingNavMenuTheme,
        items: [
          SlidingNavMenuItem(
            title: 'Dashboard',
            highlightColor: const Color(0xFF6366F1),
            onTap: () {},
          ),
          SlidingNavMenuItem(
            title: 'Analytics',
            highlightColor: const Color(0xFF10B981),
            onTap: () {},
          ),
          SlidingNavMenuItem(
            title: 'Projects',
            highlightColor: const Color(0xFFF59E0B),
            onTap: () {},
          ),
          SlidingNavMenuItem(
            title: 'Team',
            highlightColor: const Color(0xFFEF4444),
            onTap: () {},
          ),
          SlidingNavMenuItem(
            title: 'Settings',
            highlightColor: const Color(0xFF8B5CF6),
            onTap: () {},
          ),
        ],
      ),
      defaultCode: """
SlidingNavMenu(
  theme: const SlidingNavMenuTheme(),
  items: [
    SlidingNavMenuItem(
      title: 'Dashboard',
      highlightColor: Color(0xFF6366F1),
      onTap: () {},
    ),
    SlidingNavMenuItem(
      title: 'Analytics',
      highlightColor: Color(0xFF10B981),
      onTap: () {},
    ),
    SlidingNavMenuItem(
      title: 'Projects',
      highlightColor: Color(0xFFF59E0B),
      onTap: () {},
    ),
    SlidingNavMenuItem(
      title: 'Team',
      highlightColor: Color(0xFFEF4444),
      onTap: () {},
    ),
    SlidingNavMenuItem(
      title: 'Settings',
      highlightColor: Color(0xFF8B5CF6),
      onTap: () {},
    ),
  ],
)
""",
      initialTheme: const SlidingNavMenuTheme(),
    ),
    ShowcaseItem(
      name: 'AnimatedFillIcon',
      category: ShowcaseCategory.social,
      widgetBuilder: (theme) => AnimatedFillIcon(
        theme: theme as AnimatedFillIconTheme,
        icons: const [
          AnimatedFillIconItem(
            icon: Icons.facebook,
            hoverColor: Color(0xFF3b5999), // Facebook blue
            tooltip: 'Facebook',
          ),
          AnimatedFillIconItem(
            icon: Icons.alternate_email,
            hoverColor: Color(0xFF55acee), // Twitter blue
            tooltip: 'Twitter',
          ),
          AnimatedFillIconItem(
            icon: Icons.work,
            hoverColor: Color(0xFF0077b5), // LinkedIn blue
            tooltip: 'LinkedIn',
          ),
          AnimatedFillIconItem(
            icon: Icons.email,
            hoverColor: Color(0xFFdd4b39), // Google red
            tooltip: 'Gmail',
          ),
        ],
      ),
      defaultCode: """
AnimatedFillIcon(
  theme: const AnimatedFillIconTheme(),
  icons: [
    AnimatedFillIconItem(
      icon: Icons.facebook,
      hoverColor: Color(0xFF3b5999),
      tooltip: 'Facebook',
    ),
    AnimatedFillIconItem(
      icon: Icons.alternate_email,
      hoverColor: Color(0xFF55acee),
      tooltip: 'Twitter',
    ),
    AnimatedFillIconItem(
      icon: Icons.work,
      hoverColor: Color(0xFF0077b5),
      tooltip: 'LinkedIn',
    ),
    AnimatedFillIconItem(
      icon: Icons.email,
      hoverColor: Color(0xFFdd4b39),
      tooltip: 'Gmail',
    ),
  ],
)
""",
      initialTheme: const AnimatedFillIconTheme(),
    ),
    ShowcaseItem(
      name: 'AnimatedHoverIcons',
      category: ShowcaseCategory.social,
      widgetBuilder: (theme) => AnimatedHoverIcons(
        theme: theme as AnimatedIconsTheme,
        icons: const [
          AnimatedIconItem(
            icon: Icons.calculate,
            hoverColor: Color(0xFFe67e22),
            tooltip: 'Calculator',
          ),
          AnimatedIconItem(
            icon: Icons.directions_car,
            hoverColor: Color(0xFFe67e22),
            tooltip: 'Car',
          ),
          AnimatedIconItem(
            icon: Icons.local_cafe,
            hoverColor: Color(0xFFe67e22),
            tooltip: 'Coffee',
          ),
          AnimatedIconItem(
            icon: Icons.thumb_up,
            hoverColor: Color(0xFFe67e22),
            tooltip: 'Thumbs Up',
          ),
        ],
      ),
      defaultCode: """
AnimatedHoverIcons(
  theme: const AnimatedIconsTheme(),
  icons: [
    AnimatedIconItem(
      icon: Icons.calculate,
      hoverColor: Color(0xFFe67e22),
      tooltip: 'Calculator',
    ),
    AnimatedIconItem(
      icon: Icons.directions_car,
      hoverColor: Color(0xFFe67e22),
      tooltip: 'Car',
    ),
    AnimatedIconItem(
      icon: Icons.local_cafe,
      hoverColor: Color(0xFFe67e22),
      tooltip: 'Coffee',
    ),
    AnimatedIconItem(
      icon: Icons.thumb_up,
      hoverColor: Color(0xFFe67e22),
      tooltip: 'Thumbs Up',
    ),
  ],
)
""",
      initialTheme: const AnimatedIconsTheme(),
    ),
    ShowcaseItem(
      name: 'HoverUnderline',
      category: ShowcaseCategory.social,
      widgetBuilder: (theme) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text example
          HoverUnderline(
            theme: theme as HoverUnderlineTheme,
            child: Text(
              'Reza Taghizadeh',
              style: theme.textStyle.copyWith(color: Colors.black),
            ),
            onTap: () {
              // Handle tap
            },
          ),
          const SizedBox(height: 30),
          // Icon example
          HoverUnderline(
            theme: theme,
            child: const Icon(
              Icons.favorite,
              size: 48,
              color: Colors.red,
            ),
            onTap: () {
              // Handle tap
            },
          ),
        ],
      ),
      defaultCode: """
// Text example
HoverUnderline(
  theme: const HoverUnderlineTheme(),
  child: Text(
    'Reza Taghizadeh',
    style: TextStyle(
      fontSize: 32,
      color: Colors.black,
    ),
  ),
  onTap: () {
    // Handle tap
  },
)

// Icon example
HoverUnderline(
  theme: const HoverUnderlineTheme(),
  child: Icon(
    Icons.favorite,
    size: 48,
    color: Colors.red,
  ),
  onTap: () {
    // Handle tap
  },
)

""",
      initialTheme: const HoverUnderlineTheme(),
    ),
    ShowcaseItem(
      name: 'LiquidMorph',
      category: ShowcaseCategory.social,
      widgetBuilder: (theme) => LiquidMorph(
        theme: theme as LiquidMorphTheme,
        child: const Text(
          'TRANSFORM',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
          // Handle tap
        },
      ),
      defaultCode: """
LiquidMorph(
  theme: const LiquidMorphTheme(),
  child: Text(
    'TRANSFORM',
    style: TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  ),
  onTap: () {
    // Handle tap
  },
)
""",
      initialTheme: const LiquidMorphTheme(),
    ),
    ShowcaseItem(
      name: 'AnimatedArrowButton',
      category: ShowcaseCategory.social,
      widgetBuilder: (theme) => AnimatedArrowButton(
        theme: theme as AnimatedArrowButtonTheme,
        onTap: () {
          // Handle tap
        },
      ),
      defaultCode: """
AnimatedArrowButton(
  theme: const AnimatedArrowButtonTheme(),
  onTap: () {
    // Handle tap
  },
)
""",
      initialTheme: const AnimatedArrowButtonTheme(),
    ),
    ShowcaseItem(
      name: 'PaperCardGrid',
      category: ShowcaseCategory.list,
      widgetBuilder: (theme) => SizedBox(
        height: 500,
        child: PaperCardGrid(
          theme: theme as PaperCardGridTheme,
          items: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child:
                        const Icon(Icons.code, size: 48, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Remix: a practical guide',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child:
                        const Icon(Icons.speed, size: 48, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Nuxt: a practical guide',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: const Icon(Icons.rocket_launch,
                        size: 48, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Solid: a practical guide',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child:
                        const Icon(Icons.star, size: 48, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Astro: a practical guide',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: const Icon(Icons.flash_on,
                        size: 48, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Qwik: a practical guide',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: const Icon(Icons.next_plan,
                        size: 48, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Next: a practical guide',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
          onCardTap: (index) {
            // Handle card tap
          },
        ),
      ),
      defaultCode: """
PaperCardGrid(
  theme: const PaperCardGridTheme(),
  items: [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Icon(Icons.code, size: 48, color: Colors.white),
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Remix: a practical guide',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    ),
    // Add more cards...
  ],
  onCardTap: (index) {
    // Handle card tap
  },
)
""",
      initialTheme: const PaperCardGridTheme(),
    ),
    ShowcaseItem(
      name: 'GlowCard',
      category: ShowcaseCategory.card,
      widgetBuilder: (theme) => GlowCard(
        theme: theme as GlowCardTheme,
        onTap: () {
          // Handle tap
        },
        child: const Padding(
          padding: EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.auto_awesome, size: 48, color: Color(0xFFBA7245)),
              SizedBox(height: 16),
              Text(
                'Glow Card',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Hover to see the glow effect',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      defaultCode: """
GlowCard(
  theme: const GlowCardTheme(),
  onTap: () {
    // Handle tap
  },
  child: Padding(
    padding: EdgeInsets.all(32.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.auto_awesome, size: 48),
        SizedBox(height: 16),
        Text(
          'Glow Card',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Hover to see the glow effect',
          textAlign: TextAlign.center,
        ),
      ],
    ),
  ),
)
""",
      initialTheme: const GlowCardTheme(),
    ),
    ShowcaseItem(
      name: 'LiquidGlass',
      category: ShowcaseCategory.card,
      widgetBuilder: (theme) => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1E3A8A),
              Color(0xFF3B0764),
            ],
          ),
        ),
        child: LiquidGlassCard(
          theme: theme as LiquidGlassTheme,
          onTap: () {
            // Handle tap
          },
          child: const Padding(
            padding: EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.water_drop, size: 48, color: Colors.white),
                SizedBox(height: 16),
                Text(
                  'Liquid Glass',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Animated liquid glass effect',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
      defaultCode: """
LiquidGlassCard(
  theme: const LiquidGlassTheme(),
  onTap: () {
    // Handle tap
  },
  child: Padding(
    padding: EdgeInsets.all(32.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.water_drop, size: 48, color: Colors.white),
        SizedBox(height: 16),
        Text(
          'Liquid Glass',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Animated liquid glass effect',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  ),
)
""",
      initialTheme: const LiquidGlassTheme(),
    ),
  ];
}
