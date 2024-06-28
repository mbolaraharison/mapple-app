import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class ContactFormWidgetInterface implements Widget {
  ContactFormProps get props;
}

// Props:-----------------------------------------------------------------------
class ContactFormProps {
  const ContactFormProps({
    required this.store,
    this.deleteButton,
    this.onPreDelete,
  });

  final ContactFormStoreInterface store;
  final Widget? deleteButton;
  final Future<void> Function(Contact contact)? onPreDelete;
}

// Implementation:--------------------------------------------------------------
class ContactForm extends StatefulWidget implements ContactFormWidgetInterface {
  const ContactForm({
    super.key,
    required this.props,
  });

  @override
  final ContactFormProps props;

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  // Text controllers:----------------------------------------------------------
  late TextEditingController _lastNameController;
  late TextEditingController _firstNameController;
  late TextEditingController _phoneController;
  late TextEditingController _mobilePhoneController;
  late TextEditingController _emailController;

  // Focus nodes:---------------------------------------------------------------
  late FocusNode _firstNameFocusNode;
  late FocusNode _phoneFocusNode;
  late FocusNode _mobilePhoneFocusNode;
  late FocusNode _emailFocusNode;

  // Navigators:----------------------------------------------------------------
  late final RootNavigatorInterface _rootNavigator =
      getIt<RootNavigatorInterface>();

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _firstNameFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    _mobilePhoneFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _lastNameController = TextEditingController();
    _firstNameController = TextEditingController();
    _phoneController = TextEditingController();
    _mobilePhoneController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _lastNameController.text = widget.props.store.lastName;
    _firstNameController.text = widget.props.store.firstName;
    _phoneController.text = widget.props.store.phone;
    _mobilePhoneController.text = widget.props.store.mobilePhone;
    _emailController.text = widget.props.store.email;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Column(
        children: [
          const SizedBox(height: 15),
          _buildCivilityField(),
          const SizedBox(height: 15),
          _buildNameFields(),
          const SizedBox(height: 15),
          _buildContactFields(),
          const SizedBox(height: 15),
          _buildIsDefaultButton(),
          const SizedBox(height: 15),
          widget.props.deleteButton ?? _buildDeleteButton(),
        ],
      ),
    );
  }

  // Widget methods:------------------------------------------------------------
  Widget _buildCivilityField() {
    return getIt<RowButtonWidgetInterface>(
      param1: RowButtonProps(
        child: Text(
          'contact_civility'.tr(),
        ),
        rightChild: Row(
          children: [
            _buildCivilityRadioButton(Civility.madam),
            const SizedBox(width: 25),
            _buildCivilityRadioButton(Civility.mister),
            const SizedBox(width: 25),
            _buildCivilityRadioButton(Civility.society),
          ],
        ),
      ),
    );
  }

  Widget _buildCivilityRadioButton(Civility civility) {
    return Observer(
      builder: (_) {
        bool isActive = civility == widget.props.store.civility;

        return CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            widget.props.store.setCivility(civility);
            // If society civility is selected, we clear the first name field
            if (civility == Civility.society) {
              widget.props.store.setFirstName('');
              _firstNameController.text = widget.props.store.firstName;
            }
          },
          child: Row(
            children: [
              Text(
                'civility_${civility.name}'.tr(),
                style: TextStyle(
                  color: isActive
                      ? _appThemeData.defaultTextColor
                      : MapleCommonColors.greyLighter,
                ),
              ),
              const SizedBox(width: 5),
              getIt<RadioWidgetInterface>(param1: RadioProps(value: isActive)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNameFields() {
    return Column(
      children: [
        _buildLastNameField(),
        const Separator(),
        widget.props.store.civility != Civility.society
            ? _buildFirstNameField()
            : const SizedBox(),
      ],
    );
  }

  Widget _buildLastNameField() {
    return getIt<TextInputWidgetInterface>(
      param1: TextInputProps(
        controller: _lastNameController,
        label: 'contact_last_name'.tr(),
        labelWidth: 60,
        placeholder: 'form_required'.tr(),
        onChanged: (value) {
          widget.props.store.lastName = value;
        },
        onSubmitted: (_) =>
            FocusScope.of(context).requestFocus(_firstNameFocusNode),
      ),
    );
  }

  Widget _buildFirstNameField() {
    return getIt<TextInputWidgetInterface>(
      param1: TextInputProps(
        controller: _firstNameController,
        focusNode: _firstNameFocusNode,
        label: 'contact_first_name'.tr(),
        labelWidth: 60,
        placeholder: 'form_required'.tr(),
        onChanged: (value) {
          widget.props.store.firstName = value;
        },
        onSubmitted: (_) =>
            FocusScope.of(context).requestFocus(_phoneFocusNode),
      ),
    );
  }

  Widget _buildIsDefaultButton() {
    return Observer(
      builder: (context) => getIt<RowButtonWidgetInterface>(
        param1: RowButtonProps(
          margin: const EdgeInsets.only(bottom: 14),
          child: Text(
            'is_default'.tr(),
            style: const TextStyle(fontSize: 17),
          ),
          rightChild: CupertinoSwitch(
            value: widget.props.store.isDefault,
            activeColor: _appThemeData.activeSwitchButtonColor,
            onChanged: (value) => widget.props.store.setIsDefault(value),
          ),
        ),
      ),
    );
  }

  Widget _buildContactFields() {
    return Column(
      children: [
        _buildPhoneField(),
        const Separator(),
        _buildMobilePhoneField(),
        const Separator(),
        _buildEmailField(),
      ],
    );
  }

  Widget _buildPhoneField() {
    return getIt<TextInputWidgetInterface>(
      param1: TextInputProps(
        controller: _phoneController,
        focusNode: _phoneFocusNode,
        label: 'contact_phone'.tr(),
        labelWidth: 80,
        hasError: widget.props.store.isPhoneInvalid,
        keyboardType: TextInputType.phone,
        onChanged: (value) {
          widget.props.store.phone = value;
        },
        onSubmitted: (_) =>
            FocusScope.of(context).requestFocus(_mobilePhoneFocusNode),
      ),
    );
  }

  Widget _buildMobilePhoneField() {
    return getIt<TextInputWidgetInterface>(
      param1: TextInputProps(
        controller: _mobilePhoneController,
        focusNode: _mobilePhoneFocusNode,
        label: 'contact_mobile_phone'.tr(),
        labelWidth: 80,
        hasError: widget.props.store.isMobilePhoneInvalid,
        placeholder: 'form_required'.tr(),
        keyboardType: TextInputType.phone,
        onChanged: (value) {
          widget.props.store.mobilePhone = value;
        },
        onSubmitted: (_) =>
            FocusScope.of(context).requestFocus(_emailFocusNode),
      ),
    );
  }

  Widget _buildEmailField() {
    return getIt<TextInputWidgetInterface>(
      param1: TextInputProps(
        controller: _emailController,
        focusNode: _emailFocusNode,
        label: 'contact_email'.tr(),
        labelWidth: 80,
        hasError: widget.props.store.isEmailInvalid,
        placeholder: 'form_required'.tr(),
        onChanged: (value) {
          widget.props.store.email = value;
        },
      ),
    );
  }

  Widget _buildDeleteButton() {
    if (widget.props.store.params.contact == null) {
      return Container();
    }
    return getIt<RowButtonWidgetInterface>(
      param1: RowButtonProps(
        disableRightChild: true,
        onPressed: _showDeleteConfirmationDialog,
        child: Text(
          'contact_remove'.tr(),
          style: TextStyle(color: _appThemeData.buttonColor),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () async {
              if (widget.props.onPreDelete != null) {
                await widget
                    .props.onPreDelete!(widget.props.store.params.contact!);
              }
              widget.props.store.deleteContact();
              // ignore: use_build_context_synchronously
              Navigator.of(context)
                  .popUntil(ModalRoute.withName(_rootNavigator.mainRoute));
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

  // Dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    _lastNameController.dispose();
    _firstNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _firstNameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }
}
