import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class AccountInfosWidgetInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class AccountInfos extends StatefulWidget
    implements AccountInfosWidgetInterface {
  const AccountInfos({super.key});

  @override
  State<AccountInfos> createState() => _AccountInfosState();
}

class _AccountInfosState extends State<AccountInfos> {
  // Stores:--------------------------------------------------------------------
  late final RepresentativeServiceInterface _representativeService =
      getIt<RepresentativeServiceInterface>();
  late final UserSettingServiceInterface _userSettingService =
      getIt<UserSettingServiceInterface>();
  late AccountDialogStoreInterface _accountDialogStore;

  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _registrationNumberController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Navigators:----------------------------------------------------------------
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

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return getIt<DialogContentWrapperWidgetInterface>(
      param1: DialogContentWrapperProps(
        header: _buildHeader(),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildHeader() {
    return getIt<DialogHeaderWidgetInterface>(
      param1: DialogHeaderProps(
        leftContent: CupertinoButton(
          onPressed: () => Navigator.pop(context),
          child: Row(
            children: [
              Icon(
                CupertinoIcons.chevron_left,
                color: DialogHeaderWidgetInterface.sideDefaultTextStyle.color,
                size: 22,
              ),
              Text(
                'account.title'.tr(),
                style: TextStyle(
                  color: DialogHeaderWidgetInterface.sideDefaultTextStyle.color,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
        middleContent: Text(
          'account.infos.title'.tr(),
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Observer(builder: (context) {
      if (_accountDialogStore.userSetting == null) {
        return Container();
      }
      UserSetting setting = _accountDialogStore.userSetting!;

      return StreamBuilder<Representative?>(
        stream: _representativeService.getCurrentAsStream(),
        builder: (context, snapshot) {
          _accountNameController.text = snapshot.data?.fullName ?? '';
          _registrationNumberController.text = snapshot.data?.sageId ?? '';
          _phoneController.text = snapshot.data?.phone ?? '';
          _emailController.text = snapshot.data?.email ?? '';
          return Column(
            children: [
              const SizedBox(height: 39),
              getIt<TextInputWithLabelWidgetInterface>(
                param1: TextInputWithLabelProps(
                  label: 'account.infos.name'.tr(),
                  readOnly: true,
                  controller: _accountNameController,
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(height: 2),
              getIt<TextInputWithLabelWidgetInterface>(
                param1: TextInputWithLabelProps(
                  label: 'account.infos.registration-number'.tr(),
                  readOnly: true,
                  controller: _registrationNumberController,
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(height: 19),
              getIt<TextInputWithLabelWidgetInterface>(
                param1: TextInputWithLabelProps(
                  label: 'account.infos.phone'.tr(),
                  readOnly: true,
                  controller: _phoneController,
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(height: 2),
              getIt<TextInputWithLabelWidgetInterface>(
                param1: TextInputWithLabelProps(
                  label: 'account.infos.email'.tr(),
                  readOnly: true,
                  controller: _emailController,
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(height: 19),
              _buildShowPhoneInOrderFormButton(setting),
              const SizedBox(height: 2),
              _buildShowEmailInOrderFormButton(setting),
              const SizedBox(height: 19),
              getIt<RowButtonWidgetInterface>(
                param1: RowButtonProps(
                  disableRightChild: true,
                  onPressed: () => _accountDialogNavigator.key.currentState
                      ?.pushNamed(
                          _accountDialogNavigator.accountInfosResetPassword),
                  child: Center(
                    child: Text(
                      'account.edit-password.title'.tr(),
                      style: TextStyle(
                          fontSize: 17,
                          color: DialogHeaderWidgetInterface
                              .sideDefaultTextStyle.color),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    });
  }

  Widget _buildShowEmailInOrderFormButton(UserSetting? setting) {
    return getIt<RowButtonWidgetInterface>(
      param1: RowButtonProps(
        child: Text(
          'home_account_dialog_show_email_in_order_form'.tr(),
          style: TextStyle(
            fontSize: 17,
            color: _appThemeData.defaultTextColor,
          ),
        ),
        rightChild: CupertinoSwitch(
          value: setting != null && setting.showEmailInOrderForm,
          activeColor: _appThemeData.activeSwitchButtonColor,
          onChanged: (value) =>
              _userSettingService.setShowEmailInOrderForm(setting!, value),
        ),
      ),
    );
  }

  Widget _buildShowPhoneInOrderFormButton(UserSetting? setting) {
    return getIt<RowButtonWidgetInterface>(
      param1: RowButtonProps(
        child: Text(
          'home_account_dialog_show_phone_in_order_form'.tr(),
          style: TextStyle(
            fontSize: 17,
            color: _appThemeData.defaultTextColor,
          ),
        ),
        rightChild: CupertinoSwitch(
            value: setting != null && setting.showPhoneInOrderForm,
            activeColor: _appThemeData.activeSwitchButtonColor,
            onChanged: (value) => {
                  _userSettingService.setShowPhoneInOrderForm(setting!, value),
                }),
      ),
    );
  }
}
