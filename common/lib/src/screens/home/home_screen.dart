import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maple_common/maple_common.dart';
import 'package:open_filex/open_filex.dart';

// Interface:-------------------------------------------------------------------
abstract class HomeScreenInterface implements Widget {}

// Theme:-----------------------------------------------------------------------
abstract class HomeScreenThemeInterface {
  String get bannerImage;
  String get annualVisitsImage;
  String get customerListImage;
  String get catalogImage;
  String get viewConstructionSitesImage;
  String get servicesImage;
}

// Implementation:--------------------------------------------------------------
class HomeScreen extends StatefulWidget implements HomeScreenInterface {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  // Services:------------------------------------------------------------------
  final CustomerServiceInterface _customerService =
      getIt<CustomerServiceInterface>();

  // Services:------------------------------------------------------------------
  final RepresentativeServiceInterface _representativeService =
      getIt<RepresentativeServiceInterface>();
  final FairServiceInterface _fairService = getIt<FairServiceInterface>();
  final AgencyServiceInterface _agencyService = getIt<AgencyServiceInterface>();
  late final NavigationStoreInterface _navigationStore =
      getIt<NavigationStoreInterface>();

// Utils:---------------------------------------------------------------------
  late final LoaderUtilsInterface _loaderUtils = getIt<LoaderUtilsInterface>();

  // Navigators:----------------------------------------------------------------
  late final CustomerTabNavigatorInterface _customerTabNavigator =
      getIt<CustomerTabNavigatorInterface>();
  late final HomeTabNavigatorInterface _homeTabNavigator =
      getIt<HomeTabNavigatorInterface>();
  late final RootNavigatorInterface _rootNavigator =
      getIt<RootNavigatorInterface>();

