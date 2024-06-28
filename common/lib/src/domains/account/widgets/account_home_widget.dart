import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class AccountHomeWidgetInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class AccountHome extends StatefulWidget implements AccountHomeWidgetInterface {
  const AccountHome({super.key});

  @override
  State<AccountHome> createState() => _AccountHomeState();
}

class _AccountHomeState extends State<AccountHome> {
  // Stores:--------------------------------------------------------------------
  late final AuthStoreInterface _authStore = getIt<AuthStoreInterface>();
  final RepresentativeServiceInterface _representativeService =
      getIt<RepresentativeServiceInterface>();
  final FairServiceInterface _fairService = getIt<FairServiceInterface>();
  late AccountDialogStoreInterface _accountDialogStore;

  // Navigators:----------------------------------------------------------------
  late final RootNavigatorInterface _rootNavigator =
      getIt<RootNavigatorInterface>();
  late final AccountDialogNavigatorInterface _accountDialogNavigator =
      getIt<AccountDialogNavigatorInterface>();

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _accountDialogStore = Provider.of<AccountDialogStoreInterface>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (_accountDialogStore.representative == null) {
        return Container();
      }

      Representative representative = _accountDialogStore.representative!;

      return getIt<DialogContentWrapperWidgetInterface>(
          param1: DialogContentWrapperProps(
        header: _buildHeader(),
        child: Column(
          children: [
            _buildUserButton(representative),
            _buildAgencyButton(),
            _buildDirectSaleButton(representative),
            _buildFairButton(representative),
            _buildAboutButton(),
            _buildLogoutButton(),
          ],
        ),
      ));
    });
  }

  Widget _buildHeader() {
    return getIt<DialogHeaderWidgetInterface>(
      param1: DialogHeaderProps(
        middleContent: Text(
          'home_account_dialog_title'.tr(),
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
        rightContent: CupertinoButton(
          onPressed:
              _accountDialogStore.canSubmit == true ? () => _submit() : null,
          child: Text(
            'ok'.tr().toUpperCase(),
            style: _accountDialogStore.canSubmit == true
                ? DialogHeaderWidgetInterface.sideDefaultTextStyle
                    .copyWith(fontWeight: FontWeight.w600)
                : const TextStyle(color: CupertinoColors.inactiveGray),
          ),
        ),
      ),
    );
  }

  // Widgets methods:-----------------------------------------------------------
  Widget _buildUserButton(Representative? representative) {
    return getIt<RowButtonWidgetInterface>(
      param1: RowButtonProps(
        onPressed: () => _accountDialogNavigator.key.currentState
            ?.pushNamed(_accountDialogNavigator.accountInfos),
        height: 74,
        margin: const EdgeInsets.only(top: 42, bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              representative?.fullName ?? '',
              style: TextStyle(
                fontSize: 17,
                color: _appThemeData.defaultTextColor,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              representative?.roleLabel ?? '',
              style: TextStyle(
                fontSize: 16,
                color: _appThemeData.defaultTextColor,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAgencyButton() {
    return Observer(
      builder: (context) {
        if (_accountDialogStore.agency == null) {
          return Container();
        }

        Agency agency = _accountDialogStore.agency!;

        return getIt<RowButtonWidgetInterface>(
          param1: RowButtonProps(
            margin: const EdgeInsets.only(bottom: 14),
            value: agency.label,
            onPressed: () {
              _accountDialogNavigator.key.currentState!
                  .pushNamed(_accountDialogNavigator.accountSelectAgency);
            },
            child: Text(
              'account.agency'.tr(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFairButton(Representative? representative) {
    return Observer(
      builder: (context) {
        return FutureBuilder(
            future: _accountDialogStore.fairId.isNotEmpty
                ? _fairService.getById(_accountDialogStore.fairId)
                : null,
            builder: (context, AsyncSnapshot<Fair?> snapshot) {
              Fair? fair = snapshot.data;

              return getIt<RowButtonWidgetInterface>(
                param1: RowButtonProps(
                  disable: representative != null &&
                      representative.isDirectSale == true,
                  margin: const EdgeInsets.only(bottom: 14),
                  value: representative != null &&
                          representative.isDirectSale == true
                      ? ''
                      : _accountDialogStore.fairId.isNotEmpty
                          ? fair?.label ?? ''
                          : '',
                  onPressed: () {
                    _accountDialogNavigator.key.currentState!
                        .pushNamed(_accountDialogNavigator.accountSelectFair);
                  },
                  child: Text(
                    'account.fair'.tr(),
                    style: TextStyle(
                      color: representative != null &&
                              representative.isDirectSale == true
                          ? CupertinoColors.inactiveGray
                          : _appThemeData.defaultTextColor,
                    ),
                  ),
                ),
              );
            });
      },
    );
  }

  Widget _buildDirectSaleButton(Representative? representative) {
    return getIt<RowButtonWidgetInterface>(
      param1: RowButtonProps(
        margin: const EdgeInsets.only(bottom: 14),
        child: Text(
          'home_account_dialog_direct_sale'.tr(),
          style: TextStyle(
            fontSize: 17,
            color: _appThemeData.defaultTextColor,
          ),
        ),
        rightChild: CupertinoSwitch(
          value: representative != null && representative.isDirectSale,
          activeColor: _appThemeData.activeSwitchButtonColor,
          onChanged: (value) =>
              _representativeService.setCurrentIsDirectSale(value),
        ),
      ),
    );
  }

  Widget _buildAboutButton() {
    return getIt<RowButtonWidgetInterface>(
      param1: RowButtonProps(
        margin: const EdgeInsets.only(bottom: 14),
        child: Text(
          'home_account_dialog_about'.tr(),
          style: TextStyle(
            fontSize: 17,
            color: _appThemeData.defaultTextColor,
          ),
        ),
        onPressed: () {
          _accountDialogNavigator.key.currentState!
              .pushNamed(_accountDialogNavigator.accountAbout);
        },
      ),
    );
  }

  Widget _buildLogoutButton() {
    return getIt<RowButtonWidgetInterface>(
      param1: RowButtonProps(
        margin: const EdgeInsets.only(bottom: 14),
        disableRightChild: true,
        onPressed: _showLogoutDialog,
        child: Center(
          child: Text(
            'home_account_dialog_logout'.tr(),
            style: TextStyle(
                fontSize: 17,
                color: DialogHeaderWidgetInterface.sideDefaultTextStyle.color),
          ),
        ),
      ),
    );
  }

  // General methods:-----------------------------------------------------------
  void _submit() {
    _accountDialogStore.submit();
    _rootNavigator.key.currentState?.pop();
  }

  void _showLogoutDialog() {
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
