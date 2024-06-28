import 'package:flutter/cupertino.dart';

class RowButtonItem<T> {
  RowButtonItem({
    required this.label,
    this.onPressed,
    this.value,
    this.textStyle,
    this.disable = false,
    this.hasWarning = false,
    this.height = 44,
    this.maxLines = 1,
    this.warningButton,
    this.onWarningPressed,
    this.onPressedWhenDisabled,
  });
  final String label;
  final VoidCallback? onPressed;
  final T? value;
  final TextStyle? textStyle;
  final bool disable;
  final bool hasWarning;
  final double height;
  final int maxLines;
  final Widget? warningButton;
  final VoidCallback? onWarningPressed;
  final VoidCallback? onPressedWhenDisabled;
}
