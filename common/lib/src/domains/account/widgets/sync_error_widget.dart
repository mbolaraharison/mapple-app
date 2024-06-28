import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class SyncErrorWidgetInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class SyncErrorWidget extends StatelessWidget
    implements SyncErrorWidgetInterface {
  SyncErrorWidget({super.key});
  // Stores:--------------------------------------------------------------------
  late final SyncStoreInterface _syncStore = getIt<SyncStoreInterface>();
  late final AuthStoreInterface _authStore = getIt<AuthStoreInterface>();

  // Navigators:----------------------------------------------------------------
  final SyncNavigatorInterface _syncNavigator = getIt<SyncNavigatorInterface>();
  late final RootNavigatorInterface _rootNavigator =
      getIt<RootNavigatorInterface>();

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.secondarySystemBackground,
      child: Column(
        children: [
          Container(
            height: 52,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(13),
                topRight: Radius.circular(13),
              ),
              color: CupertinoColors.white,
            ),
            child: Center(
              child: Text(
                'sync_error.title'.tr(),
                style: TextStyle(
                  color: _appThemeData.defaultTextColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text('sync_error.subtitle'.tr()),
                const SizedBox(height: 30),
                Observer(builder: (_) {
                  if (_syncStore.integrityJobModel != null &&
                      !_syncStore.integrityJobModel!.isFailed) {
                    return const CupertinoActivityIndicator(radius: 30);
                  }
                  return const SizedBox();
                }),
                const SizedBox(height: 10),
                Observer(builder: (_) {
                  if (_syncStore.integrityJobModel != null) {
                    var textColor = CupertinoColors.secondaryLabel;
                    if (_syncStore.integrityJobModel!.isSuccess) {
                      textColor = CupertinoColors.systemGreen;
                    } else if (_syncStore.integrityJobModel!.isFailed) {
                      textColor = CupertinoColors.systemRed;
                    }

                    return Center(
                      child: Text(
                        'sync_error.description.${_syncStore.integrityJobModel!.status}'
                            .tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 13,
                        ),
                      ),
                    );
                  }

                  return const SizedBox();
                })
              ],
            ),
          ),
          const Spacer(),
          getIt<RowButtonWidgetInterface>(
            param1: RowButtonProps(
              margin: const EdgeInsets.only(bottom: 14),
              onPressed: () {
                _syncNavigator.key.currentState
                    ?.pushNamed(_syncNavigator.agenciesRoute);
              },
              child: Text(
                'sync_error.switch_agency'.tr(),
              ),
            ),
          ),
          getIt<RowButtonWidgetInterface>(
            param1: RowButtonProps(
              disableRightChild: true,
              onPressed: () => _showLogoutDialog(context: context),
              child: Center(
                child: Text(
                  'home_account_dialog_logout'.tr(),
                  style: TextStyle(
                    fontSize: 17,
                    color:
                        DialogHeaderWidgetInterface.sideDefaultTextStyle.color,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // General methods:-----------------------------------------------------------
  void _showLogoutDialog({required BuildContext context}) {
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text('home_logout_dialog_title'.tr()),
        content: Text('home_logout_dialog_content'.tr()),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () async {
              _syncStore.cancel();
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
}
