import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class SaveDiscountCodeDialogWidgetInterface implements Widget {
  DiscountCode? get discountCode;
}

// Implementation:--------------------------------------------------------------
class SaveDiscountCodeDialog extends StatefulWidget
    implements SaveDiscountCodeDialogWidgetInterface {
  const SaveDiscountCodeDialog({super.key, this.discountCode});

  // Properties:----------------------------------------------------------------
  @override
  final DiscountCode? discountCode;

  @override
  State<SaveDiscountCodeDialog> createState() => _SaveDiscountCodeDialogState();
}

class _SaveDiscountCodeDialogState extends State<SaveDiscountCodeDialog> {
  // Controllers:---------------------------------------------------------------
  late final _discountPercentageController = TextEditingController();
  late final _codeController = TextEditingController();

  // Stores:--------------------------------------------------------------------
  final SaveDiscountCodeDialogStoreInterface _store =
      getIt<SaveDiscountCodeDialogStoreInterface>();

  // Focus nodes:---------------------------------------------------------------
  late final _codeFocusNode = FocusNode();

  // Navigators:----------------------------------------------------------------
  late final RootNavigatorInterface _rootNavigator =
      getIt<RootNavigatorInterface>();

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();

    if (widget.discountCode != null) {
      _store.setDiscountCode(widget.discountCode!);
      _discountPercentageController.text = _store.discountPercentage;
      _codeController.text = _store.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return getIt<DialogWrapperWidgetInterface>(
          param1: DialogWrapperProps(
            width: 500,
            height: !_store.isEditing ? 450 : 500,
            header: _buildHeader(),
            child: _buildContent(),
          ),
        );
      },
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
        middleContent: Observer(builder: (_) {
          if (!_store.isEditing) {
            return Text('discount_codes.save_dialog.create_title'.tr());
          }

          return Text('discount_codes.save_dialog.view_title'.tr());
        }),
        rightContent: Observer(
          builder: (_) {
            return CupertinoButton(
              onPressed: _store.formIsValid ? _onSubmit : null,
              child: Text(
                'ok'.tr().toUpperCase(),
                style: _store.formIsValid
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

  Widget _buildContent() {
    return Observer(builder: (_) {
      List<Widget> children = [
        const SizedBox(height: 20),
        _buildDiscountPercentageField(),
        const SizedBox(height: 20),
        _buildCodeField(),
        const SizedBox(height: 20),
        _buildExpirationField(),
        const SizedBox(height: 20),
        _buildStartDateField(),
        const SizedBox(height: 20),
        _buildEndDateField(),
      ];

      if (_store.isEditing) {
        children.addAll(
          [
            const SizedBox(height: 20),
            getIt<RowButtonWidgetInterface>(
              param1: RowButtonProps(
                disableRightChild: true,
                onPressed: _showDeleteConfirmationDialog,
                child: Text(
                  'discount_codes.save_dialog.remove'.tr(),
                  style: TextStyle(color: _appThemeData.buttonColor),
                ),
              ),
            ),
          ],
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      );
    });
  }

  Widget _buildDiscountPercentageField() {
    return SizedBox(
      height: 48,
      child: getIt<TextInputWidgetInterface>(
        param1: TextInputProps(
          label: 'discount_codes.save_dialog.discount_percentage_label'.tr(),
          controller: _discountPercentageController,
          placeholder: '13',
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          hasError: _store.isDiscountPercentageInvalid,
          onChanged: _store.setDiscountPercentage,
          onSubmitted: (_) => _codeFocusNode.requestFocus(),
        ),
      ),
    );
  }

  Widget _buildCodeField() {
    return SizedBox(
      height: 48,
      child: Observer(
        builder: (_) {
          return getIt<TextInputWidgetInterface>(
            param1: TextInputProps(
              controller: _codeController,
              label: 'discount_codes.save_dialog.code_label'.tr(),
              focusNode: _codeFocusNode,
              hasError: _store.isCodeInvalid,
              onChanged: _store.setCode,
              suffix: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(
                  CupertinoIcons.refresh,
                  color: CupertinoColors.systemBlue,
                ),
                onPressed: () async {
                  await _store.generateCode();
                  _codeController.text = _store.code;
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildExpirationField() {
    return SizedBox(
      height: 48,
      child: getIt<RowButtonWidgetInterface>(
        param1: RowButtonProps(
          disableRightChild: true,
          child: Row(
            children: [
              Text('discount_codes.save_dialog.expiration_label'.tr()),
              const Spacer(),
              Observer(
                builder: (_) {
                  return CupertinoSwitch(
                    value: _store.hasNotExpiration,
                    activeColor: _appThemeData.activeSwitchButtonColor,
                    onChanged: _store.setHasNotExpiration,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStartDateField() {
    return SizedBox(
      height: 48,
      child: Observer(builder: (_) {
        return getIt<DateInputWidgetInterface>(
          param1: DateInputProps(
            label: 'discount_codes.save_dialog.start_date_label'.tr(),
            value: _store.startDate,
            disable: _store.hasNotExpiration,
            onDateChanged: _store.setStartDate,
          ),
        );
      }),
    );
  }

  Widget _buildEndDateField() {
    return SizedBox(
      height: 48,
      child: Observer(builder: (_) {
        return getIt<DateInputWidgetInterface>(
          param1: DateInputProps(
            label: 'discount_codes.save_dialog.end_date_label'.tr(),
            value: _store.endDate,
            disable: _store.hasNotExpiration,
            hasError: _store.isEndDateInvalid,
            onDateChanged: _store.setEndDate,
          ),
        );
      }),
    );
  }

  // General methods:-----------------------------------------------------------
  void _onSubmit() async {
    try {
      await _store.saveDiscountCode();
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on ValidationException catch (e) {
      _showError(e.message);
    }
  }

  void _showError(String errorMessage) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('error_title').tr(),
          content: Text(errorMessage),
          actions: [
            CupertinoDialogAction(
              child: const Text('ok').tr(),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              _store.deleteDiscountCode();
              Navigator.of(context)
                  .popUntil(ModalRoute.withName(_rootNavigator.mainRoute));
            },
            child: const Text('discount_codes.save_dialog.remove').tr(),
          ),
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
            child: const Text('cancel').tr(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _discountPercentageController.dispose();
    _codeController.dispose();
    _store.dispose();
    super.dispose();
  }
}
