import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class AddEditContactWidgetInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class AddEditContact extends StatefulWidget
    implements AddEditContactWidgetInterface {
  const AddEditContact({super.key});

  @override
  State<AddEditContact> createState() => _AddEditContactState();
}

class _AddEditContactState extends State<AddEditContact> {
  // Stores:--------------------------------------------------------------------
  late CreateProjectDialogStoreInterface _createProjectDialogStore;

  // Navigators:----------------------------------------------------------------
  final CreateProjectNavigatorInterface _navigator =
      getIt<CreateProjectNavigatorInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _createProjectDialogStore =
        Provider.of<CreateProjectDialogStoreInterface>(context);
  }

  @override
  Widget build(BuildContext context) {
    return getIt<DialogContentWrapperWidgetInterface>(
      param1: DialogContentWrapperProps(
        header: _buildHeader(),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: [
              getIt<ContactFormWidgetInterface>(
                param1: ContactFormProps(
                  store: _createProjectDialogStore.contactFormStore,
                  deleteButton: _buildDeleteButton(),
                ),
              ),
            ],
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
          onPressed: () => Navigator.pop(context),
          child: Row(
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
          _createProjectDialogStore.contactFormStore.params.contact == null
              ? 'home_create_project_dialog_add_contact'.tr()
              : 'home_create_project_dialog_edit_contact'.tr(),
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
        rightContent: Observer(
          builder: (context) {
            return CupertinoButton(
              onPressed: _createProjectDialogStore.contactFormStore.isValid
                  ? _onPressedSubmit
                  : null,
              child: Text(
                _createProjectDialogStore.contactFormStore.isCreating
                    ? 'add'.tr()
                    : 'edit'.tr(),
                style: _createProjectDialogStore.contactFormStore.isValid
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

  Widget _buildDeleteButton() {
    if (_createProjectDialogStore.contactFormStore.isCreating) {
      return Container();
    }

    return getIt<RowButtonWidgetInterface>(
      param1: RowButtonProps(
        disableRightChild: true,
        onPressed: _showDeleteConfirmationDialog,
        child: Text(
          'contact_remove'.tr(),
          style: TextStyle(color: getIt<AppThemeDataInterface>().buttonColor),
        ),
      ),
    );
  }

  // General methods:-----------------------------------------------------------
  void _onPressedSubmit() {
    FocusManager.instance.primaryFocus?.unfocus();
    _createProjectDialogStore.contactFormStore.validateForm();

    try {
      _createProjectDialogStore.contactFormStore.errorStore.throwIfError();
    } on ValidationException catch (e) {
      _createProjectDialogStore.contactFormStore.errorStore
          .showErrorDialog(e.message, context);
      return;
    }

    _createProjectDialogStore.submitContactForm();
    Navigator.pop(context);
  }

  void _showDeleteConfirmationDialog() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              _createProjectDialogStore.removeContact();
              Navigator.of(context).pop();
              _navigator.key.currentState?.pop();
            },
            child: const Text('contact_remove').tr(),
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
}
