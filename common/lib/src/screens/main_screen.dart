import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class MainScreenInterface implements Widget {}

// Theme:-----------------------------------------------------------------------
abstract class MainScreenThemeInterface {
  Color get defaultBackgroundColor;
  String get syncErrorBackgroundImage;
}

// Implementation:--------------------------------------------------------------
class MainScreen extends StatefulWidget implements MainScreenInterface {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Stores:--------------------------------------------------------------------
  late final NavigationStoreInterface _navigationStore =
      getIt<NavigationStoreInterface>();
  late final AuthStoreInterface _authStore = getIt<AuthStoreInterface>();
  late final RepresentativeServiceInterface _representativeService =
      getIt<RepresentativeServiceInterface>();
  late final SyncStoreInterface _syncStore = getIt<SyncStoreInterface>();

  // Navigators:----------------------------------------------------------------
  final RootNavigatorInterface _rootNavigator = getIt<RootNavigatorInterface>();
  late final SyncNavigatorInterface _syncNavigator =
      getIt<SyncNavigatorInterface>();

  // Themes:--------------------------------------------------------------------
  late final MainScreenThemeInterface _theme =
      getIt<MainScreenThemeInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _rootNavigator.handleInitialLink();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return CupertinoPageScaffold(
        backgroundColor: _theme.defaultBackgroundColor,
        resizeToAvoidBottomInset: false,
        child: _authStore.isLoading
            ? _buildLoading()
            : (_syncStore.isOk ? _buildMainScreen() : _buildSyncError()),
      );
    });
  }

  Widget _buildLoading() {
    return Stack(
      children: [
        ModalBarrier(
          color: Colors.white.withOpacity(0.5),
          dismissible: false,
        ),
        const Center(
          child: CupertinoActivityIndicator(),
        ),
      ],
    );
  }

  Widget _buildMainScreen() {
    return Stack(
      children: [
        StreamBuilder(
          stream: _representativeService.getCurrentAsStream(eager: true),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            Representative? representative = snapshot.data;
            if (!representative!.isValidForSignature) {
              return CupertinoAlertDialog(
                title: Text('rep.error_infos.label'.tr()),
                content: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Icon(
                      CupertinoIcons.exclamationmark_circle,
                      color: Colors.red,
                      size: 50,
                    ),
                    const SizedBox(height: 10),
                    Text('rep.error_infos.content_with_agency'.tr(namedArgs: {
                      'agency': representative.agency!.label,
                    })),
                    const SizedBox(height: 10),
                    Text(
                      representative.signingAbilityStatusInfos,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'rep.error_infos.content_with_agency_2'.tr(),
                    ),
                  ],
                ),
                actions: <CupertinoDialogAction>[
                  CupertinoDialogAction(
                    isDestructiveAction: true,
                    onPressed: () async {
                      _rootNavigator.key.currentState?.pushNamedAndRemoveUntil(
                        _rootNavigator.loginRoute,
                        (route) => false,
                      );
                      await _authStore.logout();
                    },
                    child: SizedBox(
                      width: 177,
                      child: Text('home_logout_dialog_title'.tr()),
                    ),
                  ),
                ],
              );
            } else {
              return Row(
                children: [
                  getIt<SidebarWidgetInterface>(),
                  Expanded(
                    child: ClipRect(child: Observer(
                      builder: (context) {
                        return IndexedStack(
                          index: _navigationStore.currentIndex,
                          children: [
                            getIt<HomeTabScreenInterface>(),
                            getIt<CustomerTabScreenInterface>(),
                            getIt<BusinessMonitoringScreenInterface>(),
                            getIt<LibraryScreenInterface>(),
                            getIt<DiscountCodesScreenInterface>(),
                            getIt<SearchScreenInterface>(),
                            getIt<AppraisalsScreenInterface>(),
                          ],
                        );
                      },
                    )),
                  ),
                ],
              );
            }
          },
        ),
        getIt<StagingBannerWidgetInterface>(),
      ],
    );
  }

  Widget _buildSyncError() {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox.expand(
          child: Image.asset(
            _theme.syncErrorBackgroundImage,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: 504,
          height: 383,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
          ),
          child: Navigator(
            key: _syncNavigator.key,
            initialRoute: _syncNavigator.syncErrorRoute,
            onGenerateRoute: _syncNavigator.onGenerateRoute,
          ),
        ),
        getIt<StagingBannerWidgetInterface>(),
      ],
    );
  }
}
