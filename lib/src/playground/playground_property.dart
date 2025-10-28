
/// Defines the type of a property to be displayed in the playground.
class EditableProperty<T> {
  final String label;
  final T value;
  final Function(dynamic) onChanged;
  final double? min;
  final double? max;

  EditableProperty({
    required this.label,
    required this.value,
    required this.onChanged,
    this.min,
    this.max,
  });
}
