# fl_hover

A comprehensive Flutter package providing beautiful hover effects and animations for web and desktop applications.

## Demo

Check out the live demo: [fl_hover Demo](https://alirezat66.github.io/fl_hover/)

## Features

- 🎨 **A rich collection of hover effects**: Cards, navigation menus, icons, buttons, and more.
- 🎯 **Highly Customizable**: Easily tweak animations, colors, and properties.
- 🌐 **Web & Desktop Ready**: Optimized for Flutter web and desktop platforms.
- 📦 **Easy to Use**: Simple, intuitive API with sensible defaults.

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  fl_hover: ^1.0.0 # Replace with the latest version
```

Then run: `flutter pub get`

## Available Widgets

Here is a list of the available widgets in this package:

### Cards

#### Holographic Card

Creates a stunning holographic appearance with animated gradients and shimmer effects.

![Holographic Card](https://github.com/alirezat66/fl_hover/blob/develop/assets/holographic_effect.gif?raw=true)

**Use Cases:**
- Product showcase cards for tech items
- Premium feature badges
- Special announcement cards
- Landing page hero cards

**Simple Usage:**
```dart
import 'package:fl_hover/fl_hover.dart';

HolographicCard(
  child: Text('Hover Me'),
)
```

**Advanced Usage with Custom Theme:**
```dart
HolographicCard(
  theme: HolographicEffectTheme(
    backgroundColor: Color(0xFF111111),
    shineColor: Color(0x4D00FFFF),  // rgba(0, 255, 255, 0.3)
    glowColor: Color(0x8000FFFF),   // rgba(0, 255, 255, 0.5)
    borderRadius: BorderRadius.circular(15),
    padding: EdgeInsets.all(24.0),
    scaleFactor: 1.05,
    animationDuration: Duration(milliseconds: 500),
    shineDuration: Duration(milliseconds: 500),
  ),
  child: Column(
    children: [
      Icon(Icons.star, size: 48, color: Colors.white),
      Text('Premium', style: TextStyle(color: Colors.white)),
    ],
  ),
)
```

**Theme Properties:**
| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `backgroundColor` | `Color` | `Color(0xFF111111)` | Background color of the card |
| `shineColor` | `Color` | `Color(0x4D00FFFF)` | Color of the holographic shine effect |
| `glowColor` | `Color` | `Color(0x8000FFFF)` | Color of the glow/shadow effect when hovered |
| `borderRadius` | `BorderRadius` | `BorderRadius.circular(15)` | Border radius for the card's corners |
| `padding` | `EdgeInsets` | `EdgeInsets.all(24)` | Padding between the card's border and its child |
| `elevation` | `double` | `0.0` | Elevation (shadow depth) of the card |
| `hoverElevation` | `double` | `0.0` | Elevation when hovered |
| `scaleFactor` | `double` | `1.05` | Scaling factor applied on hover |
| `animationDuration` | `Duration` | `500ms` | Duration of hover animations |
| `shineDuration` | `Duration` | `500ms` | Duration of one full sweep of the holographic shine |

---

#### Flip Card

A card that flips on hover to reveal content on the back.

![Flip Card](https://github.com/alirezat66/fl_hover/blob/develop/assets/flip_card.gif?raw=true)

**Use Cases:**
- Playing cards (Poker, Blackjack, Solitaire)
- Flash cards for education
- Credit/Debit card displays
- Business cards with contact info
- Trading cards
- Product comparison cards

**Simple Usage:**
```dart
FlipCard(
  front: Container(child: Text('Front')),
  back: Container(child: Text('Back')),
)
```

**Advanced Usage with Custom Theme:**
```dart
FlipCard(
  theme: FlipCardTheme(
    borderRadius: BorderRadius.circular(12),
    frontBackgroundColor: Color(0xFFF5F5DC),
    backBackgroundColor: Colors.white,
    padding: EdgeInsets.zero,
    width: 500,
    height: 350,
    animationDuration: Duration(milliseconds: 600),
    animationCurve: Curves.easeInOut,
    perspective: 0.001,
  ),
  front: Container(
    decoration: BoxDecoration(color: Color(0xFFF5F5DC)),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlutterLogo(size: 56),
          Text('FLUTTER', 
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8B8B7A),
              letterSpacing: 3,
            ),
          ),
        ],
      ),
    ),
  ),
  back: Container(
    decoration: BoxDecoration(color: Colors.white),
    child: Padding(
      padding: EdgeInsets.all(24),
      child: Text(
        'Flutter is Google\'s UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.',
        style: TextStyle(fontSize: 16),
      ),
    ),
  ),
)
```

**Theme Properties:**
| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `borderRadius` | `BorderRadius` | `BorderRadius.circular(8)` | Border radius for both sides |
| `frontBackgroundColor` | `Color` | `Color(0xFF2196F3)` | Background color of the front face |
| `backBackgroundColor` | `Color` | `Color(0xFF4CAF50)` | Background color of the back face |
| `padding` | `EdgeInsets` | `EdgeInsets.all(16)` | Padding inside the card |
| `width` | `double` | `300` | Width of the card |
| `height` | `double` | `200` | Height of the card |
| `animationDuration` | `Duration` | `600ms` | Duration of the flip animation |
| `animationCurve` | `Curve` | `Curves.easeInOut` | Curve of the flip animation |
| `perspective` | `double` | `0.001` | Perspective value for the 3D effect |

---

#### Card Face

A card with a top face that moves on hover to reveal the content underneath.

![Card Face](https://github.com/alirezat66/fl_hover/blob/develop/assets/card_face.gif?raw=true)

**Use Cases:**
- Product cards with image and details (e-commerce)
- Portfolio items with thumbnail and description
- Blog post preview cards
- Event cards with date and info

**Simple Usage:**
```dart
CardFace(
  topFace: Text('Summary'),
  bottomFace: Text('Details'),
  topFaceDecoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
    ),
  ),
)
```

**Advanced Usage with Custom Theme:**
```dart
CardFace(
  theme: CardFaceTheme(
    width: 300.0,
    height: 400.0,
    borderRadius: BorderRadius.circular(15),
    shrunkenHeight: 60.0,
    shadow: BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.5),
      blurRadius: 60,
      spreadRadius: 0,
      offset: Offset(0, 15),
    ),
    animationDuration: Duration(milliseconds: 500),
    animationCurve: Curves.easeInOut,
  ),
  bottomFace: Container(
    color: Colors.white,
    child: Column(
      children: [
        Text('Key Features:',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        // ... more content
      ],
    ),
  ),
  topFace: Column(
    children: [
      Expanded(
        child: Image.asset('assets/images/product.jpg', fit: BoxFit.cover),
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text('\$299.99', 
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  ),
  topFaceDecoration: BoxDecoration(color: Colors.white),
)
```

**Theme Properties:**
| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `width` | `double` | `300` | Width of the card |
| `height` | `double` | `400` | Height of the card |
| `borderRadius` | `BorderRadius` | `BorderRadius.circular(15)` | Border radius for the card |
| `shrunkenHeight` | `double` | `60` | Height of the top face when shrunk |
| `shadow` | `BoxShadow` | Custom | Box shadow for the card |
| `animationDuration` | `Duration` | `500ms` | Duration of the hover animation |
| `animationCurve` | `Curve` | `Curves.easeInOut` | Animation curve |

---

#### Card Slide

A card where the top image slides up on hover, revealing text content below.

![Card Slide](https://github.com/alirezat66/fl_hover/blob/develop/assets/card_slide.gif?raw=true)

**Use Cases:**
- Team member cards (photo + bio)
- Product cards (image + specifications)
- Service cards (icon + description)
- Testimonial cards (photo + quote)

**Simple Usage:**
```dart
CardSlide(
  topWidget: Image.network('...'),
  bottomWidget: Column(
    children: [
      Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('Role'),
    ],
  ),
)
```

**Advanced Usage with Custom Theme:**
```dart
CardSlide(
  theme: CardSlideTheme(
    backgroundColor: Colors.white,
    borderRadius: BorderRadius.circular(12),
    cardOffset: 20.0,
    cardWidth: 400.0,
    cardHeight: 250.0,
    coveragePercentage: 0.4,
    animationDuration: Duration(milliseconds: 500),
    animationCurve: Curves.easeOut,
    titleTextStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Color(0xFF414141),
    ),
    subtitleTextStyle: TextStyle(
      fontSize: 16,
      color: Color(0xFF414141),
    ),
  ),
  topWidget: ClipRRect(
    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
    child: Image.asset('assets/images/profile.jpg', fit: BoxFit.cover),
  ),
  bottomWidget: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('John Doe',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF414141),
        ),
      ),
      SizedBox(height: 10),
      Text('Senior Developer',
        style: TextStyle(fontSize: 16, color: Color(0xFF414141)),
      ),
    ],
  ),
)
```

**Theme Properties:**
| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `backgroundColor` | `Color` | `Colors.white` | Background color of the content panel |
| `borderRadius` | `BorderRadius` | `BorderRadius.circular(12)` | Border radius for the card |
| `cardOffset` | `double` | `20.0` | Offset from bottom where bottom card starts |
| `cardWidth` | `double` | `400` | Width of the card |
| `cardHeight` | `double` | `250` | Height of the card |
| `coveragePercentage` | `double` | `0.4` | Percentage of bottom card visible |
| `animationDuration` | `Duration` | `500ms` | Duration for the slide animation |
| `animationCurve` | `Curve` | `Curves.easeOut` | Curve for the animation |
| `titleTextStyle` | `TextStyle` | Custom | Text style for the title |
| `subtitleTextStyle` | `TextStyle` | Custom | Text style for the subtitle |

---

#### Card Hover

A card with a hover effect that includes a category, title, author, and time.

![Card Hover](https://github.com/alirezat66/fl_hover/blob/develop/assets/card_hover.gif?raw=true)

**Use Cases:**
- Recipe cards (photo + ingredients + cooking time)
- Blog post cards (image + title + author + read time)
- News article cards
- Event cards (image + event details + date/time)
- Portfolio item cards

**Simple Usage:**
```dart
CardHover(
  image: NetworkImage('...'),
  title: 'My Awesome Title',
  category: 'Flutter',
  author: 'John Doe',
  timeText: '5 min read',
)
```

**Theme Properties:**
| Property | Type | Default | Description |
|----------|------|---------|-------------|
| Various theme properties | Various | Various | See CardHoverTheme documentation |

---

#### Paper Card Grid

A grid of cards with a paper-like unfolding effect on hover.

![Paper Card Grid](https://github.com/alirezat66/fl_hover/blob/develop/assets/paper_card_grid.gif?raw=true)

**Use Cases:**
- Tutorial/documentation grid
- Course cards grid
- Project showcase grid
- Feature highlights grid

**Simple Usage:**
```dart
PaperCardGrid(
  items: [
    Text('Card 1'),
    Text('Card 2'),
  ],
  onCardTap: (index) {},
)
```

**Theme Properties:**
| Property | Type | Default | Description |
|----------|------|---------|-------------|
| Various theme properties | Various | Various | See PaperCardGridTheme documentation |

---

#### Glow Card

A card that emits a glow effect from the borders on hover.

![Glow Card](https://github.com/alirezat66/fl_hover/blob/develop/assets/glow_card.gif?raw=true)

**Use Cases:**
- Premium feature highlights
- Special announcement cards
- Call-to-action cards
- Achievement badges

**Simple Usage:**
```dart
GlowCard(
  child: Text('Glow'),
  onTap: () {},
)
```

**Theme Properties:**
| Property | Type | Default | Description |
|----------|------|---------|-------------|
| Various theme properties | Various | Various | See GlowCardTheme documentation |

---

#### Liquid Glass Card

A card with a liquid-like, distorted glass effect on hover.

![Liquid Glass Card](https://github.com/alirezat66/fl_hover/blob/develop/assets/liquid_glass.gif?raw=true)

**Use Cases:**
- Interactive portfolio cards
- Premium product displays
- Feature showcases
- Game UI elements

**Simple Usage:**
```dart
LiquidGlassCard(
  child: Text('Liquid'),
  onTap: () {},
)
```

**Theme Properties:**
| Property | Type | Default | Description |
|----------|------|---------|-------------|
| Various theme properties | Various | Various | See LiquidGlassTheme documentation |

---

### Navigation

#### Animated Nav Menu

A navigation menu with items that animate with a gradient on hover.

![Animated Nav Menu](https://github.com/alirezat66/fl_hover/blob/develop/assets/animated_nav_menu.gif?raw=true)

**Use Cases:**
- Main website navigation
- Mobile app side menu
- Dashboard navigation
- Admin panel menu

**Simple Usage:**
```dart
AnimatedNavMenu(
  items: [
    AnimatedNavMenuItem(icon: Icons.home, title: 'Home', onTap: () {}),
    AnimatedNavMenuItem(icon: Icons.search, title: 'Search', onTap: () {}),
  ],
)
```

**Theme Properties:**
| Property | Type | Default | Description |
|----------|------|---------|-------------|
| Various theme properties | Various | Various | See AnimatedNavMenuTheme documentation |

---

#### Sliding Nav Menu

A navigation menu with a sliding highlight that moves to the hovered item.

![Sliding Nav Menu](https://github.com/alirezat66/fl_hover/blob/develop/assets/sliding_nav_menu.gif?raw=true)

**Use Cases:**
- Tab navigation
- Settings menu
- Dashboard side menu
- Filter menu

**Simple Usage:**
```dart
SlidingNavMenu(
  items: [
    SlidingNavMenuItem(title: 'Home', onTap: () {}),
    SlidingNavMenuItem(title: 'Profile', onTap: () {}),
  ],
)
```

**Theme Properties:**
| Property | Type | Default | Description |
|----------|------|---------|-------------|
| Various theme properties | Various | Various | See SlidingNavMenuTheme documentation |

---

### Icons & Buttons

#### Animated Fill Icon

A set of icons that fill with color on hover.

![Animated Fill Icon](https://github.com/alirezat66/fl_hover/blob/develop/assets/animated_fill_icon.gif?raw=true)

**Use Cases:**
- Social media share buttons
- Action buttons (like, favorite, bookmark)
- Rating icons
- Status indicators

**Simple Usage:**
```dart
AnimatedFillIcon(
  icons: [
    AnimatedFillIconItem(icon: Icons.favorite, hoverColor: Colors.red),
    AnimatedFillIconItem(icon: Icons.star, hoverColor: Colors.yellow),
  ],
)
```

**Theme Properties:**
| Property | Type | Default | Description |
|----------|------|---------|-------------|
| Various theme properties | Various | Various | See AnimatedFillIconTheme documentation |

---

#### Animated Hover Icons

A set of icons that perform a jump and color change animation on hover.

![Animated Hover Icons](https://github.com/alirezat66/fl_hover/blob/develop/assets/animated_hover_icon.gif?raw=true)

**Use Cases:**
- Toolbar icons
- Quick action buttons
- Feature icons
- Category icons

**Simple Usage:**
```dart
AnimatedHoverIcons(
  icons: [
    AnimatedIconItem(icon: Icons.thumb_up, hoverColor: Colors.blue),
    AnimatedIconItem(icon: Icons.comment, hoverColor: Colors.green),
  ],
)
```

**Theme Properties:**
| Property | Type | Default | Description |
|----------|------|---------|-------------|
| Various theme properties | Various | Various | See AnimatedIconsTheme documentation |

---

#### Hover Underline

A widget (text or icon) that gets an animated underline on hover.

![Hover Underline](https://github.com/alirezat66/fl_hover/blob/develop/assets/hover_under_line.gif?raw=true)

**Use Cases:**
- Navigation links
- Read more links
- Clickable text elements
- Icon links

**Simple Usage:**
```dart
HoverUnderline(
  child: Text('Hover Me'),
  onTap: () {},
)
```

**Theme Properties:**
| Property | Type | Default | Description |
|----------|------|---------|-------------|
| Various theme properties | Various | Various | See HoverUnderlineTheme documentation |

---

#### Liquid Morph

A button with a liquid morphing effect on hover.

![Liquid Morph](https://github.com/alirezat66/fl_hover/blob/develop/assets/liquid_morph.gif?raw=true)

**Use Cases:**
- Call-to-action buttons
- Submit buttons
- Feature activation buttons
- Game buttons

**Simple Usage:**
```dart
LiquidMorph(
  child: Text('Submit'),
  onTap: () {},
)
```

**Theme Properties:**
| Property | Type | Default | Description |
|----------|------|---------|-------------|
| Various theme properties | Various | Various | See LiquidMorphTheme documentation |

---

#### Animated Arrow Button

A button with an arrow that animates on hover.

![Animated Arrow Button](https://github.com/alirezat66/fl_hover/blob/develop/assets/animated_arrow_button.gif?raw=true)

**Use Cases:**
- Continue/Next buttons
- Forward/Backward navigation
- Slide arrows
- Read more buttons

**Simple Usage:**
```dart
AnimatedArrowButton(
  onTap: () {},
)
```

**Theme Properties:**
| Property | Type | Default | Description |
|----------|------|---------|-------------|
| Various theme properties | Various | Various | See AnimatedArrowButtonTheme documentation |

---

### Effects

#### Cursor Showcase

An effect that changes the cursor's appearance and adds a trailing highlight effect.

**Use Cases:**
- Interactive portfolio
- Creative agency websites
- Gaming websites
- Interactive presentations

**Simple Usage:**
```dart
CursorShowcase()
```

**Theme Properties:**
| Property | Type | Default | Description |
|----------|------|---------|-------------|
| Various theme properties | Various | Various | See CursorShowcaseTheme documentation |

---

#### Split Image

An image that splits into multiple pieces on hover.

**Use Cases:**
- Portfolio galleries
- Product galleries
- Team member showcases
- Photo galleries

**Simple Usage:**
```dart
SplitImage(
  image: NetworkImage('...'),
  onTap: () {},
)
```

**Theme Properties:**
| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `columns` | `int` | `5` | Number of vertical columns to split the image |
| `animationDuration` | `Duration` | `400ms` | Duration of the animation when hovering |
| `animationCurve` | `Curve` | `Curves.easeInOut` | Animation curve |
| `cursorBehavior` | `CursorBehavior` | `CursorBehavior.pointer` | Mouse cursor when hovering |
| `cellAnimations` | `Map<int, CellAnimation>` | Custom | Configuration for each column's animation |

---

## Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

## License
This project is licensed under the MIT License - see the LICENSE file for details.
