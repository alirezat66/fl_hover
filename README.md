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

![Holographic Card](https://github.com/alirezat66/fl_hover/blob/develop/assets/holographic_card.gif?raw=true)

**Simple Usage:**
```dart
HolographicCard(
  child: Text('Hover Me'),
)
```

**Customizable Properties:**
| Property      | Type          | Description                               |
|---------------|---------------|-------------------------------------------|
| `theme`       | `HolographicEffectTheme` | Defines the visual properties of the card. |
| `child`       | `Widget`      | The widget to display inside the card.    |

---

#### Flip Card
A card that flips on hover to reveal content on the back.

![Flip Card](https://github.com/alirezat66/fl_hover/blob/develop/assets/flip_card.gif?raw=true)

**Simple Usage:**
```dart
FlipCard(
  front: Container(child: Text('Front')),
  back: Container(child: Text('Back')),
)
```

**Customizable Properties:**
| Property | Type | Description |
|---|---|---|
| `front` | `Widget` | The widget to display on the front of the card. |
| `back` | `Widget` | The widget to display on the back of the card. |
| `theme` | `FlipCardTheme` | Defines the visual properties of the card. |

---

#### Card Face
A card with a top face that moves on hover to reveal the content underneath.

![Card Face](https://github.com/alirezat66/fl_hover/blob/develop/assets/card_face.gif?raw=true)

**Simple Usage:**
```dart
CardFace(
  topFace: Text('Summary'),
  bottomFace: Text('Details'),
)
```

**Customizable Properties:**
| Property | Type | Description |
|---|---|---|
| `topFace` | `Widget` | The widget that is initially visible. |
| `bottomFace` | `Widget` | The widget that is revealed on hover. |
| `theme` | `CardFaceTheme` | Defines the visual properties of the card. |

---

#### Card Slide
A card where the top image slides up on hover, revealing text content below.

![Card Slide](https://github.com/alirezat66/fl_hover/blob/develop/assets/card_slide.gif?raw=true)

**Simple Usage:**
```dart
CardSlide(
  topWidget: Image.network('...'),
  bottomWidget: Text('Details'),
)
```

**Customizable Properties:**
| Property | Type | Description |
|---|---|---|
| `topWidget` | `Widget` | The widget at the top (usually an image). |
| `bottomWidget` | `Widget` | The widget at the bottom, revealed on hover. |
| `theme` | `CardSlideTheme` | Defines the visual properties of the card. |

---

#### Card Hover
A card with a hover effect that includes a category, title, author, and time.

![Card Hover](https://github.com/alirezat66/fl_hover/blob/develop/assets/card_hover.gif?raw=true)

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
**Customizable Properties:**
| Property | Type | Description |
|---|---|---|
| `image` | `ImageProvider` | The background image for the card. |
| `title` | `String` | The main title text. |
| `category` | `String` | The category text displayed at the top. |
| `author` | `String` | The author's name. |
| `timeText` | `String` | Text to display for time (e.g., read time). |
| `theme` | `CardHoverTheme` | Defines the visual properties of the card. |

---

#### Paper Card Grid
A grid of cards with a paper-like unfolding effect on hover.

![Paper Card Grid](https://github.com/alirezat66/fl_hover/blob/develop/assets/paper_card_grid.gif?raw=true)

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

**Customizable Properties:**
| Property | Type | Description |
|---|---|---|
| `items` | `List<Widget>` | The list of widgets to display in the grid. |
| `onCardTap` | `Function(int)` | Callback for when a card is tapped. |
| `theme` | `PaperCardGridTheme` | Defines the visual properties of the grid. |

---

#### Glow Card
A card that emits a glow effect from the borders on hover.

![Glow Card](https://github.com/alirezat66/fl_hover/blob/develop/assets/glow_card.gif?raw=true)

**Simple Usage:**
```dart
GlowCard(
  child: Text('Glow'),
  onTap: () {},
)
```

**Customizable Properties:**
| Property | Type | Description |
|---|---|---|
| `child` | `Widget` | The content of the card. |
| `onTap` | `Function()` | Callback for when the card is tapped. |
| `theme` | `GlowCardTheme` | Defines the visual properties of the card. |

---

#### Liquid Glass Card
A card with a liquid-like, distorted glass effect on hover.

![Liquid Glass Card](https://github.com/alirezat66/fl_hover/blob/develop/assets/liquid_glass.gif?raw=true)

**Simple Usage:**
```dart
LiquidGlassCard(
  child: Text('Liquid'),
  onTap: () {},
)
```
**Customizable Properties:**
| Property | Type | Description |
|---|---|---|
| `child` | `Widget` | The content of the card. |
| `onTap` | `Function()` | Callback for when the card is tapped. |
| `theme` | `LiquidGlassTheme` | Defines the visual properties of the card. |

---

### Navigation

#### Animated Nav Menu
A navigation menu with items that animate with a gradient on hover.

![Animated Nav Menu](https://github.com/alirezat66/fl_hover/blob/develop/assets/animated_nav_menu.gif?raw=true)

**Simple Usage:**
```dart
AnimatedNavMenu(
  items: [
    AnimatedNavMenuItem(icon: Icons.home, title: 'Home', onTap: () {}),
    AnimatedNavMenuItem(icon: Icons.search, title: 'Search', onTap: () {}),
  ],
)
```
**Customizable Properties:**
| Property | Type | Description |
|---|---|---|
| `items` | `List<AnimatedNavMenuItem>` | The list of navigation items. |
| `theme` | `AnimatedNavMenuTheme` | Defines the visual properties of the menu. |

---

#### Sliding Nav Menu
A navigation menu with a sliding highlight that moves to the hovered item.

![Sliding Nav Menu](https://github.com/alirezat66/fl_hover/blob/develop/assets/sliding_nav_menu.gif?raw=true)

**Simple Usage:**
```dart
SlidingNavMenu(
  items: [
    SlidingNavMenuItem(title: 'Home', onTap: () {}),
    SlidingNavMenuItem(title: 'Profile', onTap: () {}),
  ],
)
```
**Customizable Properties:**
| Property | Type | Description |
|---|---|---|
| `items` | `List<SlidingNavMenuItem>` | The list of navigation items. |
| `theme` | `SlidingNavMenuTheme` | Defines the visual properties of the menu. |

---

### Icons & Buttons

#### Animated Fill Icon
A set of icons that fill with color on hover.

![Animated Fill Icon](https://github.com/alirezat66/fl_hover/blob/develop/assets/animated_fill_icon.gif?raw=true)

**Simple Usage:**
```dart
AnimatedFillIcon(
  icons: [
    AnimatedFillIconItem(icon: Icons.favorite, hoverColor: Colors.red),
    AnimatedFillIconItem(icon: Icons.star, hoverColor: Colors.yellow),
  ],
)
```
**Customizable Properties:**
| Property | Type | Description |
|---|---|---|
| `icons` | `List<AnimatedFillIconItem>` | The list of icon items. |
| `theme` | `AnimatedFillIconTheme` | Defines the visual properties of the icons. |

---

#### Animated Hover Icons
A set of icons that perform a jump and color change animation on hover.

![Animated Hover Icons](https://github.com/alirezat66/fl_hover/blob/develop/assets/animated_hover_icon.gif?raw=true)

**Simple Usage:**
```dart
AnimatedHoverIcons(
  icons: [
    AnimatedIconItem(icon: Icons.thumb_up, hoverColor: Colors.blue),
    AnimatedIconItem(icon: Icons.comment, hoverColor: Colors.green),
  ],
)
```
**Customizable Properties:**
| Property | Type | Description |
|---|---|---|
| `icons` | `List<AnimatedIconItem>` | The list of icon items. |
| `theme` | `AnimatedIconsTheme` | Defines the visual properties of the icons. |

---

#### Hover Underline
A widget (text or icon) that gets an animated underline on hover.

![Hover Underline](https://github.com/alirezat66/fl_hover/blob/develop/assets/hover_under_line.gif?raw=true)

**Simple Usage:**
```dart
HoverUnderline(
  child: Text('Hover Me'),
  onTap: () {},
)
```

**Customizable Properties:**
| Property | Type | Description |
|---|---|---|
| `child` | `Widget` | The widget to underline on hover. |
| `onTap` | `Function()` | Callback for when the widget is tapped. |
| `theme` | `HoverUnderlineTheme` | Defines the visual properties of the underline. |

---

#### Liquid Morph
A button with a liquid morphing effect on hover.

![Liquid Morph](https://github.com/alirezat66/fl_hover/blob/develop/assets/liquid_morph.gif?raw=true)

**Simple Usage:**
```dart
LiquidMorph(
  child: Text('Submit'),
  onTap: () {},
)
```

**Customizable Properties:**
| Property | Type | Description |
|---|---|---|
| `child` | `Widget` | The content of the button. |
| `onTap` | `Function()` | Callback for when the button is tapped. |
| `theme` | `LiquidMorphTheme` | Defines the visual properties of the button. |

---

#### Animated Arrow Button
A button with an arrow that animates on hover.

![Animated Arrow Button](https://github.com/alirezat66/fl_hover/blob/develop/assets/animated_arrow_button.gif?raw=true)

**Simple Usage:**
```dart
AnimatedArrowButton(
  onTap: () {},
)
```
**Customizable Properties:**
| Property | Type | Description |
|---|---|---|
| `onTap` | `Function()` | Callback for when the button is tapped. |
| `theme` | `AnimatedArrowButtonTheme` | Defines the visual properties of the button. |

---

### Effects

#### Cursor Showcase
An effect that changes the cursor's appearance and adds a trailing highlight effect.

![Cursor Showcase](https://github.com/alirezat66/fl_hover/blob/develop/assets/cursor_showcase.gif?raw=true)

**Simple Usage:**
```dart
CursorShowcase()
```
**Customizable Properties:**
| Property | Type | Description |
|---|---|---|
| `theme` | `CursorShowcaseTheme` | Defines the visual properties of the cursor effect. |

---

#### Split Image
An image that splits into multiple pieces on hover.

![Split Image](https://github.com/alirezat66/fl_hover/blob/develop/assets/split_image.gif?raw=true)

**Simple Usage:**
```dart
SplitImage(
  image: NetworkImage('...'),
  onTap: () {},
)
```
**Customizable Properties:**
| Property | Type | Description |
|---|---|---|
| `image` | `ImageProvider` | The image to apply the effect to. |
| `onTap` | `Function()` | Callback for when the image is tapped. |
| `theme` | `SplitImageTheme` | Defines the visual properties of the effect. |

---

## Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

## License
This project is licensed under the MIT License - see the LICENSE file for details.
