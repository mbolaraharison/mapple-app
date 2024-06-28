import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class AddEditContactDialogWidgetInterface implements Widget {
  AddEditContactDialogProps get props;
}

// Props:-----------------------------------------------------------------------
class AddEditContactDialogProps {
  const AddEditContactDialogProps({
    this.contact,
    required this.customer,
  });

  final Contact? contact;
  final Customer customer;
}

// Implementation:--------------------------------------------------------------
class AddEditContactDialog extends StatefulWidget
    implements AddEditContactDialogWidgetInterface {
  const AddEditContactDialog({super.key, required this.props});

  @override
  final AddEditContactDialogProps props;

  @override
  State<AddEditContactDialog> createState() => _AddEditContactDialogState();
}

class _AddEditContactDialogState extends State<AddEditContactDialog> {
  // Variables:-----------------------------------------------------------------
  late final ContactFormStoreInterface _store =
      getIt<ContactFormStoreInterface>(
    param1: ContactFormStoreParams(
      contact: widget.props.contact,
      customer: widget.props.customer,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return getIt<DialogWrapperWidgetInterface>(
      param1: DialogWrapperProps(
        width: 640,
        height: 670,
        header: _buildHeader(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: getIt<ContactFormWidgetInterface>(
            param1: ContactFormProps(store: _store),
          ),
        ),
      ),
    );
  }

  // Widgets methods:-----------------------------------------------------------
  Widget _buildHeader(BuildContext context) {
    return getIt<DialogHeaderWidgetInterface>(
      param1: DialogHeaderProps(
        leftContent: CupertinoButton(
          child: Text(
            'cancel'.tr(),
            style: DialogHeaderWidgetInterface.sideDefaultTextStyle,
          ),
          onPressed: () => _onCancel(context),
        ),
        middleContent: Text(
          widget.props.contact == null
              ? 'contact_add'.tr()
              : 'contact_edit'.tr(),
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
        rightContent: Observer(
          builder: (_) {
            return CupertinoButton(
              onPressed: _store.isValid ? () => _onSubmit(context) : null,
              child: Text(
                widget.props.contact == null ? 'add'.tr() : 'edit'.tr(),
                style: _store.isValid
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

  // General methods:-----------------------------------------------------------
  void _onSubmit(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    _store.validateForm();

    try {
      _store.errorStore.throwIfError();
    } on ValidationException catch (e) {
      _store.errorStore.showErrorDialog(e.message, context);
      return;
    }

    _store.submit();
    Navigator.pop(context);
  }

  void _onCancel(BuildContext context) {
    Navigator.pop(context);
    _store.reset();
  }
}
