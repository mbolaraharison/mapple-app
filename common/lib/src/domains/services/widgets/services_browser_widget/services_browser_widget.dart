import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class ServicesBrowserWidgetInterface implements Widget {
  ServicesBrowserProps get props;
}

class ServicesBrowserProps {
  final CustomerOrderStoreInterface? customerOrderStore;

  ServicesBrowserProps({this.customerOrderStore});
}

// Implementation:--------------------------------------------------------------
class ServicesBrowser extends StatefulWidget
    implements ServicesBrowserWidgetInterface {
  const ServicesBrowser({super.key, required this.props});

  @override
  final ServicesBrowserProps props;

  @override
  State<ServicesBrowser> createState() => _ServicesBrowserState();
}

class _ServicesBrowserState extends State<ServicesBrowser>
    with TickerProviderStateMixin {
  // Variables:-----------------------------------------------------------------
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
  );

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(-1, 0),
    end: const Offset(0, 0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  ));

  late final AnimationController _controller2 = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
  );

  late final Animation<Offset> _offsetAnimation2 = Tween<Offset>(
    begin: const Offset(-1, 0),
    end: const Offset(0, 0),
  ).animate(CurvedAnimation(
    parent: _controller2,
    curve: Curves.easeInOut,
  ));

  late double columnWidth;

  // Themes:--------------------------------------------------------------------
  late final AppThemeDataInterface _appThemeData =
      getIt<AppThemeDataInterface>();

  // Stores:--------------------------------------------------------------------
  late final ServicesBrowserStoreInterface _store =
      getIt<ServicesBrowserStoreInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    columnWidth =
        (MediaQuery.of(context).size.width - SidebarWidgetInterface.width) / 3;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Container(
        color: CupertinoColors.extraLightBackgroundGray,
        child: Stack(
          children: [
            Row(
              children: [
                SizedBox(width: columnWidth),
                SlideTransition(
                  position: _offsetAnimation,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: columnWidth),
                          SlideTransition(
                            position: _offsetAnimation2,
                            child: _buildServices(),
                          ),
                        ],
                      ),
                      _buildSecondLevelCategories(),
                    ],
                  ),
                ),
              ],
            ),
            _buildFirstLevelCategories(),
          ],
        ),
      );
    });
  }

  // Widget methods:------------------------------------------------------------
  Widget _buildFirstLevelCategories() {
    final children = _store.serviceFamilies.map((ServiceFamily serviceFamily) {
      return _buildFirstLevelCategoryItem(serviceFamily);
    }).toList();

    return Container(
      width: columnWidth,
      padding: const EdgeInsets.only(
        top: 28,
        left: 14,
        right: 14,
      ),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        border: Border(
          right: BorderSide(
            color: MapleCommonColors.greyLighter.withOpacity(.5),
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: SvgPicture.asset(
                    MapleCommonAssets.backCircle,
                    height: 33,
                    colorFilter: ColorFilter.mode(
                      _appThemeData.topBarButtonColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Expanded(
                child: Text(
                  'services.title'.tr(),
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          getIt<SeparatorWidgetInterface>(
            param1: SeparatorProps(
              color: CupertinoColors.opaqueSeparator.withOpacity(.5),
            ),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFirstLevelCategoryItem(
    ServiceFamily serviceFamily,
  ) {
    final bool isSelected = _store.serviceFamily != null
        ? _store.serviceFamily!.id == serviceFamily.id
        : false;

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        if (isSelected) {
          return;
        }
        _store.setServiceFamily(serviceFamily);
        _controller.forward();
        _controller2.reverse();
      },
      child: Container(
        height: 81,
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(serviceFamily.backgroundImage),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(.3), BlendMode.darken),
                ),
              ),
            ),
            Center(
              child: Row(
                children: [
                  const SizedBox(width: 21),
                  SvgPicture.asset(serviceFamily.icon, height: 23),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Text(
                      serviceFamily.label,
                      style: const TextStyle(
                        fontSize: 16,
                        color: CupertinoColors.white,
                      ),
                    ),
                  ),
                  Icon(
                    CupertinoIcons.chevron_right,
                    color: isSelected
                        ? CupertinoColors.white
                        : CupertinoColors.white.withOpacity(.5),
                  ),
                  const SizedBox(width: 13),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecondLevelCategories() {
    if (_store.serviceFamily == null) {
      return Container();
    }

    final children = _store.serviceSubFamiliesFiltered
        .map((ServiceSubFamily serviceSubFamily) {
      return _buildSecondLevelCategoryItem(
        serviceSubFamily,
      );
    }).toList();

    return Container(
      width: columnWidth,
      padding: const EdgeInsets.only(
        top: 28,
        left: 14,
        right: 14,
      ),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        border: Border(
          right: BorderSide(
            color: MapleCommonColors.greyLighter.withOpacity(.5),
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 11),
                Text(
                  _store.serviceFamily!.label,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                getIt<SeparatorWidgetInterface>(
                  param1: SeparatorProps(
                    color: CupertinoColors.opaqueSeparator.withOpacity(.5),
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: children),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecondLevelCategoryItem(
    ServiceSubFamily serviceSubFamily,
  ) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        _store.setServiceSubFamily(serviceSubFamily);
        _controller2.forward();
      },
      child: Column(
        children: [
          Observer(builder: (context) {
            final bool isSelected = _store.serviceSubFamily != null
                ? _store.serviceSubFamily!.id == serviceSubFamily.id
                : false;
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              decoration: isSelected
                  ? BoxDecoration(
                      color: _appThemeData.serviceListingItemColor,
                      borderRadius: BorderRadius.circular(8),
                    )
                  : null,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          serviceSubFamily.label,
                          style: TextStyle(
                            fontSize: 15,
                            color: isSelected
                                ? CupertinoColors.white
                                : _appThemeData.defaultTextColor,
                          ),
                        ),
                        Text(
                          _store.serviceFamily!.label,
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected
                                ? CupertinoColors.systemGrey4
                                : MapleCommonColors.greyLighter,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    CupertinoIcons.chevron_right,
                    color: isSelected
                        ? CupertinoColors.white
                        : MapleCommonColors.greyLighter,
                    size: 20,
                  ),
                ],
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: getIt<SeparatorWidgetInterface>(
              param1: SeparatorProps(
                color: CupertinoColors.opaqueSeparator.withOpacity(.5),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildServices() {
    if (_store.serviceSubFamily == null) {
      return Container();
    }

    final children = _store.servicesFiltered.map((Service service) {
      return _buildServiceItem(
        service,
      );
    }).toList();

    return Container(
      width: columnWidth,
      padding: const EdgeInsets.only(
        top: 28,
        left: 14,
        right: 14,
      ),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        border: Border(
          right: BorderSide(
            color: MapleCommonColors.greyLighter.withOpacity(.5),
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 11),
          Text(
            _store.serviceSubFamily!.label,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          getIt<SeparatorWidgetInterface>(
            param1: SeparatorProps(
              color: CupertinoColors.opaqueSeparator.withOpacity(.5),
            ),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: SingleChildScrollView(child: Column(children: children)),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(Service service) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => _onServiceTap(service),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            service.label,
            style: TextStyle(
              fontSize: 15,
              color: _appThemeData.defaultTextColor,
            ),
          ),
          const SizedBox(height: 18),
          getIt<SeparatorWidgetInterface>(
            param1: SeparatorProps(
              color: CupertinoColors.opaqueSeparator.withOpacity(.5),
            ),
          ),
          const SizedBox(height: 18),
        ],
      ),
    );
  }

  // General methods:-----------------------------------------------------------
  Future<void> _onServiceTap(Service service) async {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => getIt<ServiceDialogWidgetInterface>(
        param1: ServiceDialogProps(
          service: service,
          customerOrderStore: widget.props.customerOrderStore,
        ),
      ),
    );
  }
}
