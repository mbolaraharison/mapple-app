import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class CartFinalizationWidgetInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class CartFinalization extends StatefulWidget
    implements CartFinalizationWidgetInterface {
  const CartFinalization({super.key});

  @override
  State<CartFinalization> createState() => _CartFinalizationState();
}

class _CartFinalizationState extends State<CartFinalization> {
  // Stores:--------------------------------------------------------------------
  late final CustomerOrderStoreInterface _customerOrderStore;

  // Variables:-----------------------------------------------------------------
  late final void Function(dynamic) _showDatesErrorDialog;

  // Services:------------------------------------------------------------------
  final ContactServiceInterface _contactService =
      getIt<ContactServiceInterface>();
  final RepresentativeServiceInterface _representativeService =
      getIt<RepresentativeServiceInterface>();

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _customerOrderStore = context.read<CustomerOrderStoreInterface>();
    _showDatesErrorDialog = context.read<void Function(dynamic)>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_customerOrderStore.order.status == OrderStatus.Z &&
          _customerOrderStore.order.cartStatus != CartStatus.finalization &&
          (!_customerOrderStore.finalizationStepStore.isInstallAtUpToDate ||
              !_customerOrderStore
                  .finalizationStepStore.isEndProjectAtUpToDate)) {
        _showDatesErrorDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 46),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(MapleCommonAssets.cartFinalizationBanner),
                fit: BoxFit.cover,
              ),
            ),
            child: _buildSignatoryButtons(),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.only(left: 46, right: 46),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDatesSection(),
                const SizedBox(height: 10),
                _buildTotalsSection(),
                const SizedBox(height: 10),
                _buildKeepEquipment(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSignatoryButtons() {
    return Row(
      children: [
        _buildCustomerContactSignatoryGroup(),
        const SizedBox(
          width: 143,
        ),
        _buildRepresentativeSignatoryGroup(
          _customerOrderStore.finalizationStepStore.selectedReps,
        ),
      ],
    );
  }

  Widget _buildCustomerContactSignatoryGroup() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'cart.finalization.customer_signatory'.tr(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        const SizedBox(
          height: 28,
        ),
        StreamBuilder<List<Contact>>(
          stream: _contactService.getByIdsAsStream(
              _customerOrderStore.finalizationStepStore.selectedContactValues),
          builder:
              (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
            if (snapshot.hasData == false) {
              return Container();
            }

            return getIt<SelectCustomerSignatoriesWidgetInterface>(
              param1: SelectCustomerSignatoriesProps(
                avatarBgColor: _appThemeData.cartFinalizationAvatarBgColor,
                avatarInitialsColor:
                    _appThemeData.cartFinalizationAvatarInitialsColor,
                customerOrderStore: _customerOrderStore,
                list: snapshot.data!,
                onAvatarPressed: _showEditCustomerContactModalPopup,
                onEditPressed: _showCustomerContactModalPopup,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRepresentativeSignatoryGroup(
      List<Representative> signatoryList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'cart.finalization.rep_signatory'.tr(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        const SizedBox(
          height: 28,
        ),
        StreamBuilder<List<Representative>>(
          stream: _representativeService.getByIdsAsStream(
              _customerOrderStore.finalizationStepStore.selectedRepValues),
          builder: (BuildContext context,
              AsyncSnapshot<List<Representative>> snapshot) {
            if (snapshot.hasData == false) {
              return Container();
            }

            return getIt<SelectCustomerSignatoriesWidgetInterface>(
              param1: SelectCustomerSignatoriesProps(
                customerOrderStore: _customerOrderStore,
                list: snapshot.data!,
                avatarInitialsColor: _appThemeData.defaultTextColor,
                onEditPressed: _showRepModalPopup,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDatesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'cart.finalization.dates.installation_date'.tr(),
                  style: TextStyle(
                    color: _appThemeData.defaultTextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                const Divider(),
                getIt<RowButtonWidgetInterface>(
                  param1: RowButtonProps(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    margin: const EdgeInsets.only(bottom: 14),
                    width: 276,
                    value: _customerOrderStore
                        .finalizationStepStore.formattedInstallAt,
                    valueColor: _customerOrderStore.order.isReadonly
                        ? CupertinoColors.inactiveGray
                        : _appThemeData.cartFinalizationDateContentsColor,
                    disable: _customerOrderStore.order.isReadonly,
                    onPressed: () {
                      DateTime now = DateTime.now();
                      DateTime nowAfter15days =
                          DateTime(now.year, now.month, now.day)
                              .add(const Duration(days: 16));
                      if (_customerOrderStore.finalizationStepStore.installAt ==
                          null) {
                        _customerOrderStore.finalizationStepStore
                            .setInstallationAt(nowAfter15days);
                      }
                      if (_customerOrderStore.finalizationStepStore.installAt
                              ?.isBefore(nowAfter15days) ==
                          true) {
                        _customerOrderStore.finalizationStepStore
                            .setInstallationAt(nowAfter15days);
                      }
                      _showDialog(
                        CupertinoDatePicker(
                          initialDateTime: _customerOrderStore
                              .finalizationStepStore.installAt,
                          minimumDate: nowAfter15days,
                          mode: CupertinoDatePickerMode.date,
                          // This is called when the user changes the dateTime.
                          onDateTimeChanged: (DateTime newDateTime) {
                            _customerOrderStore.finalizationStepStore
                                .setInstallationAt(newDateTime);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'cart.finalization.dates.project_end_date'.tr(),
                  style: TextStyle(
                    color: _appThemeData.defaultTextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                const Divider(),
                getIt<RowButtonWidgetInterface>(
                  param1: RowButtonProps(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    margin: const EdgeInsets.only(bottom: 14),
                    width: 276,
                    value: _customerOrderStore
                        .finalizationStepStore.formattedEndProjectAt,
                    valueColor: _customerOrderStore.order.isReadonly
                        ? CupertinoColors.inactiveGray
                        : _appThemeData.cartFinalizationDateContentsColor,
                    disable: _customerOrderStore.order.isReadonly,
                    onPressed: () {
                      DateTime now = DateTime.now();
                      DateTime nowAfter1year =
                          DateTime(now.year + 1, now.month, now.day);
                      if (_customerOrderStore
                              .finalizationStepStore.endProjectAt ==
                          null) {
                        _customerOrderStore.finalizationStepStore
                            .setEndProjectAt(nowAfter1year);
                      }
                      if (_customerOrderStore.finalizationStepStore.endProjectAt
                              ?.isBefore(nowAfter1year) ==
                          true) {
                        _customerOrderStore.finalizationStepStore
                            .setEndProjectAt(nowAfter1year);
                      }
                      _showDialog(
                        CupertinoDatePicker(
                          initialDateTime: _customerOrderStore
                              .finalizationStepStore.endProjectAt,
                          minimumDate: nowAfter1year,
                          mode: CupertinoDatePickerMode.date,
                          // This is called when the user changes the dateTime.
                          onDateTimeChanged: (DateTime newDateTime) {
                            _customerOrderStore.finalizationStepStore
                                .setEndProjectAt(newDateTime);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget _buildTotalsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'cart.finalization.total'.tr(),
          style: TextStyle(
            color: _appThemeData.defaultTextColor,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        const Divider(),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            _buildTaxColumn(TaxLevel.RED),
            const SizedBox(
              width: 16,
            ),
            _buildTaxColumn(TaxLevel.RED10),
            const SizedBox(
              width: 16,
            ),
            _buildTaxColumn(TaxLevel.NOR),
          ],
        ),
      ],
    );
  }

  Widget _buildTaxColumn(TaxLevel taxLevel) {
    final totals = _customerOrderStore.order.getTotalsForTaxLevel(taxLevel);
    final formattedTaxLevel =
        '${getIt<NumberFormatterUtilsInterface>().formatWithoutTrailingZeros(taxLevel.value)}%';

    return Expanded(
      child: Column(
        children: [
          getIt<RowButtonWidgetInterface>(
            param1: RowButtonProps(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
              child: Text(
                'cart.without_vat'.tr(),
                style: TextStyle(
                  color:
                      totals[0] == null ? CupertinoColors.inactiveGray : null,
                ),
              ),
              rightChild: Text(totals[0] ?? ''),
            ),
          ),
          getIt<SeparatorWidgetInterface>(),
          getIt<RowButtonWidgetInterface>(
            param1: RowButtonProps(
              child: Text(
                '${'cart.vat'.tr()} $formattedTaxLevel',
                style: TextStyle(
                  color:
                      totals[1] == null ? CupertinoColors.inactiveGray : null,
                ),
              ),
              rightChild: Text(totals[1] ?? ''),
            ),
          ),
          getIt<SeparatorWidgetInterface>(),
          getIt<RowButtonWidgetInterface>(
            param1: RowButtonProps(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(8)),
              child: Text(
                'cart.with_vat'.tr(),
                style: TextStyle(
                  color: totals[2] == null
                      ? CupertinoColors.inactiveGray
                      : _appThemeData.cartFinalizationTotalsColor,
                  fontWeight:
                      totals[2] == null ? FontWeight.normal : FontWeight.bold,
                ),
              ),
              rightChild: Text(
                totals[2] ?? '',
                style: TextStyle(
                  color: _appThemeData.cartFinalizationTotalsColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeepEquipment() {
    return getIt<RowButtonWidgetInterface>(
      param1: RowButtonProps(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        margin: const EdgeInsets.only(bottom: 14),
        disable: _customerOrderStore.order.isReadonly,
        child: Text(
          'cart.finalization.keep_equipments'.tr(),
          style: TextStyle(
            fontSize: 17,
            color: _customerOrderStore.order.isReadonly
                ? CupertinoColors.inactiveGray
                : _appThemeData.defaultTextColor,
          ),
        ),
        rightChild: CupertinoSwitch(
          value: _customerOrderStore.finalizationStepStore.keepOldStuff,
          activeColor: _appThemeData.activeSwitchButtonColor,
          onChanged: _customerOrderStore.order.isReadonly
              ? null
              : (value) {
                  _customerOrderStore.finalizationStepStore
                      .setKeepOldStuff(value);
                },
        ),
      ),
    );
  }

  void _showDialog(Widget child) {
    double width = MediaQuery.of(context).size.width;

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        width: width,
        height: 216,
        alignment: Alignment.center,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Container(
          width: width > 400 ? 400 : width,
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          // The Bottom margin is provided to align the popup above the system
          // navigation bar.
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: child,
          ),
        ),
      ),
    );
  }

  void _showEditCustomerContactModalPopup(SelectForSignatureBaseModel contact) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Provider(
        create: (_) => _customerOrderStore,
        child: getIt<DialogWrapperWidgetInterface>(
          param1: DialogWrapperProps(
            width: 540,
            height: 592,
            disableContentWrapper: true,
            child: getIt<CartCreateOrEditContactWidgetInterface>(
              param1: CartCreateOrEditContactArguments(
                contact: contact as Contact,
                customer: _customerOrderStore.order.customer!,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showCustomerContactModalPopup() {
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          getIt<CartFinalizationAddContactDialogWidgetInterface>(
        param1: CartFinalizationAddContactDialogProps(
          customerOrderStore: _customerOrderStore,
        ),
      ),
    );
  }

  void _showRepModalPopup() {
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (context) => getIt<CartFinalizationAddRepDialogWidgetInterface>(
        param1: CartFinalizationAddRepDialogProps(
          customerOrderStore: _customerOrderStore,
        ),
      ),
    );
  }
}
