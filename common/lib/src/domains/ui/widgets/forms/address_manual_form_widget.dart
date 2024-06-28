import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';

// Interface:-------------------------------------------------------------------
abstract class AddressManualFormWidgetInterface implements Widget {
  AddressManualFormProps get props;
}

// Props:-----------------------------------------------------------------------
class AddressManualFormProps {
  const AddressManualFormProps({
    required this.address,
    required this.onSelected,
    required this.onBackToAutoMode,
  });

  final String address;
  final Function(AddressDTO?) onSelected;
  final Function(String) onBackToAutoMode;
}

// Implementation:--------------------------------------------------------------
class AddressManualForm extends StatefulWidget
    implements AddressManualFormWidgetInterface {
  const AddressManualForm({
    super.key,
    required this.props,
  });

  @override
  final AddressManualFormProps props;

  @override
  State<AddressManualForm> createState() => _AddressManualFormState();
}

class _AddressManualFormState extends State<AddressManualForm> {
  // Text controllers:----------------------------------------------------------
  late final TextEditingController _addressController;
  late final TextEditingController _cityController = TextEditingController();
  late final TextEditingController _postalCodeController;

  // Focus nodes:---------------------------------------------------------------
  late final FocusNode _addressFocusNode = FocusNode();
  late final FocusNode _postalCodeFocusNode = FocusNode();
  late final FocusNode _cityFocusNode = FocusNode();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _initFields();
  }

  // Build method:--------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAddressField(),
        getIt<SeparatorWidgetInterface>(),
        _buildPostalCodeField(),
        getIt<SeparatorWidgetInterface>(),
        _buildCityField(),
        const SizedBox(height: 15),
        _buildSaveButton(),
      ],
    );
  }

  // Widget methods:------------------------------------------------------------
  Widget _buildAddressField() {
    return getIt<TextInputWidgetInterface>(
      param1: TextInputProps(
        controller: _addressController,
        focusNode: _addressFocusNode,
        placeholder: 'address'.tr(),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(5.0)),
        autofocus: true,
        suffix: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(
            CupertinoIcons.refresh,
            color: CupertinoColors.systemBlue,
          ),
          onPressed: () =>
              widget.props.onBackToAutoMode(_addressController.text),
        ),
        onSubmitted: (_) {
          FocusScope.of(context).requestFocus(_postalCodeFocusNode);
        },
      ),
    );
  }

  Widget _buildPostalCodeField() {
    return getIt<TextInputWidgetInterface>(
      param1: TextInputProps(
        controller: _postalCodeController,
        focusNode: _postalCodeFocusNode,
        placeholder: 'postal_code'.tr(),
        borderRadius: const BorderRadius.all(Radius.zero),
        onSubmitted: (_) {
          FocusScope.of(context).requestFocus(_cityFocusNode);
        },
      ),
    );
  }

  Widget _buildCityField() {
    return getIt<TextInputWidgetInterface>(
      param1: TextInputProps(
        controller: _cityController,
        focusNode: _cityFocusNode,
        margin: const EdgeInsets.only(bottom: 15),
        placeholder: 'city'.tr(),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(5.0)),
      ),
    );
  }

  Widget _buildSaveButton() {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: const Text('save').tr(),
      onPressed: () {
        widget.props.onSelected(
          AddressDTO(
            address: _addressController.text,
            city: _cityController.text,
            postalCode: _postalCodeController.text,
          ),
        );
      },
    );
  }

  // General methods:-----------------------------------------------------------
  void _initFields() {
    final RegExp regex = RegExp(r'\d{5}');
    final String? postalCode = regex.firstMatch(widget.props.address)?.group(0);
    final String addressWithoutPostalCode = postalCode != null
        ? widget.props.address.replaceAll(postalCode, '')
        : widget.props.address;
    _addressController = TextEditingController(text: addressWithoutPostalCode);
    _postalCodeController = TextEditingController(text: postalCode);
  }

  // Dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    _addressFocusNode.dispose();
    _postalCodeFocusNode.dispose();
    _cityFocusNode.dispose();
    super.dispose();
  }
}
