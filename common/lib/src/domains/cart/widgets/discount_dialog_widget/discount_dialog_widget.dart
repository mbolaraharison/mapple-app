import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class DiscountDialogWidgetInterface implements Widget {}

// Theme:-----------------------------------------------------------------------
abstract class DiscountDialogThemeInterface {
  Color get fieldTextColor;
  Color get discountTextColor;
  Color get totalTextColor;
}

// Implementation:--------------------------------------------------------------
class DiscountDialog extends StatefulWidget
    implements DiscountDialogWidgetInterface {
  const DiscountDialog({super.key});

  @override
  State<DiscountDialog> createState() => _DiscountDialogState();
}

class _DiscountDialogState extends State<DiscountDialog> {
  // Controllers:---------------------------------------------------------------
  final TextEditingController _discountCodeValueController =
      TextEditingController();

  // Stores:--------------------------------------------------------------------
  late CustomerOrderStoreInterface _customerOrderStore;
  late final DiscountDialogStoreInterface _store =
      getIt<DiscountDialogStoreInterface>();

  // Variables:-----------------------------------------------------------------
  late final ReactionDisposer _onDiscountCodeChangedDisposer;

  // Utils:---------------------------------------------------------------------
  late final DeviceUtilsInterface _deviceUtils = getIt<DeviceUtilsInterface>();
  late final DialogUtilsInterface _dialogUtils = getIt<DialogUtilsInterface>();

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();
  final DiscountDialogThemeInterface _theme =
      getIt<DiscountDialogThemeInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _onDiscountCodeChangedDisposer =
        reaction((_) => _store.selectedDiscountCode, _onDiscountCodeChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _customerOrderStore = Provider.of<CustomerOrderStoreInterface>(context);
    _store.setRows(_customerOrderStore.orderStepStore.orderRows);
  }

  @override
  Widget build(BuildContext context) {
    return getIt<DialogWrapperWidgetInterface>(
      param1: DialogWrapperProps(
        width: 712,
        height: 693,
        header: _buildHeader(),
        child: _buildContent(),
      ),
    );
  }

