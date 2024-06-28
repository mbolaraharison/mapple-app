import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class MultiSelectWidgetInterface implements Widget {
  MultiSelectProps get props;
}

// Props:-----------------------------------------------------------------------
class MultiSelectProps {
  const MultiSelectProps({
    this.label,
    this.choices = const [],
    this.values = const [],
    this.onChanged,
    this.onSelect,
    this.limit,
  });

  final String? label;
  final List<SelectChoice> choices;
  final List<String> values;
  final ValueChanged<List<String>>? onChanged;
  final ValueChanged<String>? onSelect;
  final int? limit;
}

// Implementation:--------------------------------------------------------------
class MultiSelect extends StatelessWidget
    implements MultiSelectWidgetInterface {
  const MultiSelect({
    super.key,
    MultiSelectProps? props,
  }) : props = props ?? const MultiSelectProps();

  @override
  final MultiSelectProps props;

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

    List<RowButtonItem> items = [];
    for (var element in props.choices) {
      String computedLabel = element.label;
      if (element.bottomError != null && element.bottomError != '') {
        computedLabel = '$computedLabel\n${element.bottomError}';
      }
      items.add(
        RowButtonItem(
          value: element.value,
          label: computedLabel,
          height: element.height,
          disable: element.disable,
          hasWarning: element.hasWarning,
          maxLines: element.maxLines,
          warningButton: element.warningButton,
          onWarningPressed: element.onWarningPressed,
          onPressedWhenDisabled: element.onPressedWhenDisabled,
          textStyle: TextStyle(
            color: element.disable ? MapleCommonColors.greyLighter : null,
            overflow: TextOverflow.ellipsis,
          ),
          onPressed: () {
            List<String> newValues = props.values;
            if (newValues.contains(element.value)) {
              newValues.remove(element.value);
            } else {
              if (props.limit == null || newValues.length < props.limit!) {
                newValues.add(element.value);
              }
            }

            if (props.onChanged != null) {
              props.onChanged!(newValues);
            }
            if (props.onSelect != null) {
              props.onSelect!(element.value);
            }
          },
        ),
      );
    }

    children.add(
      getIt<RowButtonMultiChoicesGroupWidgetInterface>(
        param1: RowButtonMultiChoicesGroupProps(
          items: items,
          values: props.values,
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
