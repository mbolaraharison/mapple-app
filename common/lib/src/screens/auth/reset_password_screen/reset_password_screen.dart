import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maple_common/maple_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';

// Interface:-------------------------------------------------------------------
abstract class ResetPasswordScreenInterface implements Widget {
  ResetPasswordScreenArguments get arguments;
}

// Implementation:--------------------------------------------------------------
class ResetPasswordScreen extends StatefulWidget
    implements ResetPasswordScreenInterface {
  // Constructor:---------------------------------------------------------------
  const ResetPasswordScreen({super.key, required this.arguments});

  @override
  final ResetPasswordScreenArguments arguments;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  // Focus node:----------------------------------------------------------------
  late final FocusNode _confirmPasswordFocusNode = FocusNode();

  // Stores:--------------------------------------------------------------------
  final _store = ResetPasswordStore();

  // Navigators:----------------------------------------------------------------
  late final RootNavigatorInterface _rootNavigator =
      getIt<RootNavigatorInterface>();

  // Utils:---------------------------------------------------------------------
  late final DeviceUtilsInterface _deviceUtils = getIt<DeviceUtilsInterface>();

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();
  final LoginScreenThemeInterface _theme = getIt<LoginScreenThemeInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _init(widget.arguments.code);
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
          width: 604,
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
              ],
            ),
          ),
        ),
        StagingBanner(),
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
              'auth.reset_password_screen.title'.tr(),
              style: TextStyle(
                color: _appThemeData.defaultTextColor,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.centerRight,
            child: _buildSubmitButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Observer(
      builder: (context) {
        return CupertinoButton(
          onPressed: _store.canResetPassword ? _resetPassword : null,
          child: Text(
            'auth.reset_password_screen.submit'.tr(),
            style: TextStyle(
              color: _store.canResetPassword
                  ? CupertinoColors.destructiveRed
                  : CupertinoColors.inactiveGray,
              fontWeight: FontWeight.w600,
            ),
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
                      width: 230,
                      child: Text(
                        'auth.reset_password_screen.password_label'.tr(),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Container(
                        child: _buildPasswordField(
                          onChanged: _store.setNewPassword,
                          onSubmitted: (value) {
                            _confirmPasswordFocusNode.requestFocus();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 230,
                        child: Text(
                          'auth.reset_password_screen.confirm_password_label'
                              .tr(),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Container(
                          child: _buildPasswordField(
                            focusNode: _confirmPasswordFocusNode,
                            onChanged: _store.setConfirmPassword,
                            onSubmitted: (value) {
                              _deviceUtils.hideKeyboard(context);
                            },
                          ),
                        ),
                      ),
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

  Widget _buildPasswordField({
    required ValueChanged<String> onChanged,
    required ValueChanged<String> onSubmitted,
    FocusNode? focusNode,
  }) {
    return CupertinoTextField(
      clearButtonMode: OverlayVisibilityMode.editing,
      decoration: const BoxDecoration(border: null),
      placeholder: 'form_required'.tr(),
      obscureText: true,
      focusNode: focusNode,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }

  // General Methods:-----------------------------------------------------------
  void _init(String code) async {
    try {
      await _store.setCode(code);
    } on ResetPasswordException catch (e) {
      _showErrorDialog(
        message: e.message,
        onOk: () {
          Navigator.of(context).pop();
          _rootNavigator.key.currentState!.popUntil((route) => route.isFirst);
        },
      );
    }
  }

  void _resetPassword() async {
    _deviceUtils.hideKeyboard(context);
    try {
      await _store.resetPassword();
      _rootNavigator.key.currentState!.popUntil((route) => route.isFirst);
      Fluttertoast.showToast(
        msg: 'auth.reset_password_screen.success'.tr(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: CupertinoColors.activeGreen,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } on ResetPasswordException catch (e) {
      _showErrorDialog(
        message: e.message,
        onOk: () {
          Navigator.of(context).pop();
        },
      );
    }
  }

  void _showErrorDialog({
    required String message,
    required VoidCallback onOk,
  }) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('error'.tr()),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              onPressed: onOk,
              child: Text('ok'.tr()),
            ),
          ],
        );
      },
    );
  }
}
