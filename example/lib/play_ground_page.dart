import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_hover_effects/hover_effects.dart';

typedef WidgetBuilderWithTheme = Widget Function(dynamic theme);

/// A playground page that shows a widget in the center and editable properties on the right side
class PlaygroundPage extends StatefulWidget {
  final PlaygroundTheme initialTheme;
  final WidgetBuilderWithTheme widgetBuilder;
  final String title;

  const PlaygroundPage({
    super.key,
    required this.initialTheme,
    required this.widgetBuilder,
    required this.title,
  });

  @override
  State<PlaygroundPage> createState() => _PlaygroundPageState();
}

class _PlaygroundPageState extends State<PlaygroundPage> {
  late PlaygroundTheme _currentTheme;
  late List<EditableProperty> _properties;

  @override
  void initState() {
    super.initState();
    _currentTheme = widget.initialTheme;
    _updateProperties();
  }

  void _updateTheme(PlaygroundTheme newTheme) {
    setState(() {
      _currentTheme = newTheme;
      _updateProperties();
    });
  }

  void _updateProperties() {
    _properties = _currentTheme.getEditableProperties(_updateTheme);
  }

  /// Generates Flutter code based on the current theme
  String _generateCode() {
    StringBuffer code = StringBuffer();

    // Determine the widget type based on the theme
    if (_currentTheme is HolographicEffectTheme) {
      final theme = _currentTheme as HolographicEffectTheme;
      code.writeln('HolographicCard(');
      code.writeln('  theme: HolographicEffectTheme(');

      if (theme.backgroundColor != const Color(0xFF111111)) {
        code.writeln(
            '    backgroundColor: ${_colorToString(theme.backgroundColor!)},');
      }
      if (theme.shineColor != const Color(0x4D00FFFF)) {
        code.writeln('    shineColor: ${_colorToString(theme.shineColor!)},');
      }
      if (theme.glowColor != const Color(0x8000FFFF)) {
        code.writeln('    glowColor: ${_colorToString(theme.glowColor!)},');
      }
      if (theme.borderRadius != const BorderRadius.all(Radius.circular(15))) {
        code.writeln(
            '    borderRadius: ${_borderRadiusToString(theme.borderRadius!)},');
      }
      if (theme.padding != const EdgeInsets.all(24.0)) {
        code.writeln('    padding: ${_edgeInsetsToString(theme.padding!)},');
      }
      if (theme.elevation != 0.0) {
        code.writeln('    elevation: ${theme.elevation},');
      }
      if (theme.hoverElevation != 0.0) {
        code.writeln('    hoverElevation: ${theme.hoverElevation},');
      }
      if (theme.scaleFactor != 1.05) {
        code.writeln('    scaleFactor: ${theme.scaleFactor},');
      }
      if (theme.animationDuration != const Duration(milliseconds: 500)) {
        code.writeln(
            '    animationDuration: ${_durationToString(theme.animationDuration!)},');
      }
      if (theme.shineDuration != const Duration(milliseconds: 500)) {
        code.writeln(
            '    shineDuration: ${_durationToString(theme.shineDuration!)},');
      }

      code.writeln('  ),');
      code.writeln('  child: const Padding(');
      code.writeln(
          '    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),');
      code.writeln('    child: Text(\'Holographic Effect\'),');
      code.writeln('  ),');
      code.writeln(')');
    } else if (_currentTheme is FlipCardTheme) {
      final theme = _currentTheme as FlipCardTheme;
      code.writeln('FlipCard(');
      code.writeln('  theme: FlipCardTheme(');

      if (theme.borderRadius != const BorderRadius.all(Radius.circular(8))) {
        code.writeln(
            '    borderRadius: ${_borderRadiusToString(theme.borderRadius!)},');
      }
      if (theme.frontBackgroundColor != const Color(0xFF2196F3)) {
        code.writeln(
            '    frontBackgroundColor: ${_colorToString(theme.frontBackgroundColor!)},');
      }
      if (theme.backBackgroundColor != const Color(0xFF4CAF50)) {
        code.writeln(
            '    backBackgroundColor: ${_colorToString(theme.backBackgroundColor!)},');
      }
      if (theme.padding != const EdgeInsets.all(16.0)) {
        code.writeln('    padding: ${_edgeInsetsToString(theme.padding!)},');
      }
      if (theme.width != 300.0) {
        code.writeln('    width: ${theme.width},');
      }
      if (theme.height != 200.0) {
        code.writeln('    height: ${theme.height},');
      }
      if (theme.animationDuration != const Duration(milliseconds: 600)) {
        code.writeln(
            '    animationDuration: ${_durationToString(theme.animationDuration!)},');
      }
      if (theme.perspective != 0.001) {
        code.writeln('    perspective: ${theme.perspective},');
      }

      code.writeln('  ),');
      code.writeln('  front: const Center(');
      code.writeln('    child: Column(');
      code.writeln('      mainAxisAlignment: MainAxisAlignment.center,');
      code.writeln('      children: [');
      code.writeln(
          '        Icon(Icons.credit_card, size: 48, color: Colors.white),');
      code.writeln('        SizedBox(height: 16),');
      code.writeln('        Text(\'Front Side\'),');
      code.writeln('      ],');
      code.writeln('    ),');
      code.writeln('  ),');
      code.writeln('  back: const Center(');
      code.writeln('    child: Column(');
      code.writeln('      mainAxisAlignment: MainAxisAlignment.center,');
      code.writeln('      children: [');
      code.writeln(
          '        Icon(Icons.info_outline, size: 48, color: Colors.white),');
      code.writeln('        SizedBox(height: 16),');
      code.writeln('        Text(\'Back Side\'),');
      code.writeln('      ],');
      code.writeln('    ),');
      code.writeln('  ),');
      code.writeln(')');
    } else if (_currentTheme is CardFaceTheme) {
      final theme = _currentTheme as CardFaceTheme;
      code.writeln('CardFace(');
      code.writeln('  theme: CardFaceTheme(');
      if (theme.width != 300.0) {
        code.writeln('    width: ${theme.width},');
      }
      if (theme.height != 400.0) {
        code.writeln('    height: ${theme.height},');
      }
      if (theme.borderRadius != const BorderRadius.all(Radius.circular(15))) {
        code.writeln(
            '    borderRadius: ${_borderRadiusToString(theme.borderRadius)},');
      }
      if (theme.shrunkenHeight != 60.0) {
        code.writeln('    shrunkenHeight: ${theme.shrunkenHeight},');
      }
      if (theme.shadow !=
          const BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.5),
            blurRadius: 60,
            spreadRadius: 0,
            offset: Offset(0, 15),
          )) {
        code.writeln(
            '    shadow: BoxShadow(color: ${_colorToString(theme.shadow.color)}, blurRadius: ${theme.shadow.blurRadius}, spreadRadius: ${theme.shadow.spreadRadius}, offset: Offset(${theme.shadow.offset.dx}, ${theme.shadow.offset.dy})),');
      }
      if (theme.animationDuration != const Duration(milliseconds: 500)) {
        code.writeln(
            '    animationDuration: ${_durationToString(theme.animationDuration)},');
      }
      if (theme.animationCurve != Curves.easeInOut) {
        code.writeln(
            '    animationCurve: ${_curveToString(theme.animationCurve)},');
      }
      code.writeln('  ),');
      code.writeln('  bottomFace: const Center(');
      code.writeln('    child: Column(');
      code.writeln('      mainAxisAlignment: MainAxisAlignment.center,');
      code.writeln('      children: [');
      code.writeln(
          '        Icon(Icons.description, size: 40, color: Colors.black87),');
      code.writeln('        SizedBox(height: 12),');
      code.writeln(
          '        Text(\'Details go here\', style: TextStyle(color: Colors.black87)),');
      code.writeln('      ],');
      code.writeln('    ),');
      code.writeln('  ),');
      code.writeln('  topFace: const Text(');
      code.writeln('    \'Summary\',');
      code.writeln('    style: TextStyle(');
      code.writeln('      color: Colors.white,');
      code.writeln('      fontSize: 20,');
      code.writeln('      fontWeight: FontWeight.w600,');
      code.writeln('    ),');
      code.writeln('  ),');
      code.writeln('  topFaceDecoration: const BoxDecoration(');
      code.writeln('    gradient: LinearGradient(');
      code.writeln('      colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],');
      code.writeln('      begin: Alignment.topLeft,');
      code.writeln('      end: Alignment.bottomRight,');
      code.writeln('    ),');
      code.writeln('  ),');
      code.writeln(')');
    } else if (_currentTheme is CardSlideTheme) {
      final theme = _currentTheme as CardSlideTheme;
      code.writeln('CardSlide(');
      code.writeln('  theme: CardSlideTheme(');
      if (theme.backgroundColor != Colors.white) {
        code.writeln(
            '    backgroundColor: ${_colorToString(theme.backgroundColor!)},');
      }
      if (theme.iconBackgroundColor != const Color(0xFF2c73df)) {
        code.writeln(
            '    iconBackgroundColor: ${_colorToString(theme.iconBackgroundColor!)},');
      }
      if (theme.borderRadius != const BorderRadius.all(Radius.circular(12))) {
        code.writeln(
            '    borderRadius: ${_borderRadiusToString(theme.borderRadius!)},');
      }
      if (theme.padding != const EdgeInsets.all(20.0)) {
        code.writeln('    padding: ${_edgeInsetsToString(theme.padding!)},');
      }
      if (theme.cardWidth != 400.0) {
        code.writeln('    cardWidth: ${theme.cardWidth},');
      }
      if (theme.cardHeight != 250.0) {
        code.writeln('    cardHeight: ${theme.cardHeight},');
      }
      if (theme.animationDuration != const Duration(milliseconds: 500)) {
        code.writeln(
            '    animationDuration: ${_durationToString(theme.animationDuration!)},');
      }
      if (theme.animationCurve != Curves.easeOut) {
        code.writeln(
            '    animationCurve: ${_curveToString(theme.animationCurve!)},');
      }
      code.writeln('  ),');
      code.writeln('  icon: const Icon(');
      code.writeln('    Icons.person,');
      code.writeln('    size: 80,');
      code.writeln('    color: Colors.white,');
      code.writeln('  ),');
      code.writeln('  title: \'Hello there!\',');
      code.writeln('  subtitle: \'Trust yourself and keep going.\',');
      code.writeln(')');
    } else if (_currentTheme is CardHoverTheme) {
      final theme = _currentTheme as CardHoverTheme;
      code.writeln('CardHover(');
      code.writeln('  theme: CardHoverTheme(');
      if (theme.width != 250.0) {
        code.writeln('    width: ${theme.width},');
      }
      if (theme.height != 370.0) {
        code.writeln('    height: ${theme.height},');
      }
      if (theme.imageHeight != 235.0) {
        code.writeln('    imageHeight: ${theme.imageHeight},');
      }
      if (theme.borderRadius != const BorderRadius.all(Radius.circular(12))) {
        code.writeln(
            '    borderRadius: ${_borderRadiusToString(theme.borderRadius)},');
      }
      if (theme.overlayColor != Colors.white) {
        code.writeln(
            '    overlayColor: ${_colorToString(theme.overlayColor)},');
      }
      if (theme.overlayOpacity != 0.3) {
        code.writeln('    overlayOpacity: ${theme.overlayOpacity},');
      }
      if (theme.animationDuration != const Duration(milliseconds: 300)) {
        code.writeln(
            '    animationDuration: Duration(milliseconds: ${theme.animationDuration.inMilliseconds}),');
      }
      if (theme.animationCurve != Curves.easeOut) {
        code.writeln(
            '    animationCurve: ${_curveToString(theme.animationCurve)},');
      }
      code.writeln('  ),');
      code.writeln('  image: NetworkImage(\'https://example.com/image.jpg\'),');
      code.writeln('  category: \'Recipe\',');
      code.writeln('  title: \'Crisp Spanish tortilla Matzo brei\',');
      code.writeln('  author: \'Celeste Mills\',');
      code.writeln('  timeText: \'15 min\',');
      code.writeln('  onAuthorTap: () {},');
      code.writeln('  onLikeTap: () {},');
      code.writeln(')');
    } else if (_currentTheme is AnimatedNavMenuTheme) {
      final theme = _currentTheme as AnimatedNavMenuTheme;
      code.writeln('AnimatedNavMenu(');
      code.writeln('  theme: AnimatedNavMenuTheme(');
      if (theme.itemSize != 60.0) {
        code.writeln('    itemSize: ${theme.itemSize},');
      }
      if (theme.itemHoverWidth != 180.0) {
        code.writeln('    itemHoverWidth: ${theme.itemHoverWidth},');
      }
      if (theme.spacing != 25.0) {
        code.writeln('    spacing: ${theme.spacing},');
      }
      if (theme.animationDuration != const Duration(milliseconds: 500)) {
        code.writeln(
            '    animationDuration: Duration(milliseconds: ${theme.animationDuration.inMilliseconds}),');
      }
      if (theme.animationCurve != Curves.easeOut) {
        code.writeln(
            '    animationCurve: ${_curveToString(theme.animationCurve)},');
      }
      if (theme.iconColor != const Color(0xFF777777)) {
        code.writeln('    iconColor: ${_colorToString(theme.iconColor)},');
      }
      if (theme.textColor != Colors.white) {
        code.writeln('    textColor: ${_colorToString(theme.textColor)},');
      }
      code.writeln('  ),');
      code.writeln('  items: [');
      code.writeln('    AnimatedNavMenuItem(');
      code.writeln('      icon: Icons.home,');
      code.writeln('      title: \'Home\',');
      code.writeln('      hoverGradient: LinearGradient(');
      code.writeln('        colors: [Color(0xFF667eea), Color(0xFF764ba2)],');
      code.writeln('      ),');
      code.writeln('      onTap: () {},');
      code.writeln('    ),');
      code.writeln('    AnimatedNavMenuItem(');
      code.writeln('      icon: Icons.search,');
      code.writeln('      title: \'Search\',');
      code.writeln('      hoverGradient: LinearGradient(');
      code.writeln('        colors: [Color(0xFFf093fb), Color(0xFFf5576c)],');
      code.writeln('      ),');
      code.writeln('      onTap: () {},');
      code.writeln('    ),');
      code.writeln('  ],');
      code.writeln(')');
    } else if (_currentTheme is SlidingNavMenuTheme) {
      final theme = _currentTheme as SlidingNavMenuTheme;
      code.writeln('SlidingNavMenu(');
      code.writeln('  theme: SlidingNavMenuTheme(');
      if (theme.itemHeight != 60.0) {
        code.writeln('    itemHeight: ${theme.itemHeight},');
      }
      if (theme.peekSize != 0.0) {
        code.writeln('    peekSize: ${theme.peekSize},');
      }
      if (theme.animationDuration != const Duration(milliseconds: 300)) {
        code.writeln(
            '    animationDuration: Duration(milliseconds: ${theme.animationDuration.inMilliseconds}),');
      }
      if (theme.animationCurve != Curves.easeOut) {
        code.writeln(
            '    animationCurve: ${_curveToString(theme.animationCurve)},');
      }
      if (theme.fillDirection != FillDirection.leftToRight) {
        code.writeln(
            '    fillDirection: FillDirection.${theme.fillDirection.name},');
      }
      code.writeln('  ),');
      code.writeln('  items: [');
      code.writeln('    SlidingNavMenuItem(');
      code.writeln('      title: \'Dashboard\',');
      code.writeln('      highlightColor: Color(0xFF6366F1),');
      code.writeln('      onTap: () {},');
      code.writeln('    ),');
      code.writeln('    SlidingNavMenuItem(');
      code.writeln('      title: \'Analytics\',');
      code.writeln('      highlightColor: Color(0xFF10B981),');
      code.writeln('      onTap: () {},');
      code.writeln('    ),');
      code.writeln('    SlidingNavMenuItem(');
      code.writeln('      title: \'Projects\',');
      code.writeln('      highlightColor: Color(0xFFF59E0B),');
      code.writeln('      onTap: () {},');
      code.writeln('    ),');
      code.writeln('  ],');
      code.writeln(')');
    } else if (_currentTheme is AnimatedFillIconTheme) {
      final theme = _currentTheme as AnimatedFillIconTheme;
      code.writeln('AnimatedFillIcon(');
      code.writeln('  theme: AnimatedFillIconTheme(');
      if (theme.backgroundColor != const Color(0xFF262626)) {
        code.writeln(
            '    backgroundColor: ${_colorToString(theme.backgroundColor)},');
      }
      if (theme.iconSize != 80.0) {
        code.writeln('    iconSize: ${theme.iconSize},');
      }
      if (theme.spacing != 10.0) {
        code.writeln('    spacing: ${theme.spacing},');
      }
      if (theme.iconBackgroundColor != Colors.white) {
        code.writeln(
            '    iconBackgroundColor: ${_colorToString(theme.iconBackgroundColor)},');
      }
      if (theme.iconColor != const Color(0xFF262626)) {
        code.writeln('    iconColor: ${_colorToString(theme.iconColor)},');
      }
      if (theme.borderColor != Colors.white) {
        code.writeln('    borderColor: ${_colorToString(theme.borderColor)},');
      }
      if (theme.borderWidth != 3.0) {
        code.writeln('    borderWidth: ${theme.borderWidth},');
      }
      if (theme.hoverScale != 1.1) {
        code.writeln('    hoverScale: ${theme.hoverScale},');
      }
      if (theme.hoverTranslateY != -10.0) {
        code.writeln('    hoverTranslateY: ${theme.hoverTranslateY},');
      }
      if (theme.animationDuration != const Duration(milliseconds: 500)) {
        code.writeln(
            '    animationDuration: Duration(milliseconds: ${theme.animationDuration.inMilliseconds}),');
      }
      if (theme.animationCurve != Curves.ease) {
        code.writeln(
            '    animationCurve: ${_curveToString(theme.animationCurve)},');
      }
      if (theme.fillDirection != FillDirection.bottomToTop) {
        code.writeln(
            '    fillDirection: FillDirection.${theme.fillDirection.name},');
      }
      code.writeln('  ),');
      code.writeln('  icons: [');
      code.writeln('    AnimatedFillIconItem(');
      code.writeln('      icon: Icons.facebook,');
      code.writeln('      hoverColor: Color(0xFF3b5999),');
      code.writeln('      tooltip: \'Facebook\',');
      code.writeln('    ),');
      code.writeln('    AnimatedFillIconItem(');
      code.writeln('      icon: Icons.alternate_email,');
      code.writeln('      hoverColor: Color(0xFF55acee),');
      code.writeln('      tooltip: \'Twitter\',');
      code.writeln('    ),');
      code.writeln('    AnimatedFillIconItem(');
      code.writeln('      icon: Icons.work,');
      code.writeln('      hoverColor: Color(0xFF0077b5),');
      code.writeln('      tooltip: \'LinkedIn\',');
      code.writeln('    ),');
      code.writeln('    AnimatedFillIconItem(');
      code.writeln('      icon: Icons.email,');
      code.writeln('      hoverColor: Color(0xFFdd4b39),');
      code.writeln('      tooltip: \'Gmail\',');
      code.writeln('    ),');
      code.writeln('  ],');
      code.writeln(')');
    } else {
      // Fallback for unknown theme types
      return '// Unknown theme type: ${_currentTheme.runtimeType}';
    }

    return code.toString();
  }

  /// Converts Color to string representation
  String _colorToString(Color color) {
    final argb = color.toARGB32();
    return 'Color(0x${argb.toRadixString(16).padLeft(8, '0').toUpperCase()})';
  }

  /// Converts BorderRadius to string representation
  String _borderRadiusToString(BorderRadius borderRadius) {
    final radius = borderRadius.topLeft.x;
    return 'BorderRadius.circular(${radius.toStringAsFixed(1)})';
  }

  /// Converts EdgeInsets to string representation
  String _edgeInsetsToString(EdgeInsets padding) {
    if (padding.left == padding.right &&
        padding.top == padding.bottom &&
        padding.left == padding.top) {
      return 'EdgeInsets.all(${padding.left.toStringAsFixed(1)})';
    }
    return 'EdgeInsets.fromLTRB(${padding.left.toStringAsFixed(1)}, ${padding.top.toStringAsFixed(1)}, ${padding.right.toStringAsFixed(1)}, ${padding.bottom.toStringAsFixed(1)})';
  }

  /// Converts Duration to string representation
  String _durationToString(Duration duration) {
    return 'Duration(milliseconds: ${duration.inMilliseconds})';
  }

  /// Converts Curve to string representation
  String _curveToString(Curve curve) {
    if (curve == Curves.easeInOut) return 'Curves.easeInOut';
    if (curve == Curves.easeIn) return 'Curves.easeIn';
    if (curve == Curves.easeOut) return 'Curves.easeOut';
    if (curve == Curves.linear) return 'Curves.linear';
    if (curve == Curves.fastOutSlowIn) return 'Curves.fastOutSlowIn';
    if (curve == Curves.bounceIn) return 'Curves.bounceIn';
    if (curve == Curves.bounceOut) return 'Curves.bounceOut';
    if (curve == Curves.elasticIn) return 'Curves.elasticIn';
    if (curve == Curves.elasticOut) return 'Curves.elasticOut';
    return 'Curves.easeInOut';
  }

  /// Converts string to Curve
  Curve _getCurveFromString(String curveName) {
    switch (curveName) {
      case 'easeInOut':
        return Curves.easeInOut;
      case 'easeIn':
        return Curves.easeIn;
      case 'easeOut':
        return Curves.easeOut;
      case 'linear':
        return Curves.linear;
      case 'fastOutSlowIn':
        return Curves.fastOutSlowIn;
      case 'bounceIn':
        return Curves.bounceIn;
      case 'bounceOut':
        return Curves.bounceOut;
      case 'elasticIn':
        return Curves.elasticIn;
      case 'elasticOut':
        return Curves.elasticOut;
      default:
        return Curves.easeOut;
    }
  }

  /// Converts curve toString() to display name for dropdown
  String _getCurveDisplayName(String curveString) {
    if (curveString.contains('easeInOut')) return 'easeInOut';
    if (curveString.contains('easeIn')) return 'easeIn';
    if (curveString.contains('easeOut')) return 'easeOut';
    if (curveString.contains('linear')) return 'linear';
    if (curveString.contains('fastOutSlowIn')) return 'fastOutSlowIn';
    if (curveString.contains('bounceIn')) return 'bounceIn';
    if (curveString.contains('bounceOut')) return 'bounceOut';
    if (curveString.contains('elasticIn')) return 'elasticIn';
    if (curveString.contains('elasticOut')) return 'elasticOut';
    return 'easeOut'; // default
  }

  /// Copies the generated code to clipboard
  void _copyCodeToClipboard(BuildContext context) {
    final code = _generateCode();
    Clipboard.setData(ClipboardData(text: code));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Code copied to clipboard!'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Row(
        children: [
          // Code panel - shows generated Flutter code
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey.shade900,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade700),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.code, color: Colors.grey.shade300),
                        const SizedBox(width: 8),
                        Text(
                          'Generated Code',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade200,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: Icon(Icons.copy, color: Colors.grey.shade300),
                          onPressed: () => _copyCodeToClipboard(context),
                          tooltip: 'Copy code to clipboard',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: SelectableText(
                          _generateCode(),
                          style: const TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 12,
                            color: Colors.greenAccent,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Main content area - shows the widget
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.grey.shade50,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(32.0),
                  child: widget.widgetBuilder(_currentTheme),
                ),
              ),
            ),
          ),
          // Properties panel
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.tune, color: Colors.grey.shade600),
                        const SizedBox(width: 8),
                        Text(
                          'Properties',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: _properties.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        return _buildControlForProperty(
                            context, _properties[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// This method handles building controls for different property types
  Widget _buildControlForProperty(
      BuildContext context, EditableProperty property) {
    final value = property.value;

    // Handle Color properties
    if (value is Color?) {
      return _buildColorControl(context, property, value);
    }

    // Handle double properties
    if (value is double?) {
      return _buildSliderControl(property, value);
    }

    // Handle BorderRadius properties
    if (value is BorderRadius?) {
      return _buildBorderRadiusControl(property, value);
    }

    // Handle EdgeInsets properties
    if (value is EdgeInsets?) {
      return _buildEdgeInsetsControl(property, value);
    }

    // Handle Duration properties
    if (value is Duration?) {
      return _buildDurationControl(property, value);
    }

    // Handle String properties (for dropdowns)
    if (value is String) {
      return _buildDropdownControl(property, value);
    }

    // Fallback for any unsupported types
    return _buildFallbackControl(property);
  }

  // --- Helper methods for building controls ---

  Widget _buildColorControl(
      BuildContext context, EditableProperty property, Color? color) {
    final currentColor = color ?? Colors.blue;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(property.label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black87,
              )),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _showColorPicker(context, property, currentColor),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: currentColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Center(
              child: Text(
                'Tap to change',
                style: TextStyle(
                  color: currentColor.computeLuminance() > 0.5
                      ? Colors.black
                      : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSliderControl(EditableProperty property, double? value) {
    final currentValue = value ?? 0.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text('${property.label}: ${currentValue.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black87,
              )),
        ),
        Slider(
          value: currentValue,
          min: property.label == 'Scale Factor'
              ? 1.0
              : (property.label == 'Elevation' ||
                      property.label == 'Hover Elevation'
                  ? 0.0
                  : property.min ?? 0.0),
          max: property.label == 'Scale Factor'
              ? 2.0
              : (property.label == 'Elevation' ||
                      property.label == 'Hover Elevation'
                  ? 20.0
                  : property.max ?? 100.0),
          onChanged: (newValue) {
            // Create a wrapper function to handle the type conversion
            final callback = property.onChanged;
            callback(newValue);
          },
        ),
      ],
    );
  }

  Widget _buildBorderRadiusControl(
      EditableProperty property, BorderRadius? radius) {
    final currentValue = radius?.topLeft.x ?? 0.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text('${property.label}: ${currentValue.toStringAsFixed(1)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black87,
              )),
        ),
        Slider(
          value: currentValue,
          min: 0.0,
          max: 50.0,
          onChanged: (newValue) {
            // Create a wrapper function to handle the type conversion
            final callback = property.onChanged;
            final newBorderRadius = BorderRadius.circular(newValue);
            callback(newBorderRadius);
          },
        ),
      ],
    );
  }

  Widget _buildEdgeInsetsControl(
      EditableProperty property, EdgeInsets? padding) {
    final currentValue = padding?.left ?? 0.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text('${property.label}: ${currentValue.toStringAsFixed(1)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black87,
              )),
        ),
        Slider(
          value: currentValue,
          min: 0.0,
          max: 50.0,
          onChanged: (newValue) {
            // Create a wrapper function to handle the type conversion
            final callback = property.onChanged;
            final newEdgeInsets = EdgeInsets.all(newValue);
            callback(newEdgeInsets);
          },
        ),
      ],
    );
  }

  Widget _buildDurationControl(EditableProperty property, Duration? duration) {
    final currentValue = duration?.inMilliseconds.toDouble() ?? 500.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
              '${property.label}: ${(currentValue / 1000).toStringAsFixed(1)}s',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black87,
              )),
        ),
        Slider(
          value: currentValue,
          min: 100,
          max: 5000,
          divisions: 49,
          onChanged: (newValue) {
            // Create a wrapper function to handle the type conversion
            final callback = property.onChanged;
            final newDuration = Duration(milliseconds: newValue.toInt());
            callback(newDuration);
          },
        ),
      ],
    );
  }

  Widget _buildDropdownControl(EditableProperty property, String currentValue) {
    // Determine options based on property label
    List<String> options;
    if (property.label == 'Fill Direction') {
      options = [
        'Left to Right',
        'Right to Left',
        'Top to Bottom',
        'Bottom to Top',
        'Center Horizontal',
        'Center Vertical',
      ];
    } else if (property.label == 'Animation Curve') {
      options = [
        'easeInOut',
        'easeIn',
        'easeOut',
        'linear',
        'fastOutSlowIn',
        'bounceIn',
        'bounceOut',
        'elasticIn',
        'elasticOut',
      ];
      // Convert curve toString() to readable name
      currentValue = _getCurveDisplayName(currentValue);
    } else {
      // Default curve options
      options = [
        'easeInOut',
        'easeIn',
        'easeOut',
        'linear',
        'fastOutSlowIn',
        'bounceIn',
        'bounceOut',
        'elasticIn',
        'elasticOut',
      ];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text('${property.label}: $currentValue',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black87,
              )),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: DropdownButton<String>(
            value: currentValue,
            isExpanded: true,
            underline: const SizedBox(),
            items: options.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                final callback = property.onChanged;
                callback(newValue);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFallbackControl(EditableProperty property) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        '${property.label}: Unsupported type',
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }

  void _showColorPicker(
      BuildContext context, EditableProperty property, Color currentColor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select ${property.label}'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: (Color color) {
                // Create a wrapper function to handle the type conversion
                final callback = property.onChanged;
                callback(color);
              },
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
