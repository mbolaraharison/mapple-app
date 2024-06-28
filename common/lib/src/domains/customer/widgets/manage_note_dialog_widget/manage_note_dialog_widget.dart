import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';

// Interface:-------------------------------------------------------------------
abstract class ManageNoteDialogWidgetInterface implements Widget {
  ManageNoteDialogProps get props;
}

// Props:-----------------------------------------------------------------------
class ManageNoteDialogProps {
  const ManageNoteDialogProps({
    this.note,
    required this.customerId,
  });

  final Note? note;
  final String customerId;
}

// Implementation:--------------------------------------------------------------
class ManageNoteDialog extends StatefulWidget
    implements ManageNoteDialogWidgetInterface {
  const ManageNoteDialog({super.key, required this.props});

  @override
  final ManageNoteDialogProps props;

  @override
  State<ManageNoteDialog> createState() => _ManageNoteDialogState();
}

class _ManageNoteDialogState extends State<ManageNoteDialog> {
  // Stores:--------------------------------------------------------------------
  late final ManageNoteDialogStoreInterface _store =
      getIt<ManageNoteDialogStoreInterface>(
    param1: ManageNoteDialogStoreParams(
      customerId: widget.props.customerId,
      note: widget.props.note,
    ),
  );

  // Text controllers:----------------------------------------------------------
  late final TextEditingController _titleController = TextEditingController();
  late final TextEditingController _noteController = TextEditingController();

  // Focus nodes:---------------------------------------------------------------
  late final FocusNode _emailFocusNode = FocusNode();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _titleController.text = _store.title ?? '';
    _noteController.text = _store.note;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => getIt<DialogWrapperWidgetInterface>(
        param1: DialogWrapperProps(
          width: 540,
          height: 592,
          header: _buildDialogHeader(),
          child: Column(
            children: [
              const SizedBox(height: 30),
              _buildTitleField(),
              const SizedBox(height: 20),
              _buildNoteField(),
            ],
          ),
        ),
      ),
    );
  }

  // Widgets methods:-----------------------------------------------------------
  Widget _buildDialogHeader() {
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
          widget.props.note == null
              ? 'customer.notes.create.title'.tr()
              : 'customer.notes.edit.title'.tr(),
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
        rightContent: CupertinoButton(
          onPressed: _store.isValid ? () => _createOrUpdate() : null,
          child: Text(
            widget.props.note == null
                ? 'customer.notes.create.submit-button'.tr()
                : 'customer.notes.edit.submit-button'.tr(),
            style: _store.isValid
                ? DialogHeaderWidgetInterface.sideDefaultTextStyle
                    .copyWith(fontWeight: FontWeight.w600)
                : const TextStyle(
                    color: CupertinoColors.inactiveGray,
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: getIt<TextInputWidgetInterface>(
        param1: TextInputProps(
          labelWidth: 180,
          placeholder: 'customer.notes.placeholder.title'.tr(),
          controller: _titleController,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          onChanged: (value) {
            _store.title = value;
          },
          onSubmitted: (_) =>
              FocusScope.of(context).requestFocus(_emailFocusNode),
        ),
      ),
    );
  }

  Widget _buildNoteField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: getIt<TextInputWidgetInterface>(
        param1: TextInputProps(
          height: 420,
          maxLines: 19,
          labelWidth: 180,
          placeholder: 'customer.notes.placeholder.note'.tr(),
          controller: _noteController,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          onChanged: (value) => _store.note = value,
          onSubmitted: (_) =>
              FocusScope.of(context).requestFocus(_emailFocusNode),
        ),
      ),
    );
  }

  void _createOrUpdate() {
    _store.createOrUpdate();
    Navigator.pop(context);
    late String msg;
    if (widget.props.note == null) {
      msg = 'customer.notes.create.confirm-create'.tr();
    } else {
      msg = 'customer.notes.edit.confirm-update'.tr();
    }
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }
}
