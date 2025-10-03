# SplitImage (Holographic Effect)

A Flutter widget that creates a stunning holographic split image effect. The image is divided into vertical columns that animate up and down on hover, creating a dynamic and eye-catching visual experience.

![SplitImage Holographic Effect](https://images.pexels.com/photos/205926/pexels-photo-205926.jpeg?auto=compress&cs=tinysrgb&w=800)

*Example of the holographic split image effect in action*

## Features

- ✨ Split image into customizable number of columns (5-10)
- 🎭 Independent animation for each column
- ⏱️ Configurable animation duration and curve
- 🎯 Staggered delays for wave-like effects
- 🖱️ Customizable cursor behavior
- 🎨 Fully themeable via `ThemeExtension`
- 🔄 Dynamic column generation for any number of columns

## Visual Examples

### Default Configuration (5 Columns)
The image splits into 5 vertical columns with alternating up/down movements:
- Column 1: Moves down 10% with 100ms delay
- Column 2: Moves up 4% with 100ms delay  
- Column 3: Moves down 6% with no delay
- Column 4: Moves down 4% with 150ms delay
- Column 5: Moves up 10% with 50ms delay

### Extended Configuration (10 Columns)
When you increase columns to 10, additional columns get auto-generated animations:
- Columns 6-10: Alternating patterns with varying delays
- Creates a more complex and dynamic holographic effect

## Basic Usage

```dart
import 'package:flutter_hover_effects/hover_effects.dart';

SplitImage(
  image: AssetImage('assets/my_image.jpg'),
)
```

## Custom Configuration

```dart
SplitImage(
  image: NetworkImage('https://example.com/image.jpg'),
  theme: SplitImageTheme(
    columns: 5,
    animationDuration: Duration(milliseconds: 400),
    animationCurve: Curves.easeInOut,
    cursorBehavior: CursorBehavior.pointer,
    cellAnimations: {
      0: CellAnimation(translateY: 10.0, delay: 100),
      1: CellAnimation(translateY: -4.0, delay: 100),
      2: CellAnimation(translateY: 6.0, delay: 0),
      3: CellAnimation(translateY: 4.0, delay: 150),
      4: CellAnimation(translateY: -10.0, delay: 50),
    },
  ),
  onTap: () {
    print('Image tapped!');
  },
)
```

## Parameters

### SplitImage

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `image` | `ImageProvider` | required | The image to display (AssetImage, NetworkImage, etc.) |
| `theme` | `SplitImageTheme?` | null | Theme configuration for the effect |
| `onTap` | `VoidCallback?` | null | Callback when the image is tapped |

### SplitImageTheme

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `columns` | `int` | 5 | Number of vertical columns to split the image into |
| `rows` | `int` | 5 | Reserved for future use |
| `animationDuration` | `Duration` | 400ms | Duration of the hover animation |
| `animationCurve` | `Curve` | easeInOut | Animation easing curve |
| `cursorBehavior` | `CursorBehavior` | pointer | Mouse cursor style on hover |
| `cellAnimations` | `Map<int, CellAnimation>` | default pattern | Animation config for each column |

### CellAnimation

| Parameter | Type | Description |
|-----------|------|-------------|
| `translateY` | `double` | Vertical movement as percentage of image height<br>Positive = down, Negative = up |
| `delay` | `int` | Delay before animation starts (milliseconds) |

## Animation Patterns

### Wave Effect
```dart
cellAnimations: {
  0: CellAnimation(translateY: 20.0, delay: 0),
  1: CellAnimation(translateY: 15.0, delay: 50),
  2: CellAnimation(translateY: 10.0, delay: 100),
  3: CellAnimation(translateY: 15.0, delay: 150),
  4: CellAnimation(translateY: 20.0, delay: 200),
}
```

### Alternating Up/Down
```dart
cellAnimations: {
  0: CellAnimation(translateY: -20.0, delay: 0),
  1: CellAnimation(translateY: 20.0, delay: 50),
  2: CellAnimation(translateY: -20.0, delay: 100),
  3: CellAnimation(translateY: 20.0, delay: 150),
  4: CellAnimation(translateY: -20.0, delay: 200),
}
```

### Synchronized Movement
```dart
cellAnimations: {
  0: CellAnimation(translateY: 15.0, delay: 0),
  1: CellAnimation(translateY: 15.0, delay: 0),
  2: CellAnimation(translateY: 15.0, delay: 0),
  3: CellAnimation(translateY: 15.0, delay: 0),
  4: CellAnimation(translateY: 15.0, delay: 0),
}
```

### Random/Chaotic
```dart
cellAnimations: {
  0: CellAnimation(translateY: 10.0, delay: 100),
  1: CellAnimation(translateY: -4.0, delay: 100),
  2: CellAnimation(translateY: 6.0, delay: 0),
  3: CellAnimation(translateY: 4.0, delay: 150),
  4: CellAnimation(translateY: -10.0, delay: 50),
}
```

## Theme Integration

You can register the theme globally in your app:

```dart
MaterialApp(
  theme: ThemeData(
    extensions: [
      SplitImageTheme(
        columns: 5,
        animationDuration: Duration(milliseconds: 500),
        animationCurve: Curves.elasticOut,
      ),
    ],
  ),
  home: MyHomePage(),
)
```

Then use it without explicitly passing the theme:

```dart
SplitImage(
  image: AssetImage('assets/image.jpg'),
)
```

## Animation Curves

Popular curves for different effects:

- `Curves.easeInOut` - Smooth, natural movement (default)
- `Curves.bounceOut` - Bouncy, playful effect
- `Curves.elasticOut` - Elastic, spring-like movement
- `Curves.fastOutSlowIn` - Material Design standard
- `Curves.easeOut` - Quick start, slow end
- `Curves.linear` - Constant speed

## Tips & Best Practices

1. **Column Count**: 5-7 columns work best for most images
2. **translateY Range**: Keep values between -25.0 and 25.0 for subtle effects
3. **Delay Pattern**: Use 50-150ms intervals for smooth staggered animations
4. **Animation Duration**: 300-500ms provides good balance between speed and smoothness
5. **Image Size**: Ensure images are optimized for web/mobile to prevent loading delays

## Examples

### Subtle Professional Effect
```dart
SplitImage(
  image: AssetImage('assets/profile.jpg'),
  theme: SplitImageTheme(
    columns: 5,
    animationDuration: Duration(milliseconds: 300),
    animationCurve: Curves.easeOut,
    cellAnimations: {
      0: CellAnimation(translateY: 5.0, delay: 0),
      1: CellAnimation(translateY: -3.0, delay: 50),
      2: CellAnimation(translateY: 4.0, delay: 100),
      3: CellAnimation(translateY: -2.0, delay: 150),
      4: CellAnimation(translateY: 3.0, delay: 200),
    },
  ),
)
```

### Bold Playful Effect
```dart
SplitImage(
  image: AssetImage('assets/banner.jpg'),
  theme: SplitImageTheme(
    columns: 7,
    animationDuration: Duration(milliseconds: 600),
    animationCurve: Curves.elasticOut,
    cellAnimations: {
      0: CellAnimation(translateY: 25.0, delay: 0),
      1: CellAnimation(translateY: -20.0, delay: 100),
      2: CellAnimation(translateY: 15.0, delay: 200),
      3: CellAnimation(translateY: -25.0, delay: 300),
      4: CellAnimation(translateY: 20.0, delay: 400),
      5: CellAnimation(translateY: -15.0, delay: 500),
      6: CellAnimation(translateY: 10.0, delay: 600),
    },
  ),
)
```

## Troubleshooting

**Q: Image appears stretched or distorted**  
A: The image automatically adjusts to fit the container. Wrap `SplitImage` in a `Center` or `Container` with specific dimensions.

**Q: Animation feels choppy**  
A: Try reducing the animation duration or using a different curve like `Curves.easeOut`.

**Q: Hover triggers outside the image**  
A: This is expected behavior. The widget reserves extra space for column movements. The hover area is limited to the actual image bounds.

**Q: Columns don't animate**  
A: Ensure `cellAnimations` map includes entries for all column indices (0 to columns-1).

## Playground Controls

The SplitImage widget includes interactive playground controls for easy customization:

### Available Controls
- **Columns (5-10)**: Slider to adjust number of vertical columns
- **Animation Duration**: Slider to control animation speed (0.1s - 5s)
- **Animation Curve**: Dropdown with various easing options
- **Cursor Behavior**: Dropdown to change mouse cursor on hover

### Real-time Preview
All changes are applied instantly, allowing you to see the effect in real-time and find the perfect configuration for your use case.

## See Also

- [CardSlide](../card_slide/README.md) - Another hover effect for cards
- [CardHover](../card_hover/README.md) - Simple card overlay effect
- [AnimatedHoverIcons](../animated_icons/README.md) - Icon hover animations

