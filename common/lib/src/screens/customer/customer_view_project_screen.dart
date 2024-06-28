import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';

// Interface:-------------------------------------------------------------------
abstract class CustomerViewProjectScreenInterface implements Widget {
  CustomerViewProjectScreenArguments get arguments;
}

// Theme:-----------------------------------------------------------------------
abstract class CustomerViewProjectScreenThemeInterface {
  Color get blockDataTextColor;
}

// Implementation:--------------------------------------------------------------
class CustomerViewProjectScreen extends StatefulWidget
    implements CustomerViewProjectScreenInterface {
  // Constructor:---------------------------------------------------------------
  const CustomerViewProjectScreen({super.key, required this.arguments});

  @override
  final CustomerViewProjectScreenArguments arguments;

  @override
  State<CustomerViewProjectScreen> createState() =>
      _CustomerViewProjectScreenState();
}

class _CustomerViewProjectScreenState extends State<CustomerViewProjectScreen> {
  // Stores:--------------------------------------------------------------------
  late final CustomerOrderStoreInterface _customerOrderStore;

  // Navigators:----------------------------------------------------------------
  late final CustomerTabNavigatorInterface _customerTabNavigator =
      getIt<CustomerTabNavigatorInterface>();

  // Themes:--------------------------------------------------------------------
  late final AppThemeDataInterface _appThemeData =
      getIt<AppThemeDataInterface>();
  final CustomerViewProjectScreenThemeInterface _theme =
      getIt<CustomerViewProjectScreenThemeInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _customerOrderStore = getIt<CustomerOrderStoreInterface>(
      param1: CustomerOrderStoreParams(order: widget.arguments.order),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => getIt<MainLayoutWidgetInterface>(
          param1: MainLayoutProps(
        backgroundColor: Colors.transparent,
        disabledHeader: true,
        padding: EdgeInsets.zero,
        child: _buildContent(context),
      )),
    );
  }

  // Widgets methods:-----------------------------------------------------------
  Widget _buildContent(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: MapleCommonColors.greyBackground,
                  ),
                  child: SizedBox(
                    child: Opacity(
                      opacity: 0.3,
                      child: Image.asset(
                        MapleCommonAssets.bgProject,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Column(
                    children: [
                      const SizedBox(height: 17),
                      getIt<HeaderWidgetInterface>(
                        param1: HeaderProps(
                          title: 'project.view.title'.tr(namedArgs: {
                            'date': DateFormat.MMMMd('fr')
                                .format(_customerOrderStore.order.createdAt)
                          }),
                          mode: HeaderMode.light,
                          withBackButton: true,
                          rightChild: Row(
                            children: [
                              CupertinoButton(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                onPressed: () =>
                                    Navigator.of(context).pushNamed(
                                  _customerTabNavigator.cartRoute,
                                  arguments: CustomerCartScreenArguments(
                                    customerOrderStore: _customerOrderStore,
                                  ),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      MapleCommonAssets.cart,
                                      colorFilter: ColorFilter.mode(
                                        _appThemeData.topBarButtonColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 25, top: 20),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _appThemeData.cartItemsQuantity,
                                        border: Border.all(
                                          color: CupertinoColors.white,
                                          width: 1,
                                        ),
                                      ),
                                      width: 22,
                                      child: Observer(builder: (_) {
                                        return Text(
                                          _customerOrderStore
                                              .orderStepStore.orderRows.length
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: CupertinoColors.white,
                                          ),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                              getIt<UserButtonDialogWidgetInterface>(
                                param1: UserButtonDialogProps(
                                  iconColor: _appThemeData.topBarButtonColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 23),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              _buildStatusCardButton(),
                              const SizedBox(height: 42),
                              _buildDateCardButton()
                            ],
                          ),
                          const SizedBox(width: 44),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Stack(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildDataBlock(
                                        'address'.tr(),
                                        _customerOrderStore
                                            .order.formattedAddress,
                                      ),
                                      const Divider(),
                                      _buildDataBlock(
                                        'project.view.data.meeting_origin'.tr(),
                                        _customerOrderStore
                                            .order.originWithDetails,
                                      ),
                                      const Divider(),
                                      _buildDataBlock(
                                        'project.view.data.house_age'.tr(),
                                        _customerOrderStore.order.houseAge,
                                      ),
                                      const Divider(),
                                      _buildDataBlock(
                                          'project.view.data.is_pro_premise'
                                              .tr(),
                                          _customerOrderStore.order.isProPremise
                                              ? 'yes'.tr()
                                              : 'no'.tr()),
                                    ],
                                  ),
                                  Observer(
                                    builder: (_) {
                                      return _customerOrderStore
                                              .order.isReadonly
                                          ? const SizedBox()
                                          : Positioned(
                                              right: 0,
                                              child: GestureDetector(
                                                onTap:
                                                    _showProjectOrderEditDialog,
                                                child: Icon(
                                                  CupertinoIcons.pencil_circle,
                                                  color:
                                                      _appThemeData.buttonColor,
                                                  size: 28,
                                                ),
                                              ),
                                            );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Row(
                        children: [
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () => Navigator.of(context)
                                .pushNamed(_customerTabNavigator.mediasRoute),
                            child: _buildProjectFlatCard(
                              MapleCommonAssets.projectMedia,
                              'project.view.media.title'.tr(),
                              'project.view.media.description'.tr(),
                            ),
                          ),
                          const SizedBox(width: 20),
                          _buildStreetViewButton(),
                          const SizedBox(width: 20),
                          if (_customerOrderStore.order.isReadonly &&
                              _customerOrderStore.order.orderFormFileDataId !=
                                  null)
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () => _showOrderForm(context),
                              child: _buildProjectFlatCard(
                                MapleCommonAssets.projectSigningEnvelope,
                                'project.view.documents.title'.tr(),
                                'project.view.documents.description'.tr(),
                              ),
                            ),
                          if (!_customerOrderStore.order.isReadonly)
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () => Navigator.of(context).pushNamed(
                                _customerTabNavigator.servicesRoute,
                                arguments: CustomerServicesScreenArguments(
                                  customerOrderStore: _customerOrderStore,
                                ),
                              ),
                              child: _buildProjectFlatCard(
                                MapleCommonAssets.projectServices,
                                'project.view.services.title'.tr(),
                                'project.view.services.description'.tr(),
                              ),
                            ),
                          Observer(builder: (context) {
                            if (_customerOrderStore.order.isEnergyRelated) {
                              return const SizedBox();
                            }

                            return Row(
                              children: [
                                const SizedBox(width: 20),
                                CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () =>
                                      Navigator.of(context).pushNamed(
                                    _customerTabNavigator.siteSheetRoute,
                                    arguments: CustomerSiteSheetScreenArguments(
                                      orderId: _customerOrderStore.order.id,
                                    ),
                                  ),
                                  child: _buildProjectFlatCard(
                                    MapleCommonAssets.siteSheetButton,
                                    'project.view.site_sheet.title'.tr(),
                                    'project.view.site_sheet.description'.tr(),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStreetViewButton() {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => Navigator.of(context).pushNamed(
        _customerTabNavigator.viewProjectStreetViewRoute,
        arguments: CustomerViewProjectStreetViewScreenArguments(
          projectAddress: _customerOrderStore.order.formattedAddress,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 265,
            height: 155,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage(MapleCommonAssets.projectStreetView),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'project.view.street_view.title'.tr(),
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: _appThemeData.defaultTextColor,
            ),
          ),
          const Text(
            '',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildDataBlock(String title, dynamic value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: _theme.blockDataTextColor,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            getIt<StringUtilsInterface>().parse(value),
            style: TextStyle(
              color: _theme.blockDataTextColor,
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCardButton() {
    return CupertinoButton(
      onPressed: () {},
      padding: EdgeInsets.zero,
      child: Container(
        width: 197,
        height: 155,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: _customerOrderStore.order.colors,
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                SvgPicture.asset(MapleCommonAssets.loading),
              ],
            ),
            Positioned(
                bottom: 0,
                left: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        'project.view.status'.tr(),
                        style: const TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: SizedBox(
                        width: 174,
                        child: Text(
                          _customerOrderStore.order.status.label,
                          style: const TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildDateCardButton() {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {},
      child: Container(
        width: 197,
        height: 155,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: const AssetImage(MapleCommonAssets.calendarImage),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  _appThemeData.viewProjectDateBackgroundColor.withOpacity(0.8),
                  BlendMode.darken),
            )),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                SvgPicture.asset(MapleCommonAssets.calendar),
              ],
            ),
            Positioned(
              bottom: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      'project.view.date'.tr(),
                      style: const TextStyle(
                        color: CupertinoColors.inactiveGray,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      DateFormat('dd/MM/yyyy').format(
                        _customerOrderStore.order.isReadonly &&
                                _customerOrderStore.order.envelopeSignedAt !=
                                    null
                            ? _customerOrderStore.order.envelopeSignedAt!
                            : _customerOrderStore.order.createdAt,
                      ),
                      style: const TextStyle(
                        color: CupertinoColors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectFlatCard(String image, String title, String description) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(image),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(
              fontSize: 15,
              color: _appThemeData.defaultTextColor,
              fontWeight: FontWeight.w500),
        ),
        Text(
          description,
          style: TextStyle(
            fontSize: 15,
            color: MapleCommonColors.greyLight.withOpacity(.53),
          ),
        ),
      ],
    );
  }

  // General methods:-----------------------------------------------------------
  void _showProjectOrderEditDialog() {
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (context) => getIt<AddEditProjectDialogWidgetInterface>(
        param1: AddEditProjectDialogProps(
          order: _customerOrderStore.order,
          customerId: _customerOrderStore.order.customerId,
        ),
      ),
    );
  }

  Future<void> _showOrderForm(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (context) => getIt<SelectDocumentToOpenWidgetInterface>(
        param1: SelectDocumentToOpenProps(
          customerOrderStore: _customerOrderStore,
        ),
      ),
    );
  }

  // Dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    _customerOrderStore.dispose();
    super.dispose();
  }
}
