import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class SelectDialogWidgetInterface<T> implements Widget {
  SelectDialogProps<T> get props;
}

// Props:-----------------------------------------------------------------------
class SelectDialogProps<T> {
  const SelectDialogProps({
    required this.label,
    required this.value,
    required this.choices,
    this.displayedValue,
    this.dialogWidth = 540,
    this.dialogHeight = 592,
    this.disable = false,
    this.nullable = false,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    required this.onChanged,
  });

  final String label;
  final T? value;
  final String? displayedValue;
  final double dialogWidth;
  final double dialogHeight;
  final List<SelectChoice<T>> choices;
  final bool disable;
  final bool nullable;
  final BorderRadius borderRadius;
  final void Function(T) onChanged;
}

// Implementation:--------------------------------------------------------------
class SelectDialog<T> extends StatelessWidget
    implements SelectDialogWidgetInterface<T> {
  const SelectDialog({super.key, required this.props});

  @override
  final SelectDialogProps<T> props;

  @override
  Widget build(BuildContext context) {
    return getIt<RowButtonWidgetInterface>(
      param1: RowButtonProps(
        disable: props.disable,
        borderRadius: props.borderRadius,
        child: Text(
          props.label,
          style: TextStyle(
            color: props.disable ? CupertinoColors.inactiveGray : null,
          ),
        ),
        value: props.displayedValue,
        onPressed: () => _onPressed(context),
      ),
    );
  }

  // General methods:-----------------------------------------------------------
  void _onPressed(context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => getIt<SelectDialogDialogWidgetInterface<T>>(
        param1: SelectDialogDialogProps(
          width: props.dialogWidth,
          height: props.dialogHeight,
          label: props.label,
          value: props.value,
          choices: props.choices,
          nullable: props.nullable,
          onChanged: props.onChanged,
        ),
      ),
    );
  }
}
