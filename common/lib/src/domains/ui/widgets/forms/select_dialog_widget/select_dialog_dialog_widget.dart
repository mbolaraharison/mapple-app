import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class SelectDialogDialogWidgetInterface<T> implements Widget {
  SelectDialogDialogProps<T> get props;
}

// Props:-----------------------------------------------------------------------
class SelectDialogDialogProps<T> {
  const SelectDialogDialogProps({
    required this.width,
    required this.height,
    required this.label,
    required this.value,
    required this.choices,
    this.nullable = false,
    required this.onChanged,
  });

  final double width;
  final double height;
  final String label;
  final T? value;
  final List<SelectChoice<T>> choices;
  final bool nullable;
  final void Function(T) onChanged;
}

// Implementation:--------------------------------------------------------------
class SelectDialogDialog<T> extends StatelessWidget
    implements SelectDialogDialogWidgetInterface<T> {
  const SelectDialogDialog({super.key, required this.props});

  @override
  final SelectDialogDialogProps<T> props;

  @override
  Widget build(BuildContext context) {
    SelectDialogStoreInterface<T> store = getIt<SelectDialogStoreInterface<T>>(
      param1: SelectDialogStoreParams<T>(value: props.value),
    );

    return getIt<DialogWrapperWidgetInterface>(
      param1: DialogWrapperProps(
        width: 540,
        height: 592,
        header: _buildHeader(context, store),
        child: _buildContent(store),
      ),
    );
  }

  // Widget methods:------------------------------------------------------------
  Widget _buildHeader(BuildContext context, SelectDialogStoreInterface store) {
    return getIt<DialogHeaderWidgetInterface>(
      param1: DialogHeaderProps(
        leftContent: CupertinoButton(
          child: Text(
            'cancel'.tr(),
            style: DialogHeaderWidgetInterface.sideDefaultTextStyle,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        middleContent: Text(
          props.label,
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
        rightContent: Observer(
          builder: (_) {
            return CupertinoButton(
              onPressed: store.value != props.value
                  ? () {
                      props.onChanged(store.value);
                      Navigator.pop(context);
                    }
                  : null,
              child: Text(
                'ok'.tr().toUpperCase(),
                style: store.value != props.value
                    ? DialogHeaderWidgetInterface.sideDefaultTextStyle
                        .copyWith(fontWeight: FontWeight.w600)
                    : const TextStyle(
                        color: CupertinoColors.inactiveGray,
                      ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(SelectDialogStoreInterface store) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Observer(builder: (_) {
        return getIt<SelectWidgetInterface<T>>(
          param1: SelectProps<T>(
            choices: props.choices,
            value: store.value,
            nullable: props.nullable,
            onChanged: store.setValue,
          ),
        );
      }),
    );
  }
}
