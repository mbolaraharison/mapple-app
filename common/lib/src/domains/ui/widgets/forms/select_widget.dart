import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class SelectWidgetInterface<T> implements Widget {
  SelectProps<T> get props;
}

// Props:-----------------------------------------------------------------------
class SelectProps<T> {
  const SelectProps({
    this.label,
    this.choices = const [],
    this.value,
    this.loadingValue,
    this.loadingMessage,
    this.nullable = false,
    required this.onChanged,
  });

  final String? label;
  final List<SelectChoice> choices;
  final T? value;
  final T? loadingValue;
  final String? loadingMessage;
  final bool nullable;
  final ValueChanged<T?> onChanged;
}

// Implementation:--------------------------------------------------------------
class Select<T> extends StatelessWidget implements SelectWidgetInterface<T> {
  const Select({super.key, required this.props});

  @override
  final SelectProps<T> props;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    if (props.label != null) {
      children.add(Padding(
        padding: const EdgeInsets.only(left: 14, bottom: 8),
        child: Text(
          props.label!,
          style: const TextStyle(
            fontSize: 17,
            color: MapleCommonColors.greyLighter,
          ),
        ),
      ));
    }

    List<RowButtonItem<T>> items = [];
    for (var element in props.choices) {
      items.add(
        RowButtonItem<T>(
          value: element.value,
          label: element.label,
          disable: element.disable,
          hasWarning: element.hasWarning,
          onWarningPressed: element.onWarningPressed,
          textStyle: TextStyle(
            color: element.disable ? MapleCommonColors.greyLighter : null,
            overflow: TextOverflow.ellipsis,
          ),
          onPressed: () {
            if (props.value == element.value && props.nullable) {
              props.onChanged(null);
              return;
            }
            props.onChanged(element.value);
          },
        ),
      );
    }

    children.add(
      getIt<RowButtonGroupWidgetInterface>(
        param1: RowButtonGroupProps(
          items: items,
          value: props.value,
          loadingValue: props.loadingValue,
          loadingMessage: props.loadingMessage,
        ),
      ),
    );

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
