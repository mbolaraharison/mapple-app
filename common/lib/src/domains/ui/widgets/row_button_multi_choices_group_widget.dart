import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class RowButtonMultiChoicesGroupWidgetInterface implements Widget {
  RowButtonMultiChoicesGroupProps get props;
}

// Props:-----------------------------------------------------------------------
class RowButtonMultiChoicesGroupProps {
  const RowButtonMultiChoicesGroupProps({
    required this.items,
    this.values = const [],
    this.borderRadius = BorderRadius.zero,
  });

  final List<RowButtonItem> items;
  final List<String> values;
  final BorderRadius borderRadius;
}

// Implementation:--------------------------------------------------------------
class RowButtonMultiChoicesGroup extends StatelessWidget
    implements RowButtonMultiChoicesGroupWidgetInterface {
  const RowButtonMultiChoicesGroup({super.key, required this.props});

  @override
  final RowButtonMultiChoicesGroupProps props;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    props.items.asMap().forEach((index, element) {
      children.add(
        getIt<RowButtonWidgetInterface>(
          param1: RowButtonProps(
            height: element.height,
            disable: element.disable,
            child: Text(
              maxLines: element.maxLines,
              element.label,
              style: element.textStyle,
            ),
            rightChild: props.values.contains(element.value) && !element.disable
                ? const Icon(CupertinoIcons.checkmark_alt)
                : (element.hasWarning
                    ? element.warningButton ??
                        CupertinoButton(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.zero,
                          onPressed: element.onWarningPressed,
                          child: const Icon(
                            CupertinoIcons.exclamationmark_circle,
                            color: CupertinoColors.destructiveRed,
                          ),
                        )
                    : const SizedBox()),
            onPressed: element.onPressed,
            onPressedWhenDisabled: element.onPressedWhenDisabled,
          ),
        ),
      );

      if (index != props.items.length - 1) {
        children.add(Container(
          padding: const EdgeInsets.only(left: 15),
          child: getIt<SeparatorWidgetInterface>(),
        ));
      }
    });

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: props.borderRadius,
      ),
      child: Column(
        children: children,
      ),
    );
  }
}
