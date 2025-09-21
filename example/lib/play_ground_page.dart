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
    final theme = _currentTheme as HolographicEffectTheme;

    StringBuffer code = StringBuffer();
    code.writeln('HolographicCard(');

    // Add theme properties
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
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: _properties.isEmpty
                        ? const Center(
                            child: Text(
                              'No properties available',
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.all(16.0),
                            itemCount: _properties.length,
                            itemBuilder: (context, index) {
                              return _buildControlForProperty(
                                  context, _properties[index]);
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(height: 24),
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
  /// Uses a more flexible approach that doesn't require type casting
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

    // Fallback for any unsupported types
    return _buildFallbackControl(property);
  }

  // --- Helper methods for building controls ---

  Widget _buildColorControl(
      BuildContext context, EditableProperty property, Color? color) {
    final currentColor = color ?? Colors.transparent;
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
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: currentColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
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
          onChanged: property.onChanged,
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
          min: 0,
          max: 50,
          onChanged: (newValue) {
            property.onChanged(BorderRadius.circular(newValue));
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
          min: 0,
          max: 100,
          onChanged: (newValue) {
            property.onChanged(EdgeInsets.all(newValue));
          },
        ),
      ],
    );
  }

  Widget _buildDurationControl(EditableProperty property, Duration? duration) {
    final currentValue = (duration?.inMilliseconds ?? 0).toDouble();
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
            property.onChanged(Duration(milliseconds: newValue.toInt()));
          },
        ),
      ],
    );
  }

  Widget _buildFallbackControl(EditableProperty property) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Unsupported Property',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red.shade700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Type: ${property.value.runtimeType}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.red.shade600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Label: ${property.label}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.red.shade600,
            ),
          ),
        ],
      ),
    );
  }

  void _showColorPicker(
      BuildContext context, EditableProperty property, Color currentColor) {
    showDialog(
      context: context,
      builder: (context) {
        Color pickerColor = currentColor;
        return AlertDialog(
          title: Text('Select ${property.label}'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: (color) => pickerColor = color,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                property.onChanged(pickerColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

/// A reusable widget that shows a widget with editable properties
/// This can be used as a standalone widget for simpler use cases
class PlaygroundWidget extends StatelessWidget {
  final Widget child;
  final List<EditableProperty> properties;

  const PlaygroundWidget({
    super.key,
    required this.child,
    required this.properties,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Center(child: child),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.white,
            child: ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: properties.length,
              itemBuilder: (context, index) {
                return _buildControlForProperty(context, properties[index]);
              },
              separatorBuilder: (context, index) => const Divider(height: 24),
            ),
          ),
        ),
      ],
    );
  }

  /// This method handles building controls for different property types
  /// Uses a more flexible approach that doesn't require type casting
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

    // Fallback for any unsupported types
    return _buildFallbackControl(property);
  }

  // --- Helper methods for building controls ---

  Widget _buildColorControl(
      BuildContext context, EditableProperty property, Color? color) {
    final currentColor = color ?? Colors.transparent;
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
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: currentColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
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
          onChanged: property.onChanged,
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
          min: 0,
          max: 50,
          onChanged: (newValue) {
            property.onChanged(BorderRadius.circular(newValue));
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
          min: 0,
          max: 100,
          onChanged: (newValue) {
            property.onChanged(EdgeInsets.all(newValue));
          },
        ),
      ],
    );
  }

  Widget _buildDurationControl(EditableProperty property, Duration? duration) {
    final currentValue = (duration?.inMilliseconds ?? 0).toDouble();
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
            property.onChanged(Duration(milliseconds: newValue.toInt()));
          },
        ),
      ],
    );
  }

  Widget _buildFallbackControl(EditableProperty property) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Unsupported Property',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red.shade700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Type: ${property.value.runtimeType}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.red.shade600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Label: ${property.label}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.red.shade600,
            ),
          ),
        ],
      ),
    );
  }

  void _showColorPicker(
      BuildContext context, EditableProperty property, Color currentColor) {
    showDialog(
      context: context,
      builder: (context) {
        Color pickerColor = currentColor;
        return AlertDialog(
          title: Text('Select ${property.label}'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: (color) => pickerColor = color,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                property.onChanged(pickerColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
