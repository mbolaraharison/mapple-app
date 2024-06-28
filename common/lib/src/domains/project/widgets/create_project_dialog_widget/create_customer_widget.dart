import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class CreateCustomerWidgetInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class CreateCustomer extends StatefulWidget
    implements CreateCustomerWidgetInterface {
  const CreateCustomer({super.key});

  @override
  State<CreateCustomer> createState() => _CreateCustomerState();
}

class _CreateCustomerState extends State<CreateCustomer> {
  // Controllers:---------------------------------------------------------------
  final TextEditingController _houseAgeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  // Stores:--------------------------------------------------------------------
  late CreateProjectDialogStoreInterface _store;

  // Navigators:----------------------------------------------------------------
  final CreateProjectNavigatorInterface _navigator =
      getIt<CreateProjectNavigatorInterface>();

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<CreateProjectDialogStoreInterface>(context);
    _houseAgeController.text =
        getIt<StringUtilsInterface>().parse(_store.houseAge);
    _nameController.text = _store.customerName;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => getIt<DialogContentWrapperWidgetInterface>(
        param1: DialogContentWrapperProps(
          header: _buildHeader(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              getIt<CreateProjectDialogTitleWidgetInterface>(
                param1: CreateProjectDialogTitleProps(
                  title: 'home_create_project_dialog_create_customer'.tr(),
                  step: 2,
                ),
              ),
              _buildNameField(),
              _buildAddressFields(),
              const SizedBox(height: 15),
              _buildHowFindUs(),
              const SizedBox(height: 15),
              _buildAgeField(),
              const SizedBox(height: 15),
              _buildIsProPremise(),
            ],
          ),
        ),
      ),
    );
  }

  // Widgets methods:-----------------------------------------------------------
  Widget _buildHeader() {
    return getIt<DialogHeaderWidgetInterface>(
      param1: DialogHeaderProps(
        leftContent: CupertinoButton(
          onPressed: () => Navigator.pop(context),
          child: SizedBox(
            width: 100,
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
                    color:
                        DialogHeaderWidgetInterface.sideDefaultTextStyle.color,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
        ),
        middleContent: Text(
          'home_create_project_dialog_title'.tr(),
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
        rightContent: CupertinoButton(
          onPressed: _store.createCustomerIsValid ? _onPressedNext : null,
          child: Text(
            'next'.tr(),
            style: _store.createCustomerIsValid
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

  Widget _buildNameField() {
    return getIt<TextInputWidgetInterface>(
      param1: TextInputProps(
        controller: _nameController,
        margin: const EdgeInsets.only(bottom: 15),
        label: 'home_create_project_dialog_customer_name_placeholder'.tr(),
        placeholder: 'form_required'.tr(),
        onChanged: (value) => _store.customerName = value,
      ),
    );
  }

  Widget _buildAddressFields() {
    List<Widget> children = [];
    List<RowButtonItem> rowButtonItems = [];
    const TextStyle textStyle = TextStyle(color: CupertinoColors.inactiveGray);

    children.add(
      getIt<RowButtonWidgetInterface>(
        param1: RowButtonProps(
          onPressed: _onPressedAddress,
          child: Text(
            'address'.tr(),
          ),
        ),
      ),
    );

    if (_store.customerAddress.isNotEmpty) {
      rowButtonItems.add(
        RowButtonItem(
          label: _store.customerAddress,
          textStyle: textStyle,
        ),
      );
    }

    if (_store.customerCity.isNotEmpty) {
      rowButtonItems.add(
        RowButtonItem(
          label: _store.customerCity,
          textStyle: textStyle,
        ),
      );
    }

    if (_store.customerPostalCode.isNotEmpty) {
      rowButtonItems.add(
        RowButtonItem(
          label: _store.customerPostalCode,
          textStyle: textStyle,
        ),
      );
    }

    if (rowButtonItems.isNotEmpty) {
      children.add(const SizedBox(height: 15));
      children.add(
        getIt<RowButtonGroupWidgetInterface>(
          param1: RowButtonGroupProps(items: rowButtonItems),
        ),
      );
    }

    return Column(
      children: children,
    );
  }

  _buildHowFindUs() {
    return getIt<RowButtonWidgetInterface>(
      param1: RowButtonProps(
        value: _store.customerOriginDetails != null
            ? _store.customerOriginDetails!.label
            : '',
        onPressed: _onPressedHowFindUs,
        child: Text(
          'home_create_project_dialog_how_find_us'.tr(),
        ),
      ),
    );
  }

  Widget _buildAgeField() {
    return getIt<TextInputWithLabelWidgetInterface>(
      param1: TextInputWithLabelProps(
        label: 'project.view.data.house_age'.tr(),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        controller: _houseAgeController,
        onChanged: (value) {
          if (value.isEmpty) {
            _store.setHouseAge(0);
          } else {
            _store.setHouseAge(int.parse(value));
          }
        },
      ),
    );
  }

  Widget _buildIsProPremise() {
    return getIt<RowButtonWidgetInterface>(
      param1: RowButtonProps(
        margin: const EdgeInsets.only(bottom: 14),
        child: Text(
          'project.view.data.is_pro_premise'.tr(),
          style: TextStyle(fontSize: 17, color: _appThemeData.defaultTextColor),
        ),
        rightChild: CupertinoSwitch(
          value: _store.isProPremise,
          activeColor: getIt<AppThemeDataInterface>().activeSwitchButtonColor,
          onChanged: (value) {
            _store.setIsProPremise(value);
          },
        ),
      ),
    );
  }

  // General methods:-----------------------------------------------------------
  void _onPressedNext() {
    FocusManager.instance.primaryFocus?.unfocus();
    _navigator.key.currentState!.pushNamed(_navigator.contactsRoute);
  }

  void _onPressedHowFindUs() {
    FocusManager.instance.primaryFocus?.unfocus();
    _navigator.key.currentState!.pushNamed(_navigator.howFindUsRoute);
  }

  void _onPressedAddress() {
    FocusManager.instance.primaryFocus?.unfocus();
    _navigator.key.currentState!.pushNamed(
      _navigator.addressRoute,
      arguments: SelectAddressArguments(store: _store),
    );
  }

  // Dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    super.dispose();
  }
}