  // Themes:--------------------------------------------------------------------
  late final AppThemeDataInterface _appThemeData =
      getIt<AppThemeDataInterface>();
  final HomeScreenThemeInterface _theme = getIt<HomeScreenThemeInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return getIt<MainLayoutWidgetInterface>(
      param1: MainLayoutProps(
        disabledHeader: true,
        padding: EdgeInsets.zero,
        child: _buildContent(),
      ),
    );
  }

  // Widgets methods:-----------------------------------------------------------
  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 336),
              child: Image.asset(
                _theme.bannerImage,
                fit: BoxFit.cover,
                alignment: Alignment.centerRight,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                children: [
                  const SizedBox(height: 17),
                  getIt<HeaderWidgetInterface>(
                    param1: HeaderProps(
                      title: 'home_title'.tr(),
                      rightChild: getIt<UserButtonDialogWidgetInterface>(),
                      mode: HeaderMode.dark,
                    ),
                  ),
                  const SizedBox(height: 57),
                  Row(
                    children: [
                      _buildModeAndAgencyCard(),
                      const SizedBox(width: 35),
                      _buildCreateProjectCard(),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 45),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'home_quick_access'.tr(),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: _appThemeData.defaultTextColor,
                ),
              ),
              const SizedBox(height: 25),
              _buildQuickAccessRow(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildModeAndAgencyCard() {
    return StreamBuilder<Representative?>(
      stream: _representativeService.getCurrentAsStream(),
      builder: (context, AsyncSnapshot<Representative?> snapshot) {
        Representative? representative = snapshot.data;
        return CupertinoButton(
          onPressed: _showAccountDialog,
          padding: EdgeInsets.zero,
          child: IntrinsicWidth(
            child: Container(
              height: 135,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: representative != null && representative.hasFairAccess
                    ? _appThemeData.fairModeCardColor
                    : _appThemeData.agencyModeCardColor,
              ),
              constraints: const BoxConstraints(maxWidth: 552),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        representative != null && representative.hasFairAccess
                            ? MapleCommonAssets.fair
                            : MapleCommonAssets.arrowRightRounded,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        representative != null && representative.hasFairAccess
                            ? 'fair'.tr()
                            : 'direct_sale'.tr(),
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    representative != null && representative.hasFairAccess
                        ? 'home_selected_fair'.tr()
                        : 'home_selected_agency'.tr(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: CupertinoColors.white.withOpacity(.6),
                    ),
                  ),
                  const SizedBox(height: 7),
                  !(representative != null && representative.hasFairAccess)
                      ? StreamBuilder<Agency?>(
                          stream: _agencyService.getCurrentAsStream(),
                          builder: (_, snapshot) {
                            if (!snapshot.hasData) return Container();

                            final agency = snapshot.data;

                            return Text(
                              agency?.label ?? '',
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: CupertinoColors.white,
                              ),
                            );
                          },
                        )
                      : StreamBuilder<Fair?>(
                          stream: _fairService.getCurrentAsStream(),
                          builder: (_, snapshot) {
                            if (!snapshot.hasData) return Container();

                            final fair = snapshot.data;

                            return Text(
                              fair?.label ?? '',
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: CupertinoColors.white,
                              ),
                            );
                          },
                        )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCreateProjectCard() {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: _showCreateProjectDialog,
      child: Container(
        width: 297,
        height: 135,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: CupertinoColors.white,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              MapleCommonAssets.plusCircle,
            ),
            const SizedBox(height: 15),
            Text('home_create_project'.tr(),
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildViewConstructionSitesCard(),
        const SizedBox(width: 35),
        Expanded(
          child: CupertinoButton(
            onPressed: null,
            padding: EdgeInsets.zero,
            child: _buildFlatCard(
              _theme.annualVisitsImage,
              'home_annual_visits'.tr(),
              'home_annual_visits_reminder'.tr(),
              disable: true,
            ),
          ),
        ),
        const SizedBox(width: 25),
        Expanded(
          child: CupertinoButton(
            onPressed: () {
              _navigationStore.setTab(Tab.customer);
              tabRedirectToRoot[Tab.customer]!();
            },
            padding: EdgeInsets.zero,
            child: _buildFlatCard(
              _theme.customerListImage,
              'home_customer_list'.tr(),
              'home_customer_list_visit'.tr(),
            ),
          ),
        ),
        const SizedBox(width: 25),
        Expanded(
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () async {
              _loaderUtils.startLoading(context);
              FileDataServiceInterface fileDataService =
                  getIt<FileDataServiceInterface>();
              FileData? fileData =
                  await fileDataService.getByUniqueName('mt_sales_book.pdf');
              if (fileData != null) {
                File? salesBookFile = await fileDataService
                    .getFileFromFileSystem(fileData.uniqueName);
                if (salesBookFile != null) {
                  await OpenFilex.open(salesBookFile.path);
                }
              }
              if (!mounted) return;
              _loaderUtils.stopLoading(context);
            },
            child: _buildFlatCard(
              _theme.catalogImage,
              'home_catalog'.tr(),
              'home_catalog_view'.tr(),
            ),
          ),
        ),
        const SizedBox(width: 25),
        Expanded(
          child: CupertinoButton(
            onPressed: () => Navigator.of(context).pushNamed(
              _homeTabNavigator.servicesRoute,
            ),
            padding: EdgeInsets.zero,
            child: _buildFlatCard(
              _theme.servicesImage,
              'home_services'.tr(),
              'home_services_view'.tr(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildViewConstructionSitesCard() {
    return CupertinoButton(
      onPressed: () {
        _navigationStore.setTab(Tab.customer);
        _customerTabNavigator.key.currentState!
            .pushNamed(_customerTabNavigator.mediasRoute);
      },
      padding: EdgeInsets.zero,
      child: getIt<CardWidgetInterface>(
        param1: CardProps(
          width: 275,
          height: 300,
          child: Column(
            children: [
              SizedBox(
                height: 232,
                child: SizedBox.expand(
                  child: Image.asset(
                    _theme.viewConstructionSitesImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'home_pictures'.tr(),
                        style: TextStyle(
                          fontSize: 16,
                          color: MapleCommonColors.greyLight.withOpacity(.53),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'home_access_media'.tr(),
                        style: const TextStyle(
                            fontSize: 17,
                            color: Color(0xFF28285B),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFlatCard(String image, String title, String subtitle,
      {bool disable = false}) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 225),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: disable
                ? ColorFiltered(
                    colorFilter: const ColorFilter.matrix(<double>[
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0,
                      0,
                      0,
                      1,
                      0,
                    ]),
                    child: Image.asset(image))
                : Image.asset(image),
          ),
          const SizedBox(height: 18),
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              color: disable
                  ? CupertinoColors.inactiveGray
                  : _appThemeData.defaultTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 15,
              color: disable
                  ? CupertinoColors.inactiveGray
                  : MapleCommonColors.greyLight.withOpacity(.53),
            ),
          ),
        ],
      ),
    );
  }

  // General Methods:-----------------------------------------------------------
  void _showCreateProjectDialog(
      {CreateProjectDialogStoreInterface? store,
      List<String>? routesToPush = const []}) {
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (context) => getIt<CreateProjectDialogWidgetInterface>(
        param1: CreateProjectDialogProps(
          store: store ?? getIt<CreateProjectDialogStoreInterface>(),
          routesToPush: routesToPush,
          onSelectDuplicateCustomer: (context, value, navigator, store) async {
            // This function is called when the user selects a customer from the duplicate customer list
            // Here we handle the push to the customer view screen and implement the back button logic,
            // so that when the user presses the back button, the create project dialog is shown again on the correct screen (here on home screen)
            Customer? customer =
                await _customerService.getById(value, eager: true);
            if (customer == null) {
              return;
            }
            _rootNavigator.key.currentState?.pop();
            _navigationStore.setTab(Tab.customer);
            _customerTabNavigator.key.currentState!.pushNamed(
              _customerTabNavigator.viewRoute,
              arguments: CustomerViewScreenArguments(
                  customer: customer,
                  tabIndex: 1,
                  onBackButtonTap: (context) {
                    _customerTabNavigator.key.currentState!
                        .popUntil((route) => route.isFirst);
                    _navigationStore.setTab(Tab.home);
                    _showCreateProjectDialog(
                      store: store,
                      routesToPush: [
                        navigator.createCustomerRoute,
                        navigator.contactsRoute,
                        navigator.duplicatesRoute,
                      ],
                    );
                  }),
            );
          },
        ),
      ),
    );
  }

  void _showAccountDialog() {
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (context) => getIt<AccountDialogWidgetInterface>(),
    );
  }
}
