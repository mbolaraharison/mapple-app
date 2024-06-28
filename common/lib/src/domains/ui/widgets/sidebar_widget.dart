import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class SidebarWidgetInterface implements Widget {
  static const double width = 70;
}

// Theme:-----------------------------------------------------------------------
abstract class SidebarWidgetThemeInterface {
  String get logoImage;
}

// Implementation:--------------------------------------------------------------
class Sidebar extends StatefulWidget implements SidebarWidgetInterface {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  // Stores:--------------------------------------------------------------------
  late final NavigationStoreInterface _navigationStore =
      getIt<NavigationStoreInterface>();

  // Services:------------------------------------------------------------------
  late final AgencyServiceInterface _agencyService =
      getIt<AgencyServiceInterface>();
  late final RepresentativeServiceInterface _representativeService =
      getIt<RepresentativeServiceInterface>();

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();
  final SidebarWidgetThemeInterface _theme =
      getIt<SidebarWidgetThemeInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SidebarWidgetInterface.width,
      decoration: BoxDecoration(
        color: MapleCommonColors.greyLightest,
        border: Border(
          right: BorderSide(
            color: MapleCommonColors.greyLighter.withOpacity(.5),
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
              width: 34,
              height: 27,
              margin: const EdgeInsets.only(top: 42, bottom: 5),
              child: SvgPicture.asset(_theme.logoImage)),
          Observer(
            builder: (context) => _buildButton(
              tab: Tab.home,
              icon: MapleCommonAssets.home,
              iconActive: MapleCommonAssets.homeActive,
              width: 25.0,
              height: 20.0,
              index: 0,
            ),
          ),
          Observer(
            builder: (context) => _buildButton(
              tab: Tab.customer,
              icon: MapleCommonAssets.users,
              iconActive: MapleCommonAssets.usersActive,
              width: 27.0,
              height: 20.0,
              index: 1,
            ),
          ),
          Observer(
            builder: (context) => _buildButton(
              tab: Tab.discountCodes,
              icon: MapleCommonAssets.discountCodes,
              iconActive: MapleCommonAssets.discountCodesActive,
              width: 24.0,
              height: 20.0,
              index: 4,
            ),
          ),
          _buildRepresentativeAppraisalTab(context),
        ],
      ),
    );
  }

  Widget _buildRepresentativeAppraisalTab(BuildContext context) {
    return StreamBuilder(
        stream: _representativeService.getCurrentAsStream(),
        builder: (_, AsyncSnapshot<Representative?> snapshot) {
          if (!snapshot.hasData ||
              snapshot.data!.hasAccessToRepresentativeAppraisalModule ==
                  false) {
            return Container();
          }
          return StreamBuilder<List<Agency>>(
            stream: _agencyService.getAllByEmailAsStream(snapshot.data!.email,
                hasAccessToAppraisalModule: true),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data?.isEmpty == true) {
                return Container();
              }

              return Observer(
                  builder: (context) => _buildButton(
                        tab: Tab.appraisals,
                        icon: MapleCommonAssets.book,
                        iconActive: MapleCommonAssets.bookActive,
                        width: 24.0,
                        height: 20.0,
                        index: 4,
                      ));
            },
          );
        });
  }

  // Widget methods:------------------------------------------------------------
  Widget _buildButton({
    required Tab tab,
    required String icon,
    required String iconActive,
    required double width,
    required double height,
    required int index,
  }) {
    if (_navigationStore.currentTab == tab) {
      return CupertinoButton(
        onPressed: () {
          if (tabRedirectToRoot[tab] != null) {
            tabRedirectToRoot[tab]!();
          }
        },
        padding: EdgeInsets.zero,
        child: Container(
          width: 34,
          height: 34,
          margin: const EdgeInsets.only(top: 24),
          decoration: BoxDecoration(
            color: _appThemeData.activeMenuColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SizedBox(
              width: width,
              height: height,
              child: SvgPicture.asset(iconActive),
            ),
          ),
        ),
      );
    } else {
      return Container(
        width: 34,
        height: 34,
        margin: const EdgeInsets.only(top: 24),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          minSize: 0,
          child: SizedBox(
            width: width,
            height: height,
            child: SvgPicture.asset(icon),
          ),
          onPressed: () {
            _navigationStore.setTab(tab);
          },
        ),
      );
    }
  }
}
