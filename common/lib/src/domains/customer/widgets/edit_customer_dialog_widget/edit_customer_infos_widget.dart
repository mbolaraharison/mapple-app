import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class EditCustomerInfosWidgetInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class EditCustomerInfos extends StatefulWidget
    implements EditCustomerInfosWidgetInterface {
  const EditCustomerInfos({super.key});

  @override
  State<EditCustomerInfos> createState() => _EditCustomerInfosState();
}

class _EditCustomerInfosState extends State<EditCustomerInfos> {
  // Controllers:---------------------------------------------------------------
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  // Stores:--------------------------------------------------------------------
  late final EditCustomerDialogStoreInterface _store;

  // Navigators:----------------------------------------------------------------
  late final RootNavigatorInterface _rootNavigator =
      getIt<RootNavigatorInterface>();
  late final EditCustomerDialogNavigatorInterface _navigator =
      getIt<EditCustomerDialogNavigatorInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _store =
        Provider.of<EditCustomerDialogStoreInterface>(context, listen: false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _nameController.text = _store.name;
    _addressController.text = _store.address;
    _postalCodeController.text = _store.postalCode;
    _cityController.text = _store.city;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => getIt<DialogContentWrapperWidgetInterface>(
        param1: DialogContentWrapperProps(
          header: _buildHeader(),
          child: Column(
            children: [
              const SizedBox(
                height: 39,
              ),
              getIt<TextInputWithLabelWidgetInterface>(
                param1: TextInputWithLabelProps(
                  label: 'name'.tr(),
                  controller: _nameController,
                  onChanged: (value) => _store.setName(value),
                ),
              ),
              const SizedBox(
                height: 19,
              ),
              getIt<RowButtonWidgetInterface>(
                param1: RowButtonProps(
                  value: _store.customerType.label,
                  onPressed: () {
                    _navigator.key.currentState
                        ?.pushNamed(_navigator.selectType);
                  },
                  child: Text('customer_type_title'.tr()),
                ),
              ),
              const SizedBox(
                height: 19,
              ),
              getIt<TextInputWithLabelWidgetInterface>(
                param1: TextInputWithLabelProps(
                  label: 'address'.tr(),
                  controller: _addressController,
                  onChanged: (value) => _store.setAddress(value),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              getIt<TextInputWithLabelWidgetInterface>(
                param1: TextInputWithLabelProps(
                  label: 'postal_code'.tr(),
                  controller: _postalCodeController,
                  onChanged: (value) => _store.setPostalCode(value),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              getIt<TextInputWithLabelWidgetInterface>(
                param1: TextInputWithLabelProps(
                  label: 'city'.tr(),
                  controller: _cityController,
                  onChanged: (value) => _store.setCity(value),
                ),
              ),
              const SizedBox(
                height: 19,
              ),
              getIt<RowButtonWidgetInterface>(
                param1: RowButtonProps(
                  value: _store.originWithDetails,
                  onPressed: () {
                    _navigator.key.currentState
                        ?.pushNamed(_navigator.selectOrigin);
                  },
                  child: Text('customer_how_did_you_know_us'.tr()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return getIt<DialogHeaderWidgetInterface>(
      param1: DialogHeaderProps(
        leftContent: CupertinoButton(
          onPressed: () {
            _store.reset();
            _rootNavigator.key.currentState?.pop();
          },
          child: Row(
            children: [
              Icon(
                CupertinoIcons.chevron_left,
                color: DialogHeaderWidgetInterface.sideDefaultTextStyle.color,
                size: 22,
              ),
              Text(
                'cancel'.tr(),
                style: TextStyle(
                  color: DialogHeaderWidgetInterface.sideDefaultTextStyle.color,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
        middleContent: Text(
          'customer_view_edit_title'.tr(),
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
        rightContent: CupertinoButton(
          onPressed: () {
            _store.updateCustomer();
            _rootNavigator.key.currentState?.pop();
          },
          child: Text(
            'ok'.tr().toUpperCase(),
            style: TextStyle(
              color: DialogHeaderWidgetInterface.sideDefaultTextStyle.color,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
