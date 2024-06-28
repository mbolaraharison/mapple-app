import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:maple_common/maple_common.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class CartOrderWidgetInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class CartOrder extends StatefulWidget implements CartOrderWidgetInterface {
  const CartOrder({super.key});

  @override
  State<CartOrder> createState() => _CartOrderState();
}

class _CartOrderState extends State<CartOrder> {
  // Stores:--------------------------------------------------------------------
  late final CustomerOrderStoreInterface _customerOrderStore;

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _customerOrderStore = context.read<CustomerOrderStoreInterface>();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return _customerOrderStore.orderStepStore.isLoading
          ? Container()
          : Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 20, left: 35, right: 35),
              color: CupertinoColors.extraLightBackgroundGray,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'cart.detail_of_the_order'.tr(),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: _appThemeData.defaultTextColor,
                    ),
                  ),
                  const SizedBox(height: 7),
                  getIt<SeparatorWidgetInterface>(
                    param1: SeparatorProps(
                      color: CupertinoColors.opaqueSeparator.withOpacity(.5),
                    ),
                  ),
                  const SizedBox(height: 17),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildRowsCard(),
                        const SizedBox(width: 20),
                        _buildTotalCard(),
                      ],
                    ),
                  ),
                ],
              ),
            );
    });
  }

  // Widgets methods:-----------------------------------------------------------
  Widget _buildRowsCard() {
    return Expanded(
      flex: 5,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: !_customerOrderStore.order.isReadonly
              ? CupertinoColors.white
              : MapleCommonColors.disabledBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        child: CupertinoScrollbar(
          child: Observer(builder: (_) {
            return SlidableAutoCloseBehavior(
              child: ListView.builder(
                itemCount: _customerOrderStore.orderStepStore.orderRows.length,
                itemBuilder: (context, index) {
                  return _buildRowItem(index);
                },
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildRowItem(int index) {
    OrderRow row = _customerOrderStore.orderStepStore.orderRows[index];

    List<Widget> children = [
      const SizedBox(height: 15),
      Padding(
        padding: const EdgeInsets.only(right: 18),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  row.service?.label ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _appThemeData.defaultTextColor,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 5),
                row.option1 != null
                    ? Row(
                        children: [
                          Text(
                            '${'services.options.option1'.tr()} : ',
                            style: const TextStyle(
                              color: MapleCommonColors.greyLighter,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            row.option1!.label,
                            style: TextStyle(
                              color: _appThemeData.infoTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
                row.option2 != null
                    ? Row(
                        children: [
                          Text(
                            '${'services.options.option2'.tr()} : ',
                            style: const TextStyle(
                              color: MapleCommonColors.greyLighter,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            row.option2!.label,
                            style: TextStyle(
                              color: _appThemeData.infoTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
                const SizedBox(height: 10),
                Text(
                  '${'cart.without_vat'.tr()} ${row.formattedGrossPrice} | ${'cart.vat'.tr()} ${row.formattedTaxLevel}%',
                  style: const TextStyle(
                    color: MapleCommonColors.greyLighter,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      '${'cart.quantity'.tr()} (${row.getUnitLabel()}): ${row.quantity}${row.isPackagePrice ? ' ${'cart.is_package_price'.tr()}' : ''}',
                      style: TextStyle(
                        color: _appThemeData.defaultTextColor,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 32),
                    row.discount != null
                        ? Text.rich(
                            TextSpan(
                              text: '${'cart.discount'.tr()}: ',
                              style: TextStyle(
                                color: _appThemeData.defaultTextColor,
                                fontSize: 14,
                              ),
                              children: [
                                TextSpan(
                                  text: _customerOrderStore.orderStepStore
                                      .orderRows[index].formattedDiscount,
                                  style: TextStyle(
                                    color: _appThemeData.infoTextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
                const SizedBox(height: 12),
                row.supplier != null
                    ? Text(
                        '${'cart.supplier_by'.tr()} ${row.supplier?.name} ${row.withWorkforce ? 'cart.workforce_included'.tr() : ''}',
                        style: const TextStyle(
                          color: MapleCommonColors.greyLighter,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (_customerOrderStore.order.isReadonly || !row.isReadonly)
                      Text(
                        '${row.discount != null ? row.formattedTotalNetInclTax : row.formattedTotalGrossInclTax} ${'cart.with_vat'.tr()}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _appThemeData.defaultTextColor,
                        ),
                      ),
                    const SizedBox(width: 5),
                    Icon(
                      CupertinoIcons.chevron_right,
                      color: CupertinoColors.opaqueSeparator.withOpacity(.5),
                      size: 17,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 28),
    ];

    if (index != _customerOrderStore.orderStepStore.orderRows.length - 1) {
      children.add(
        getIt<SeparatorWidgetInterface>(
          param1: SeparatorProps(
            color: CupertinoColors.opaqueSeparator.withOpacity(.5),
          ),
        ),
      );
    }

    double rowHeight = 125;
    if (row.option1 != null) rowHeight += 17;
    if (row.option2 != null) rowHeight += 17;

    return Observer(
      builder: (_) => Stack(children: [
        Slidable(
          groupTag: '0',
          enabled: !_customerOrderStore.order.isReadonly,
          endActionPane: ActionPane(
            extentRatio: row.discount != null ? 0.7 : 0.35,
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                label: 'cart.edit_order_row'.tr(),
                icon: CupertinoIcons.pencil,
                backgroundColor: MapleCommonColors.orange,
                foregroundColor: CupertinoColors.white,
                onPressed: (_) => _showOrderRowEditDialog(row),
                padding: const EdgeInsets.symmetric(horizontal: 2),
              ),
              if (row.discount != null)
                SlidableAction(
                  label: 'cart.delete_discount'.tr(),
                  icon: CupertinoIcons.tag,
                  backgroundColor: MapleCommonColors.red,
                  foregroundColor: CupertinoColors.white,
                  onPressed: (_) =>
                      _customerOrderStore.orderStepStore.removeDiscount(row),
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                ),
              SlidableAction(
                label: 'cart.delete_service'.tr(),
                icon: CupertinoIcons.trash,
                backgroundColor: CupertinoColors.destructiveRed,
                foregroundColor: CupertinoColors.white,
                onPressed: (_) => _showDeleteItemDialog(index),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.only(left: 21),
            child: Column(children: children),
          ),
        ),
        if (!_customerOrderStore.order.isReadonly && row.isReadonly)
          Container(
            alignment: AlignmentDirectional.centerEnd,
            height: rowHeight,
            width: double.infinity,
            padding: const EdgeInsets.only(right: 30),
            color: MapleCommonColors.disabledBackground.withOpacity(0.6),
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _showPriceWarningsDialog(index, row),
              child: const Icon(
                CupertinoIcons.exclamationmark_triangle,
                size: 45,
                color: MapleCommonColors.red,
              ),
            ),
          ),
      ]),
    );
  }

  Widget _buildTotalCard() {
    return Expanded(
      flex: 4,
      child: Container(
        height: 230,
        padding: const EdgeInsets.all(21),
        decoration: BoxDecoration(
          color: !_customerOrderStore.order.isReadonly
              ? CupertinoColors.white
              : MapleCommonColors.disabledBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Observer(builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'cart.total'.tr(),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: _appThemeData.defaultTextColor,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'cart.total_services'.tr(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    _customerOrderStore.order.formattedTotalGrossInclTax,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              if (_customerOrderStore.order.totalDiscount > 0)
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('cart.total_discounts'.tr(),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: _appThemeData.infoTextColor,
                          )),
                      Text(
                          '- ${_customerOrderStore.order.formattedTotalDiscount}',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            color: _appThemeData.infoTextColor,
                          )),
                    ],
                  ),
                ),
              const SizedBox(height: 15),
              getIt<SeparatorWidgetInterface>(
                param1: SeparatorProps(
                  color: CupertinoColors.opaqueSeparator.withOpacity(.5),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'cart.total_with_vat'.tr(),
                    style: const TextStyle(
                      color: CupertinoColors.activeGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _customerOrderStore.order.formattedTotalNetInclTax,
                    style: const TextStyle(
                      color: CupertinoColors.activeGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }

  void _showPriceWarningsDialog(int index, OrderRow orderRow) {
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) =>
          getIt<ReloadOrderRowPricesDialogWidgetInterface>(
        param1: ReloadOrderRowPricesDialogProps(
            orderRow: orderRow,
            service: orderRow.service!,
            customerOrderStore: _customerOrderStore,
            onDelete: () {
              _showDeleteItemDialog(index);
            }),
      ),
    );
  }

  void _showDeleteItemDialog(int index) {
    OrderRow orderRow = _customerOrderStore.orderStepStore.orderRows[index];
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text('cart.delete-item.title'.tr()),
        content: Text(
          'cart.delete-item.dialog-content'.tr(
            namedArgs: {'name': orderRow.service!.label},
          ),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              _customerOrderStore.orderStepStore.removeOrderRowByIndex(index);
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: SizedBox(
              width: 177,
              child: Text('delete'.tr()),
            ),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('cancel'.tr()),
          )
        ],
      ),
    );
  }

  Future<void> _showOrderRowEditDialog(OrderRow orderRow) async {
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (context) => getIt<ServiceDialogWidgetInterface>(
        param1: ServiceDialogProps(
          orderRow: orderRow,
          service: orderRow.service!,
          customerOrderStore: _customerOrderStore,
        ),
      ),
    );
  }
}
