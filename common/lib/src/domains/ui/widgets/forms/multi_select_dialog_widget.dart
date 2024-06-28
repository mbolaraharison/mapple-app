import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class MultiSelectDialogWidgetInterface implements Widget {
  MultiSelectDialogProps get props;
}

// Props:-----------------------------------------------------------------------
class MultiSelectDialogProps {
  const MultiSelectDialogProps({
    required this.label,
    required this.choices,
    required this.values,
    required this.onChanged,
    this.displayedValue,
    this.disable = false,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });

  final String label;
  final List<SelectChoice<String>> choices;
  final List<String> values;
  final String? displayedValue;
  final ValueChanged<List<String>> onChanged;
  final bool disable;
  final BorderRadius borderRadius;
}

// Implementation:--------------------------------------------------------------
class MultiSelectDialog extends StatelessWidget
    implements MultiSelectDialogWidgetInterface {
  // Constructor:---------------------------------------------------------------
  const MultiSelectDialog({super.key, required this.props});

  // Variables:-----------------------------------------------------------------
  @override
  final MultiSelectDialogProps props;

  // Lifecycle methods:---------------------------------------------------------
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

  // Widget methods:------------------------------------------------------------
  Widget _buildDialogHeader(BuildContext context) {
    return getIt<DialogHeaderWidgetInterface>(
      param1: DialogHeaderProps(
        leftContent: CupertinoButton(
          child: Text(
            'close'.tr(),
            style: DialogHeaderWidgetInterface.sideDefaultTextStyle,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        middleContent: Text(
          props.label,
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
      ),
    );
  }

  Widget _buildDialogContent() {
    List<String> currentValues = props.values;
    return StatefulBuilder(builder: (context, setState) {
      return Padding(
        padding: const EdgeInsets.only(top: 30),
        child: getIt<MultiSelectWidgetInterface>(
          param1: MultiSelectProps(
              choices: props.choices,
              values: currentValues,
              onChanged: (values) {
                props.onChanged(values);
                setState(() {
                  currentValues = values;
                });
              }),
        ),
      );
    });
  }

  // General methods:-----------------------------------------------------------
  void _onPressed(context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => getIt<DialogWrapperWidgetInterface>(
        param1: DialogWrapperProps(
          width: 540,
          height: 592,
          header: _buildDialogHeader(context),
          child: _buildDialogContent(),
        ),
      ),
    );
  }
}
