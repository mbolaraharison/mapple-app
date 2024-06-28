import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class DateInputWidgetInterface implements Widget {
  DateInputProps get props;
}

// Props:-----------------------------------------------------------------------
class DateInputProps {
  const DateInputProps({
    required this.label,
    required this.value,
    required this.onDateChanged,
    this.hasError = false,
    this.disable = false,
    this.minimumDate,
    this.mode = CupertinoDatePickerMode.dateAndTime,
    this.onPressedInitial,
  });

  final String label;
  final DateTime? value;
  final ValueChanged<DateTime> onDateChanged;
  final bool hasError;
  final bool disable;
  final DateTime? minimumDate;
  final CupertinoDatePickerMode mode;
  final VoidCallback? onPressedInitial;
}

// Implementation:--------------------------------------------------------------
class DateInput extends StatelessWidget implements DateInputWidgetInterface {
  DateInput({super.key, required this.props});

  // Properties:----------------------------------------------------------------
  @override
  final DateInputProps props;

  // Services:------------------------------------------------------------------
  late final DateTimeUtilsInterface _dateTimeUtils =
      getIt<DateTimeUtilsInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return getIt<RowButtonWidgetInterface>(
      param1: RowButtonProps(
        child: Text(
          props.label,
          style: TextStyle(
            color: props.disable
                ? CupertinoColors.inactiveGray
                : (props.hasError ? CupertinoColors.destructiveRed : null),
          ),
        ),
        disableRightChild: true,
        value: props.value != null
            ? _dateTimeUtils.formatToFrenchDate(props.value!)
            : null,
        disable: props.disable,
        onPressed: () {
          props.onPressedInitial?.call();
          _showDialog(
            context: context,
            child: CupertinoDatePicker(
              minimumDate: props.minimumDate,
              mode: props.mode,
              initialDateTime: props.value,
              use24hFormat: true,
              onDateTimeChanged: props.onDateChanged,
            ),
          );
        },
      ),
    );
  }

  // General methods:-----------------------------------------------------------
  void _showDialog({required Widget child, required BuildContext context}) {
    double width = MediaQuery.of(context).size.width;

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        width: width,
        height: 216,
        alignment: Alignment.center,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Container(
          width: width > 400 ? 400 : width,
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          // The Bottom margin is provided to align the popup above the system
          // navigation bar.
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: child,
          ),
        ),
      ),
    );
  }
}
