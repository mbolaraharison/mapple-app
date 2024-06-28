import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class SuppliersDialogWidgetInterface implements Widget {
  SuppliersDialogProps get props;
}

// Props:-----------------------------------------------------------------------
class SuppliersDialogProps {
  final CustomerOrderStoreInterface customerOrderStore;

  SuppliersDialogProps({
    required this.customerOrderStore,
  });
}

// Implementation:--------------------------------------------------------------
class SuppliersDialog extends StatelessWidget
    implements SuppliersDialogWidgetInterface {
  SuppliersDialog({super.key, required this.props});

  // Props:---------------------------------------------------------------------
  @override
  final SuppliersDialogProps props;

  // Stores:--------------------------------------------------------------------
  final SuppliersDialogStoreInterface store =
      getIt<SuppliersDialogStoreInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    store.setRows(props.customerOrderStore.orderStepStore.orderRows);

    return getIt<DialogWrapperWidgetInterface>(
      param1: DialogWrapperProps(
        width: 712,
        height: 693,
        header: _buildHeader(context),
        child: _buildContent(),
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
            onPressed: () => Navigator.pop(context),
          ),
          middleContent: Text(
            'cart.suppliers_dialog.title'.tr(),
            style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
          ),
          rightContent: CupertinoButton(
            onPressed: () => _onSubmit(context),
            child: Text(
              'ok'.tr().toUpperCase(),
              style: DialogHeaderWidgetInterface.sideDefaultTextStyle
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          )),
    );
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 33),
      child: Column(
        children: [
          Observer(builder: (_) => _buildServicesList()),
        ],
      ),
    );
  }

  Widget _buildServicesList() {
    List<Widget> children = [];

    for (var i = 0; i <= store.rows.length - 1; i++) {
      if (i != 0) {
        children.add(const SizedBox(height: 20));
      }

      children.add(getIt<ServiceWithSupplierWidgetInterface>(
        param1: ServiceWithSupplierProps(
          row: store.rows[i],
          store: store.stores[i],
          isLast: i == store.rows.length - 1,
        ),
      ));
      if (i < store.rows.length - 1) {
        children.add(
          getIt<SeparatorWidgetInterface>(),
        );
      }
    }

    return Container(
      padding: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [...children],
      ),
    );
  }

  // General methods:-----------------------------------------------------------
  void _onSubmit(BuildContext context) {
    props.customerOrderStore.orderStepStore.applySuppliers(store.mergeRows());
    Navigator.of(context).pop();
  }
}
