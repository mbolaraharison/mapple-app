import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class RowButtonGroupWidgetInterface<T> implements Widget {
  RowButtonGroupProps<T> get props;
}

// Props:-----------------------------------------------------------------------
class RowButtonGroupProps<T> {
  const RowButtonGroupProps({
    required this.items,
    this.value,
    this.loadingValue,
    this.loadingMessage,
    this.borderRadius = BorderRadius.zero,
  });

  final List<RowButtonItem> items;
  final T? value;
  final BorderRadius borderRadius;
  final T? loadingValue;
  final String? loadingMessage;
}

// Implementation:--------------------------------------------------------------
class RowButtonGroup<T> extends StatelessWidget
    implements RowButtonGroupWidgetInterface<T> {
  const RowButtonGroup({super.key, required this.props});

  @override
  final RowButtonGroupProps<T> props;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    props.items.asMap().forEach((index, element) {
      children.add(
        getIt<RowButtonWidgetInterface>(
          param1: RowButtonProps(
            disable: (props.loadingValue != null && props.loadingValue != '') ||
                element.disable,
            child: Text(
              element.label,
              style: element.textStyle,
            ),
            rightChild: (props.loadingValue != null &&
                    props.loadingValue == element.value)
                ? Row(
                    children: [
                      Text(
                        props.loadingMessage ?? '',
                        style: const TextStyle(
                            color: CupertinoColors.inactiveGray),
                      ),
                      const SizedBox(width: 10),
                      const CupertinoActivityIndicator(),
                    ],
                  )
                // CupertinoActivityIndicator()
                : (props.value != null && props.value == element.value
                    ? const Icon(CupertinoIcons.checkmark_alt)
                    : (element.hasWarning
                        ? CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: element.onWarningPressed,
                            child: const Icon(
                              CupertinoIcons.exclamationmark_circle_fill,
                              color: CupertinoColors.destructiveRed,
                            ))
                        : const SizedBox(width: 25))),
            onPressed: element.onPressed,
          ),
        ),
      );

      if (index != props.items.length - 1) {
        children.add(Container(
          padding: const EdgeInsets.only(left: 15),
          child: const Separator(),
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
