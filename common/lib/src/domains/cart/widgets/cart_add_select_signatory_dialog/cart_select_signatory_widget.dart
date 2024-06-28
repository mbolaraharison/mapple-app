import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class CartSelectSignatoryWidgetInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class CartSelectSignatory extends StatefulWidget
    implements CartSelectSignatoryWidgetInterface {
  const CartSelectSignatory({super.key});

  @override
  State<CartSelectSignatory> createState() => _CartSelectSignatoryState();
}

class _CartSelectSignatoryState extends State<CartSelectSignatory> {
  // Stores:--------------------------------------------------------------------
  late CartAddSelectSignatoryDialogProps _dialogProps;

  // Navigators:----------------------------------------------------------------
  late final RootNavigatorInterface _rootNavigator =
      getIt<RootNavigatorInterface>();
  late final CartAddSelectSignatoryDialogNavigatorInterface _navigator =
      getIt<CartAddSelectSignatoryDialogNavigatorInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _dialogProps = Provider.of<CartAddSelectSignatoryDialogProps>(context);
  }

  // Lifecycle methods:----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return getIt<DialogWrapperWidgetInterface>(
      param1: DialogWrapperProps(
        width: 540,
        height: 592,
        disableContentWrapper: true,
        child: getIt<DialogContentWrapperWidgetInterface>(
          param1: DialogContentWrapperProps(
            header: _buildHeader(),
            child: Column(
              children: [
                const SizedBox(height: 39),
                _buildSelectWrapper(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget methods:------------------------------------------------------------
  Widget _buildHeader() {
    return getIt<DialogHeaderWidgetInterface>(
      param1: DialogHeaderProps(
        leftContent: CupertinoButton(
          onPressed: () => _rootNavigator.key.currentState?.pop(),
          child: Wrap(
            children: [
              Icon(
                CupertinoIcons.chevron_left,
                color: DialogHeaderWidgetInterface.sideDefaultTextStyle.color,
                size: 22,
              ),
              Text(
                'back'.tr(),
                style: TextStyle(
                  color: DialogHeaderWidgetInterface.sideDefaultTextStyle.color,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
        middleContent: Text(
          _dialogProps.modalTitle,
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
        rightContent: _dialogProps.rightChild,
      ),
    );
  }

  Widget _buildSelectWrapper() {
    if (_dialogProps.values != null) {
      return _buildSelect(_dialogProps.values!);
    } else if (_dialogProps.streamForValues != null) {
      return StreamBuilder(
        stream: _dialogProps.streamForValues,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          List<SelectForSignatureBaseModel> values =
              snapshot.data as List<SelectForSignatureBaseModel>;
          return _buildSelect(values);
        },
      );
    }
    return Container();
  }

  Widget _buildSelect(List<SelectForSignatureBaseModel> values) {
    List<SelectChoice> choices = [];

    List<SelectForSignatureBaseModel> models = values;
    for (SelectForSignatureBaseModel model in models) {
      choices.add(SelectChoice(
        value: model.id,
        label: model.shortFullName,
        disable: !model.isValidForSignature,
        hasWarning: !model.isValidForSignature,
        bottomError: _dialogProps.isContact == true
            ? model.signingAbilityStatusInfos
            : null,
        height: _dialogProps.isContact == true &&
                model.signingAbilityStatusInfosList.isNotEmpty
            ? (model.signingAbilityStatusInfosList.length + 1) * 60 / 2
            : 44,
        maxLines: _dialogProps.isContact == true
            ? model.signingAbilityStatusInfosList.length + 1
            : 1,
        warningButton: _dialogProps.isContact == true
            ? CupertinoButton(
                padding: EdgeInsets.zero,
                child: Text(
                  'edit'.tr(),
                  style: const TextStyle(
                    color: CupertinoColors.destructiveRed,
                    fontSize: 17,
                  ),
                ),
                onPressed: () => _onWarningEditPressedWrapper(model))
            : null,
        onWarningPressed: () => _onWarningEditPressedWrapper(model),
        onPressedWhenDisabled: _dialogProps.isContact == true
            ? () => _onWarningEditPressedWrapper(model)
            : null,
      ));
    }
    return getIt<MultiSelectWidgetInterface>(
      param1: MultiSelectProps(
        values: _dialogProps.selectedValues,
        limit: _dialogProps.limit,
        onChanged: _dialogProps.onChanged != null
            ? (values) => setState(() {
                  _dialogProps.onChanged!(values);
                })
            : null,
        onSelect: _dialogProps.onSelect != null
            ? (value) => setState(() {
                  _dialogProps.onSelect!(value);
                })
            : null,
        choices: choices,
      ),
    );
  }

  // Methods:--------------------------------------------------------------------
  Future<void> _onWarningEditPressedWrapper(
      SelectForSignatureBaseModel model) async {
    if (model is Signer<SignerModel>) {
      _onWarningEditPressed(model.model);
    } else {
      _onWarningEditPressed(model);
    }
  }

  void _onWarningEditPressed(SelectForSignatureBaseModel model) {
    if (model is Contact) {
      _navigator.key.currentState?.pushNamed(
        _navigator.createOrEditContact,
        arguments: CartCreateOrEditContactArguments(
          contact: model,
        ),
      );
    } else {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(_dialogProps.errorModalTitle),
          content: Column(
            children: [
              const SizedBox(height: 10),
              const Icon(
                CupertinoIcons.exclamationmark_circle,
                color: MapleCommonColors.red,
                size: 50,
              ),
              const SizedBox(height: 10),
              Text(_dialogProps.errorModalContent),
              const SizedBox(height: 10),
              Text(
                model.signingAbilityStatusInfos,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                _dialogProps.errorModalContent2,
              ),
            ],
          ),
        ),
      );
    }
  }
}
