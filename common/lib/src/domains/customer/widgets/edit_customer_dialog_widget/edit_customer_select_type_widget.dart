import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class EditCustomerSelectTypeWidgetInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class EditCustomerSelectType extends StatefulWidget
    implements EditCustomerSelectTypeWidgetInterface {
  const EditCustomerSelectType({super.key});

  @override
  State<EditCustomerSelectType> createState() => _EditCustomerSelectTypeState();
}

class _EditCustomerSelectTypeState extends State<EditCustomerSelectType> {
  // Lifecycle methods:---------------------------------------------------------
  late final EditCustomerDialogStoreInterface _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<EditCustomerDialogStoreInterface>(context);
  }

  // Lifecycle methods:----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return getIt<DialogContentWrapperWidgetInterface>(
      param1: DialogContentWrapperProps(
        header: _buildHeader(),
        child: Column(
          children: [
            const SizedBox(height: 39),
            _buildSelect(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return getIt<DialogHeaderWidgetInterface>(
      param1: DialogHeaderProps(
        leftContent: CupertinoButton(
          onPressed: () => Navigator.pop(context),
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
          'customer_type_title'.tr(),
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
      ),
    );
  }

  Widget _buildSelect() {
    return Observer(
      builder: (context) {
        return getIt<SelectWidgetInterface<CustomerType>>(
          param1: SelectProps<CustomerType>(
            value: _store.customerType,
            onChanged: (value) {
              _store.setCustomerType(value!);
            },
            choices: CustomerType.choices,
          ),
        );
      },
    );
  }
}
