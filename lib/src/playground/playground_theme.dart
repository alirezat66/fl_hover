import 'package:flutter_hover_effects/hover_effects.dart';

/// The abstract "contract" that any theme must implement to be editable
/// in the playground.
///
/// By defining this within `lib`, our themes can implement it without creating
/// a forbidden dependency on the `example` directory.
abstract class PlaygroundTheme {
  /// Returns a list of UI-ready property editors for the playground.
  /// The theme itself is responsible for creating these and managing its own
  /// state update by calling `onUpdate` with a new instance of itself.
  List<EditableProperty> getEditableProperties(
    void Function(PlaygroundTheme newTheme) onUpdate,
  );
}
