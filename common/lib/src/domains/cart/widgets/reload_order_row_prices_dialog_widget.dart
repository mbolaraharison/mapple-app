import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class ReloadOrderRowPricesDialogWidgetInterface implements Widget {
  ReloadOrderRowPricesDialogProps get props;
}

// Props:----------------------------------------------------------------------
class ReloadOrderRowPricesDialogProps {
  ReloadOrderRowPricesDialogProps({
    this.orderRow,
    required this.service,
    required this.customerOrderStore,
    required this.onDelete,
  });

  final OrderRow? orderRow;
  final Service service;
  final CustomerOrderStoreInterface customerOrderStore;
  final void Function()? onDelete;
}

// Implementation:--------------------------------------------------------------
class ReloadOrderRowPricesDialog extends StatefulWidget
    implements ReloadOrderRowPricesDialogWidgetInterface {
  // Constructor:---------------------------------------------------------------
  const ReloadOrderRowPricesDialog({
    super.key,
    required this.props,
  });

  @override
  final ReloadOrderRowPricesDialogProps props;

  @override
  State<ReloadOrderRowPricesDialog> createState() =>
      _ReloadOrderRowPricesDialogState();
}

class _ReloadOrderRowPricesDialogState
    extends State<ReloadOrderRowPricesDialog> {
  late final ServiceDialogStoreInterface _store;

  // Lifecycle methods:---------------------------------------------------------
  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    _store = getIt<ServiceDialogStoreInterface>(
        param1: ServiceDialogStoreParams(
      orderRow: widget.props.orderRow,
      service: widget.props.service,
    ));
    await _store.init();
    _store.findPriceList();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      String mainDescription = _store.priceListItem != null
          ? 'cart.reload-prices.description'.tr()
          : 'cart.reload-prices.delete-description'.tr();
      String dialogContent =
          '$mainDescription\n${'cart.reload-prices.old-price'.tr(namedArgs: {
            'oldPrice': widget.props.orderRow!.grossPrice.toStringAsFixed(2)
          })}';
      if (_store.priceListItem != null) {
        dialogContent += '\n${'cart.reload-prices.new-price'.tr(namedArgs: {
              'newPrice': _store.priceListItem!.price.toStringAsFixed(2)
            })}';
      }
      return CupertinoAlertDialog(
        title: Text('cart.reload-prices.title'.tr()),
        content: Text(
          dialogContent,
          style: const TextStyle(fontSize: 16),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: widget.props.onDelete,
            child: SizedBox(
              width: 177,
              child: Text('delete'.tr()),
            ),
          ),
          if (_store.priceListItem != null)
            CupertinoDialogAction(
              onPressed: _reloadPrices,
              child: Text('reload'.tr()),
            )
        ],
      );
    });
  }

  // Methods:-------------------------------------------------------------------
  Future<void> _reloadPrices() async {
    widget.props.orderRow!.grossPrice = _store.service.isMiscellanous == true
        ? _store.grossPriceWithoutTaxMiscellaneousValue.toDouble()
        : _store.priceListItem?.price.toDouble() ?? 0;
    widget.props.orderRow!.priceListItemId =
        _store.service.isMiscellanous == true ? null : _store.priceListItem?.id;
    widget.props.orderRow!.unit = _store.service.getUnit(_store.priceListItem);

    widget.props.customerOrderStore.orderStepStore
        .updateOrderRow(widget.props.orderRow!);

    widget.props.customerOrderStore.resetCartStatus();

    Navigator.pop(context);

    Fluttertoast.showToast(
        msg: 'cart.edit_order_row_confirm_message'.tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  void dispose() {
    _store.dispose();
    super.dispose();
  }
}
