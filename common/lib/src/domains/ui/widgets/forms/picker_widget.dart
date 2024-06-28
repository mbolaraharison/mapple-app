import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class PickerWidgetInterface<T> implements Widget {
  PickerProps<T> get props;
}

// Props:-----------------------------------------------------------------------
class PickerProps<T> {
  const PickerProps({
    required this.label,
    required this.value,
    required this.choices,
    required this.onChanged,
    this.disable = false,
    this.hasError = false,
    this.borderRadius,
  });

  final String label;
  final T? value;
  final List<PickerChoice<T>> choices;
  final ValueChanged<T> onChanged;
  final bool hasError;
  final bool disable;
  final BorderRadius? borderRadius;
}

// Implementation:--------------------------------------------------------------
class Picker<T> extends StatefulWidget implements PickerWidgetInterface<T> {
  const Picker({super.key, required this.props});

  @override
  final PickerProps<T> props;

  @override
  State<Picker> createState() => _PickerState<T>();
}

class _PickerState<T> extends State<Picker<T>> {
  // Variables:-----------------------------------------------------------------
  late FixedExtentScrollController _scrollController;
  late String labelValue;

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();

    final indexValue = widget.props.choices.indexWhere((element) {
      if (element.value is AbstractBaseModel &&
          widget.props.value is AbstractBaseModel) {
        return (element.value as AbstractBaseModel).id ==
            (widget.props.value as AbstractBaseModel).id;
      }
      return element.value == widget.props.value;
    });
    _scrollController = FixedExtentScrollController(initialItem: indexValue);
    labelValue = indexValue > -1 ? widget.props.choices[indexValue].label : '';
  }

  @override
  void didUpdateWidget(covariant Picker<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // compare two objects or two dynamics
    final indexValue = widget.props.choices.indexWhere((element) {
      if (element.value is AbstractBaseModel &&
          widget.props.value is AbstractBaseModel) {
        return (element.value as AbstractBaseModel).id ==
            (widget.props.value as AbstractBaseModel).id;
      }
      return element.value == widget.props.value;
    });
    labelValue = indexValue > -1 ? widget.props.choices[indexValue].label : '';
    _scrollController = FixedExtentScrollController(initialItem: indexValue);
  }

  @override
  Widget build(BuildContext context) {
    return getIt<RowButtonWidgetInterface>(
      param1: RowButtonProps(
        child: Text(
          widget.props.label,
          style: TextStyle(
            color: widget.props.disable
                ? CupertinoColors.inactiveGray
                : (widget.props.hasError
                    ? CupertinoColors.destructiveRed
                    : null),
          ),
        ),
        disableRightChild: true,
        value: labelValue,
        disable: widget.props.disable,
        borderRadius: widget.props.borderRadius,
        onPressed: () => _showDialog(
          CupertinoPicker(
            scrollController: _scrollController,
            itemExtent: 32,
            onSelectedItemChanged: (int selectedItem) {
              widget.props.onChanged(widget.props.choices[selectedItem].value);
            },
            children:
                List<Widget>.generate(widget.props.choices.length, (int index) {
              return Center(child: Text(widget.props.choices[index].label));
            }),
          ),
        ),
      ),
    );
  }

  // Methods:-------------------------------------------------------------------
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  // Dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
