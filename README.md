# Flutter Hover Effects

A comprehensive Flutter package providing beautiful hover effects and animations for web and desktop applications.

## Features

- 🎨 **Holographic Effects** - Stunning holographic animations with shimmer effects
- 📱 **Social Media Icons** - Animated social media icons with brand colors
- 🔘 **3D Buttons** - Realistic 3D buttons with depth and shadow effects
- 🎯 **Customizable** - Highly configurable with custom colors, durations, and curves
- 🌐 **Web & Desktop** - Optimized for Flutter web and desktop platforms
- 📦 **Easy to Use** - Simple API with sensible defaults

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  fl_hover: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Quick Start

```dart
import 'package:fl_hover/flutter_hover_effects.dart';

// Holographic Effect
HolographicEffect(
  child: Container(
    width: 200,
    height: 100,
    child: Text('Hover me!'),
  ),
)

// Social Media Icons
SocialIconsRow(
  icons: [
    SocialConfigs.facebook,
    SocialConfigs.twitter,
    SocialConfigs.instagram,
  ],
  onIconTap: (platform) => print('Tapped $platform'),
)

// 3D Buttons
Buttons3DRow(
  buttons: [
    Button3DConfig(text: "Click me", colors: Button3DColors.green),
    Button3DConfig(text: "Or me", colors: Button3DColors.blue),
  ],
)
```

## Available Effects

### Holographic Effect

Creates a stunning holographic appearance with animated gradients and shimmer effects.

```dart
HolographicEffect(
  child: YourWidget(),
  config: HoverConfig(
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  ),
  intensity: 0.8,
  customColors: [Colors.cyan, Colors.magenta, Colors.green],
)
```

### Social Media Icons

Animated social media icons with brand colors and hover effects.

```dart
SocialIcon(
  config: SocialConfigs.facebook,
  size: 60.0,
  onTap: () => print('Facebook tapped'),
)

// Or use a row of icons
SocialIconsRow(
  icons: [
    SocialConfigs.facebook,
    SocialConfigs.twitter,
    SocialConfigs.instagram,
    SocialConfigs.linkedin,
  ],
)
```

### 3D Buttons

Realistic 3D buttons with depth, shadows, and press animations.

```dart
Button3D(
  text: "Click Me",
  onPressed: () => print('Button pressed'),
  colors: Button3DColors.green,
  size: Button3DSize.medium,
)

// Or use a row of buttons
Buttons3DRow(
  buttons: [
    Button3DConfig(text: "Option 1", colors: Button3DColors.green),
    Button3DConfig(text: "Option 2", colors: Button3DColors.blue),
  ],
)
```

## Configuration

### HoverConfig

Configure the behavior of hover effects:

```dart
HoverConfig(
  duration: Duration(milliseconds: 300),  // Animation duration
  curve: Curves.easeInOut,                // Animation curve
  enabled: true,                          // Enable/disable effects
  colors: {'primary': Colors.blue},       // Custom colors
  dimensions: {'size': 100.0},           // Custom dimensions
)
```

### Color Schemes

Predefined color schemes are available:

```dart
// Social Media Colors
SocialConfigs.facebook  // Facebook blue
SocialConfigs.twitter   // Twitter blue
SocialConfigs.instagram // Instagram gradient
SocialConfigs.linkedin  // LinkedIn blue

// 3D Button Colors
Button3DColors.green    // Green theme
Button3DColors.blue     // Blue theme
Button3DColors.red      // Red theme
Button3DColors.purple   // Purple theme
```

## Platform Support

This package is designed for:
- ✅ Flutter Web
- ✅ Flutter Desktop (Windows, macOS, Linux)
- ❌ Flutter Mobile (hover not applicable)

## Examples

Check out the `example/` directory for a complete demo application showcasing all available effects.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

Inspired by modern web design trends and CSS hover effects, adapted for Flutter's web and desktop platforms.
