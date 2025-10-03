# FlipCard

A Flutter widget that creates a stunning 3D flip card effect. The card flips 180 degrees on hover, revealing the back side with a smooth animation. Perfect for flashcards, product showcases, profile cards, and any interactive content.

## Features

- ✨ Smooth 3D flip animation
- 🎨 Fully customizable front and back sides
- ⏱️ Configurable animation duration and curve
- 📏 Adjustable card dimensions
- 🎯 Custom perspective control for 3D depth
- 🖱️ Hover-triggered animation
- 🎨 Themeable via `ThemeExtension`

## Basic Usage

```dart
import 'package:flutter_hover_effects/hover_effects.dart';

FlipCard(
  front: Container(
    color: Colors.blue,
    child: Center(
      child: Text(
        'Front Side',
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    ),
  ),
  back: Container(
    color: Colors.red,
    child: Center(
      child: Text(
        'Back Side',
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    ),
  ),
)
```

## Custom Theme

```dart
FlipCard(
  theme: FlipCardTheme(
    width: 300,
    height: 200,
    padding: EdgeInsets.all(16),
    borderRadius: BorderRadius.circular(12),
    animationDuration: Duration(milliseconds: 600),
    animationCurve: Curves.easeInOut,
    perspective: 0.001,
    frontBackgroundColor: Colors.blue,
    backBackgroundColor: Colors.green,
  ),
  front: Text('Front'),
  back: Text('Back'),
)
```

## Parameters

### FlipCard

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `front` | `Widget` | required | Widget displayed on the front of the card |
| `back` | `Widget` | required | Widget displayed on the back of the card |
| `theme` | `FlipCardTheme?` | null | Theme configuration for the card |

### FlipCardTheme

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `borderRadius` | `BorderRadius?` | `BorderRadius.circular(8)` | Border radius for both sides |
| `frontBackgroundColor` | `Color?` | `Color(0xFF2196F3)` | Background color of the front face |
| `backBackgroundColor` | `Color?` | `Color(0xFF4CAF50)` | Background color of the back face |
| `padding` | `EdgeInsets?` | `EdgeInsets.all(16)` | Padding inside the card |
| `width` | `double?` | `300.0` | Width of the card |
| `height` | `double?` | `200.0` | Height of the card |
| `animationDuration` | `Duration?` | `600ms` | Duration of the flip animation |
| `animationCurve` | `Curve?` | `Curves.easeInOut` | Animation easing curve |
| `perspective` | `double?` | `0.001` | 3D perspective value (smaller = more depth) |

## Use Cases

### Flashcard

Perfect for learning applications, quiz games, or educational content:

```dart
FlipCard(
  theme: FlipCardTheme(
    padding: EdgeInsets.zero,
    width: 500,
    height: 350,
    frontBackgroundColor: Color(0xFFF5F5DC), // Beige
    backBackgroundColor: Colors.white,
  ),
  front: Center(
    child: Text(
      'SIMPLICITY',
      style: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: Color(0xFF8B8B7A),
        letterSpacing: 3,
      ),
    ),
  ),
  back: Padding(
    padding: EdgeInsets.all(24),
    child: Text(
      'Revolution by revolution, Steve Jobs proved that Simplicity '
      'is the most powerful force in business...',
      style: TextStyle(fontSize: 16, height: 1.6),
    ),
  ),
)
```

### Product Showcase

Display product information with an elegant flip:

```dart
FlipCard(
  theme: FlipCardTheme(
    width: 350,
    height: 450,
    borderRadius: BorderRadius.circular(16),
  ),
  front: Column(
    children: [
      Expanded(
        child: Image.network('https://example.com/product.jpg'),
      ),
      Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Premium Headphones',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  ),
  back: Padding(
    padding: EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Features:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        Text('• Noise cancellation'),
        Text('• 30-hour battery life'),
        Text('• Bluetooth 5.0'),
        Text('• Premium sound quality'),
        Spacer(),
        Text('\$299.99', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ],
    ),
  ),
)
```

### Profile Card

Create interactive team member cards:

```dart
FlipCard(
  theme: FlipCardTheme(
    width: 280,
    height: 320,
    borderRadius: BorderRadius.circular(20),
  ),
  front: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage('https://example.com/avatar.jpg'),
      ),
      SizedBox(height: 16),
      Text(
        'John Doe',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      Text(
        'Senior Developer',
        style: TextStyle(color: Colors.grey),
      ),
    ],
  ),
  back: Padding(
    padding: EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('Passionate developer with 5+ years of experience...'),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.email),
            Icon(Icons.phone),
            Icon(Icons.link),
          ],
        ),
      ],
    ),
  ),
)
```

## Theme Integration

Register the theme globally in your app:

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      FlipCardTheme(
        width: 350,
        height: 250,
        animationDuration: Duration(milliseconds: 800),
        animationCurve: Curves.elasticOut,
      ),
    ],
  ),
  home: MyHomePage(),
)
```

Then use without explicitly passing the theme:

```dart
FlipCard(
  front: Text('Front'),
  back: Text('Back'),
)
```

## Animation Curves

Different curves create different flip effects:

- `Curves.easeInOut` - Smooth, natural flip (default)
- `Curves.linear` - Constant speed flip
- `Curves.bounceOut` - Flip with bounce at the end
- `Curves.elasticOut` - Elastic, spring-like flip
- `Curves.fastOutSlowIn` - Material Design standard

## Perspective Effect

The `perspective` parameter controls the 3D depth:

- `0.001` - Strong 3D effect (default)
- `0.002` - Moderate 3D effect
- `0.003` - Subtle 3D effect
- `0.0` - No perspective (2D flip)

```dart
FlipCard(
  theme: FlipCardTheme(
    perspective: 0.002, // Moderate 3D depth
  ),
  front: Text('Front'),
  back: Text('Back'),
)
```

## Tips & Best Practices

1. **Content Size**: Ensure both front and back content fit within the card dimensions
2. **Readability**: Use sufficient contrast between text and background colors
3. **Performance**: Avoid complex animations on the card content during flip
4. **Padding**: Use `EdgeInsets.zero` for full-width content like images
5. **Accessibility**: Consider adding tooltips or labels for screen readers

## Common Patterns

### No Background Colors

For transparent or custom backgrounds:

```dart
FlipCard(
  theme: FlipCardTheme(
    frontBackgroundColor: Colors.transparent,
    backBackgroundColor: Colors.transparent,
    padding: EdgeInsets.zero,
  ),
  front: YourCustomFrontWidget(),
  back: YourCustomBackWidget(),
)
```

### Full-Width Image

For cards with edge-to-edge images:

```dart
FlipCard(
  theme: FlipCardTheme(
    padding: EdgeInsets.zero,
    borderRadius: BorderRadius.circular(12),
  ),
  front: ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Image.network(
      'https://example.com/image.jpg',
      fit: BoxFit.cover,
    ),
  ),
  back: YourBackContent(),
)
```

### Slow Dramatic Flip

For emphasis and dramatic effect:

```dart
FlipCard(
  theme: FlipCardTheme(
    animationDuration: Duration(milliseconds: 1200),
    animationCurve: Curves.easeInOutCubic,
  ),
  front: Text('Front'),
  back: Text('Back'),
)
```

## See Also

- [CardSlide](../card_slide/README.md) - Vertical slide card effect
- [CardFace](../card_face/README.md) - Expandable card effect
- [CardHover](../card_hover/README.md) - Overlay hover effect

