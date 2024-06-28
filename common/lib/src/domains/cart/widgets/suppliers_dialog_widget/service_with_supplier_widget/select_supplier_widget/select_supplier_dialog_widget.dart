import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class SelectSupplierDialogWidgetInterface implements Widget {
  SelectSupplierDialogProps get props;
}

// Props:-----------------------------------------------------------------------
class SelectSupplierDialogProps {
  const SelectSupplierDialogProps({
    required this.label,
    required this.supplierValue,
    required this.withWorkforceValue,
    required this.choices,
    required this.onChanged,
  });

  final String label;
  final String? supplierValue;
  final bool withWorkforceValue;
  final List<SelectChoice<dynamic>> choices;
  final Function(SelectSupplierDialogStoreInterface value) onChanged;
}

// Themes:--------------------------------------------------------------------
final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

// Implementation:--------------------------------------------------------------
class SelectSupplierDialog extends StatelessWidget
    implements SelectSupplierDialogWidgetInterface {
  const SelectSupplierDialog({super.key, required this.props});

  @override
  final SelectSupplierDialogProps props;

  @override
  Widget build(BuildContext context) {
    SelectSupplierDialogStoreInterface store =
        getIt<SelectSupplierDialogStoreInterface>(
      param1: SelectSupplierDialogStoreParams(
        supplierValue: props.supplierValue,
        withWorkforceValue: props.withWorkforceValue,
      ),
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
  Widget _buildHeader(
      BuildContext context, SelectSupplierDialogStoreInterface store) {
    return getIt<DialogHeaderWidgetInterface>(
      param1: DialogHeaderProps(
        leftContent: CupertinoButton(
          child: Text(
            'cancel'.tr(),
            style: DialogHeaderWidgetInterface.sideDefaultTextStyle,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        middleContent: SizedBox(
            width: 370,
            child: Center(
                child: Text(
              props.label,
              style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
              overflow: TextOverflow.ellipsis,
            ))),
        rightContent: Observer(
          builder: (_) {
            return CupertinoButton(
              onPressed: () {
                props.onChanged(store);
                Navigator.pop(context);
              },
              child: Text(
                'ok'.tr().toUpperCase(),
                style: store.supplierValue != props.supplierValue ||
                        store.withWorkforceValue != props.withWorkforceValue
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

  Widget _buildContent(SelectSupplierDialogStoreInterface store) {
    return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Observer(builder: (_) {
          return Column(children: [
            getIt<DialogWrapperWidgetInterface>(
              param1: DialogWrapperProps(
                width: 540,
                height: 470,
                child: getIt<SelectWidgetInterface<dynamic>>(
                  param1: SelectProps<dynamic>(
                    choices: props.choices,
                    value: store.supplierValue,
                    nullable: true,
                    onChanged: (value) => store.setSupplierValue(value),
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 10, left: 16),
                child: Row(
                  children: [
                    Text('cart.suppliers_dialog.workforce'.tr(),
                        style: TextStyle(
                          color: store.supplierValue != null
                              ? _appThemeData.defaultTextColor
                              : MapleCommonColors.greyLighter,
                        )),
                    const SizedBox(width: 10),
                    CupertinoSwitch(
                      value: store.withWorkforceValue,
                      activeColor: _appThemeData.activeSwitchButtonColor,
                      onChanged: (value) => store.toggleWithWorkforceValue(),
                    ),
                  ],
                ))
          ]);
        }));
  }
}