  // Widgets methods:-----------------------------------------------------------
  Widget _buildHeader() {
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
          'cart.discounts_dialog.title'.tr(),
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
        rightContent: Observer(
          builder: (_) {
            return CupertinoButton(
              onPressed: _store.formIsValid ? _onSubmit : null,
              child: Text(
                'ok'.tr().toUpperCase(),
                style: _store.formIsValid
                    ? DialogHeaderWidgetInterface.sideDefaultTextStyle
                        .copyWith(fontWeight: FontWeight.w600)
                    : const TextStyle(color: CupertinoColors.inactiveGray),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 33),
      child: Column(
        children: [
          _buildTypeField(),
          const SizedBox(height: 20),
          _buildDiscountField(),
          const SizedBox(height: 20),
          _buildFirstStepSubmitButton(),
          const SizedBox(height: 20),
          getIt<SeparatorWidgetInterface>(),
          const SizedBox(height: 20),
          SizedBox(
            width: 510,
            child: Text(
              'cart.discounts_dialog.select_services'.tr(),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 25),
          Observer(builder: (_) => _buildServicesList()),
          const SizedBox(height: 25),
          _buildTotalRow(),
        ],
      ),
    );
  }

  Widget _buildTypeField() {
    return SizedBox(
      height: 48,
      child: Observer(builder: (_) {
        return getIt<PickerWidgetInterface<DiscountTypeChoice>>(
          param1: PickerProps(
            label: 'cart.discounts_dialog.type_label'.tr(),
            value: _store.discountType,
            borderRadius: BorderRadius.circular(10),
            choices: DiscountTypeChoice.choices,
            disable: _store.isFirstStepValidated,
            onChanged: _store.setDiscountType,
          ),
        );
      }),
    );
  }

  Widget _buildDiscountField() {
    return Observer(builder: (_) {
      if (_store.discountType == DiscountTypeChoice.commercialAdvantage) {
        return _buildCommercialAdvantageField();
      }

      return _buildDiscountCodeField();
    });
  }

  Widget _buildCommercialAdvantageField() {
    return SizedBox(
      height: 48,
      child: Observer(builder: (_) {
        return getIt<TextInputWidgetInterface>(
          param1: TextInputProps(
            label: DiscountTypeChoice.commercialAdvantage.label,
            placeholder: '0',
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            style: TextStyle(
              color: _theme.fieldTextColor,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            borderRadius: BorderRadius.circular(10),
            disable: _store.isFirstStepValidated,
            onChanged: _store.setCommercialAdvantage,
          ),
        );
      }),
    );
  }

  Widget _buildDiscountCodeField() {
    return Column(
      children: [
        SizedBox(
          height: 48,
          child: Observer(builder: (_) {
            return getIt<TextInputWidgetInterface>(
              param1: TextInputProps(
                label: DiscountTypeChoice.discountCode.label,
                placeholder: 'COD000',
                style: TextStyle(
                  color: _theme.fieldTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                borderRadius: BorderRadius.circular(10),
                disable: _store.isFirstStepValidated,
                onChanged: _store.setDiscountCode,
              ),
            );
          }),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 48,
          child: getIt<TextInputWidgetInterface>(
            param1: TextInputProps(
              label: 'cart.discounts_dialog.discount_code_value'.tr(),
              controller: _discountCodeValueController,
              style: TextStyle(
                color: _theme.fieldTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              borderRadius: BorderRadius.circular(10),
              disable: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFirstStepSubmitButton() {
    return Observer(builder: (_) {
      List<Widget> children = [];

      if (!_store.isFirstStepValidated) {
        children.add(
          CupertinoButton.filled(
            onPressed: _store.isFirstStepValid ? _onSubmitFirstStep : null,
            child: Text('submit'.tr()),
          ),
        );
      } else {
        children.add(
          CupertinoButton(
            onPressed: _store.backToFirstStep,
            child: Text(
              'cancel'.tr(),
              style: const TextStyle(
                color: CupertinoColors.destructiveRed,
              ),
            ),
          ),
        );
      }

      return SizedBox(
        height: 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      );
    });
  }

  Widget _buildServicesList() {
    final children = [];

    for (var i = 0; i <= _store.rows.length - 1; i++) {
      children
          .add(_buildServiceItem(_store.rows[i], i == _store.rows.length - 1));
      if (i < _store.rows.length - 1) {
        children.add(
          getIt<SeparatorWidgetInterface>(),
        );
      }
    }

    return Container(
      padding: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 51),
              SizedBox(
                width: 263,
                child: Text(
                  'cart.discounts_dialog.description'.tr().toUpperCase(),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                width: 110,
                child: Text(
                  'cart.discounts_dialog.amount'.tr().toUpperCase(),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                width: 89,
                child: Text(
                  'cart.discounts_dialog.discount'.tr().toUpperCase(),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'cart.discounts_dialog.discounted_amount'.tr().toUpperCase(),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          getIt<SeparatorWidgetInterface>(),
          ...children,
        ],
      ),
    );
  }

  Widget _buildServiceItem(OrderRow item, bool isLast) {
    return FutureBuilder(
      future: canApplyDiscountCodeOnOrderRow(item, _store.selectedDiscountCode),
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final bool canApplyDiscountCode = snapshot.data;

        return Observer(builder: (_) {
          final int index = _store.selectedRows
              .indexWhere((element) => element.id == item.id);
          final bool isActive = index != -1;
          final row = isActive ? _store.selectedRows[index] : item;
          final isDisabled = !_store.isFirstStepValidated ||
              (!canApplyDiscountCode &&
                  _store.discountType == DiscountTypeChoice.discountCode);

          return CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed:
                isDisabled ? null : () => _store.toggleSelectedServices(row),
            child: Container(
              height: 77,
              decoration: BoxDecoration(
                color: isDisabled ? MapleCommonColors.disabledBackground : null,
                borderRadius: isLast
                    ? const BorderRadius.vertical(bottom: Radius.circular(8))
                    : null,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 51,
                    child: Center(
                      child: getIt<RadioWidgetInterface>(
                        param1: RadioProps(value: isActive),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 263,
                    child: Text(
                      row.service!.label,
                      style: TextStyle(
                        color: isDisabled
                            ? CupertinoColors.inactiveGray
                            : _appThemeData.defaultTextColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 110,
                    child: Text(
                      row.formattedTotalGrossInclTax,
                      style: TextStyle(
                        color: isDisabled
                            ? CupertinoColors.inactiveGray
                            : _appThemeData.defaultTextColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        decoration: row.discount != null
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 89,
                    child: Text(
                      row.formattedDiscount,
                      style: TextStyle(
                        color: isActive
                            ? _theme.discountTextColor
                            : (isDisabled
                                ? CupertinoColors.inactiveGray
                                : _appThemeData.defaultTextColor),
                        fontSize: 13,
                        fontWeight:
                            isActive ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      row.discount != null ? row.formattedTotalNetInclTax : '',
                      style: TextStyle(
                        color: isDisabled
                            ? CupertinoColors.inactiveGray
                            : _appThemeData.defaultTextColor,
                        fontSize: 13,
                        fontWeight:
                            isActive ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Widget _buildTotalRow() {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(
            'cart.discounts_dialog.total_with_vat'.tr(),
            style: TextStyle(
              color: _theme.totalTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Observer(builder: (_) {
            return Text(
              _store.formattedTotalNetInclTax,
              style: TextStyle(
                color: _theme.totalTextColor,
                fontWeight: FontWeight.bold,
              ),
            );
          }),
        ],
      ),
    );
  }

  // General methods:-----------------------------------------------------------
  Future<bool> canApplyDiscountCodeOnOrderRow(
      OrderRow row, DiscountCode? discountCode) async {
    if (discountCode == null) {
      return false;
    }

    return row.canApplyDiscountCode(discountCode);
  }

  Future<void> _onSubmitFirstStep() async {
    _deviceUtils.hideKeyboard(context);

    try {
      await _store.submitFirstStep();
    } on ValidationException catch (e) {
      if (mounted) {
        _dialogUtils.showErrorDialog(context: context, errorMessage: e.message);
      }
    }
  }

  void _onSubmit() {
    _customerOrderStore.orderStepStore.applyDiscount(_store.selectedRows);
    Navigator.of(context).pop();
  }

  void _onDiscountCodeChanged(_) {
    if (_store.selectedDiscountCode == null) {
      _discountCodeValueController.text = '';
      return;
    }

    _discountCodeValueController.text =
        _store.selectedDiscountCode!.formattedDiscount;
  }

  // Dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    _discountCodeValueController.dispose();
    _onDiscountCodeChangedDisposer();
    super.dispose();
  }
}
