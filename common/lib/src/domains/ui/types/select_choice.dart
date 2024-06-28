import 'package:flutter/cupertino.dart';

class SelectChoice<T> {
  const SelectChoice({
    required this.value,
    required this.label,
    this.disable = false,
    this.hasWarning = false,
    this.height = 44,
    this.maxLines = 1,
    this.bottomError,
    this.warningButton,
    this.onWarningPressed,
    this.onPressedWhenDisabled,
  });

  final String label;
  final T value;
  final bool disable;
  final bool hasWarning;
  final double height;
  final int maxLines;
  final String? bottomError;
  final Widget? warningButton;
  final VoidCallback? onWarningPressed;
  final VoidCallback? onPressedWhenDisabled;
}
