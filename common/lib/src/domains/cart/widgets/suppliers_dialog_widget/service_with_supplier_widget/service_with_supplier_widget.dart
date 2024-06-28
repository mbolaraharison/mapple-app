import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class ServiceWithSupplierWidgetInterface implements Widget {
  ServiceWithSupplierProps get props;
}

// Props:-----------------------------------------------------------------------
class ServiceWithSupplierProps {
  const ServiceWithSupplierProps({
    required this.row,
    required this.store,
    required this.isLast,
  });

  final OrderRow row;
  final ServiceWithSupplierStoreInterface store;
  final bool isLast;
}

// Themes:--------------------------------------------------------------------
final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

// Implementation:--------------------------------------------------------------
class ServiceWithSupplier extends StatelessWidget
    implements ServiceWithSupplierWidgetInterface {
  const ServiceWithSupplier({super.key, required this.props});

  // Props
  @override
  final ServiceWithSupplierProps props;

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      onPressed: () => _showSupplierSelectModalPopUp(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildServiceField(),
              const SizedBox(height: 10),
              _buildSupplierField(),
              _buildWithWorkforceSwitch(),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildServiceField() {
    return Text(
      props.store.getService(),
      style: TextStyle(
        color: _appThemeData.defaultTextColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildSupplierField() {
    return Observer(builder: (_) {
      return Text(
        '${'cart.suppliers_dialog.title'.tr()} : ${props.store.supplierName ?? ''}',
        style: TextStyle(
          color: _appThemeData.defaultTextColor,
        ),
      );
    });
  }

  Widget _buildWithWorkforceSwitch() {
    return Observer(builder: (_) {
      if (props.store.withWorkforce) {
        return Row(
          children: [
            Text('cart.suppliers_dialog.workforce'.tr(),
                style: TextStyle(
                  color: _appThemeData.defaultTextColor,
                )),
            const SizedBox(width: 10),
            CupertinoSwitch(
              value: props.store.withWorkforce,
              activeColor: _appThemeData.activeSwitchButtonColor,
              onChanged: null,
            ),
          ],
        );
      } else {
        return Container();
      }
    });
  }

  void _showSupplierSelectModalPopUp(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => getIt<SelectSupplierDialogWidgetInterface>(
              param1: SelectSupplierDialogProps(
                label: props.store.getService(),
                supplierValue: props.store.supplierId,
                withWorkforceValue: props.store.withWorkforce,
                choices: props.store.choices,
                onChanged: (value) => {
                  props.store.setSupplier(value.supplierValue),
                  props.store.setWithWorkforce(value.withWorkforceValue),
                },
              ),
            ));
  }
}
