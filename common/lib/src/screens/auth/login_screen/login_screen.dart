import 'package:easy_localization/easy_localization.dart';
import 'package:maple_common/maple_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

// Interface:-------------------------------------------------------------------
abstract class LoginScreenInterface implements Widget {}

// Theme:-----------------------------------------------------------------------
abstract class LoginScreenThemeInterface {
  String get backgroundImage;
  String get logoWithTextImage;
}

// Implementation:--------------------------------------------------------------
class LoginScreen extends StatefulWidget implements LoginScreenInterface {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Utils:---------------------------------------------------------------------
  late final DeviceUtilsInterface _deviceUtils = getIt<DeviceUtilsInterface>();

  // Text controllers:----------------------------------------------------------
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Focus node:----------------------------------------------------------------
  late FocusNode _passwordFocusNode;

  // Stores:--------------------------------------------------------------------
  final _store = LoginStore();

  // Observers:-----------------------------------------------------------------
  final List<ReactionDisposer> _disposers = [];

  // Variables:-----------------------------------------------------------------
  String version = '';

  // Navigators:----------------------------------------------------------------
  final RootNavigatorInterface _rootNavigator = getIt<RootNavigatorInterface>();

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();
  final LoginScreenThemeInterface _theme = getIt<LoginScreenThemeInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _initPackageInfo();

    _rootNavigator.handleInitialLink();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
        .copyWith(statusBarBrightness: Brightness.dark));

    _passwordFocusNode = FocusNode();

    _disposers.add(
      reaction(
        (_) => _store.error,
        (_) => _showErrorDialog(_store.error),
      ),
    );
    _disposers.add(
      reaction(
        (_) => _store.success,
        (_) => _navigateToHomeScreen(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: _buildBody(),
    );
  }

  // Widgets methods:-----------------------------------------------------------
  Widget _buildBody() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        SizedBox.expand(
          child: Image.asset(
            _theme.backgroundImage,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: 504,
          height: 383,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: MapleCommonColors.greyLightest,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(),
                Container(
                  height: 27,
                  margin: const EdgeInsets.only(top: 40, bottom: 40),
                  child: Image.asset(_theme.logoWithTextImage),
                ),
                _buildForm(),
                Container(
                  margin: const EdgeInsets.only(top: 62),
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: showResetPasswordDialog,
                    child: Text(
                      'login_forgot_password'.tr(),
                      style: TextStyle(
                        color: DialogHeaderWidgetInterface
                            .sideDefaultTextStyle.color,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Text(
                  '${'version'.tr()} $version',
                  style: const TextStyle(
                    color: CupertinoColors.inactiveGray,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
        getIt<StagingBannerWidgetInterface>(),
        Observer(
          builder: (context) {
            return Visibility(
              visible: _store.loading,
              child: getIt<CustomProgressIndicatorWidgetInterface>(),
            );
          },
        )
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 52,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(13),
          topRight: Radius.circular(13),
        ),
        color: CupertinoColors.white,
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              'login_title'.tr(),
              style: TextStyle(
                  color: _appThemeData.defaultTextColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.centerRight,
            child: _buildLoginButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return Observer(
      builder: (context) {
        return CupertinoButton(
          onPressed: _store.canLogin
              ? () {
                  _deviceUtils.hideKeyboard(context);
                  _store.login();
                }
              : null,
          child: Text(
            'login_submit'.tr(),
            style: TextStyle(
                color: _store.canLogin
                    ? DialogHeaderWidgetInterface.sideDefaultTextStyle.color
                    : CupertinoColors.inactiveGray,
                fontWeight: FontWeight.w600),
          ),
        );
      },
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.only(left: 21, right: 21),
      child: Container(
        height: 89,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text('login_email_input_label'.tr()),
                    ),
                    SizedBox(
                      width: 280,
                      child: _buildEmailField(),
                    )
                  ],
                ),
              ),
            ),
            const Divider(
              height: 1,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text('login_password_input_label'.tr()),
                      ),
                      SizedBox(width: 280, child: _buildPasswordField())
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return CupertinoTextField(
      controller: _userEmailController,
      clearButtonMode: OverlayVisibilityMode.editing,
      keyboardType: TextInputType.emailAddress,
      decoration: const BoxDecoration(border: null),
      placeholder: 'form_required'.tr(),
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      onChanged: (value) {
        _store.email = value;
      },
      onSubmitted: (_) {
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      },
    );
  }

  Widget _buildPasswordField() {
    return CupertinoTextField(
      controller: _passwordController,
      clearButtonMode: OverlayVisibilityMode.editing,
      keyboardType: TextInputType.emailAddress,
      decoration: const BoxDecoration(border: null),
      placeholder: 'form_required'.tr(),
      obscureText: true,
      focusNode: _passwordFocusNode,
      onChanged: (value) {
        _store.password = value;
      },
      onSubmitted: (_) {
        if (!_store.canLogin) {
          return;
        }
        _deviceUtils.hideKeyboard(context);
        _store.login();
      },
    );
  }

  // General Methods:-----------------------------------------------------------
  void _navigateToHomeScreen(BuildContext context) {
    _rootNavigator.key.currentState!
        .pushReplacementNamed(_rootNavigator.mainRoute);
  }

  void _showErrorDialog(String error) {
    if (error.isEmpty) {
      return;
    }
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('error_title'.tr()),
          content: Text('error_$error'.tr()),
          actions: [
            CupertinoDialogAction(
              child: Text('ok'.tr()),
              onPressed: () {
                _rootNavigator.key.currentState!.pop();
              },
            )
          ],
        );
      },
    );
  }

  void showResetPasswordDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return getIt<ResetPasswordDialogWidgetInterface>();
      },
    );
  }

  Future<void> _initPackageInfo() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      version = info.version;
    });
  }

  // Dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
        .copyWith(statusBarBrightness: Brightness.light));

    // Clean up the controller when the Widget is removed from the Widget tree
    _userEmailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    for (var disposer in _disposers) {
      disposer();
    }
    super.dispose();
  }
}
