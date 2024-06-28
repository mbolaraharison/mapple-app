class PickerChoice<T> {
  const PickerChoice({
    required this.value,
    required this.label,
  });

  final String label;
  final T value;
}
