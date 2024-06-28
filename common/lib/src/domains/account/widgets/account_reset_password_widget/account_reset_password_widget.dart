import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';

// Interface:-------------------------------------------------------------------
abstract class AccountResetPasswordWidgetInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class AccountResetPassword extends StatefulWidget
    implements AccountResetPasswordWidgetInterface {
  const AccountResetPassword({super.key});

  @override
  State<AccountResetPassword> createState() => _AccountResetPasswordState();
}

class _AccountResetPasswordState extends State<AccountResetPassword> {
  // Stores:--------------------------------------------------------------------
  late final AccountResetPasswordStoreInterface _store =
      getIt<AccountResetPasswordStoreInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  // Lifecycle methods:----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => getIt<DialogContentWrapperWidgetInterface>(
        param1: DialogContentWrapperProps(
          header: _buildHeader(),
          child: Column(
            children: [
              const SizedBox(height: 39),
              getIt<TextInputWithLabelWidgetInterface>(
                param1: TextInputWithLabelProps(
                  label: 'account.edit-password.current'.tr(),
                  obscureText: true,
                  onChanged: (value) => _store.currentPassword = value,
                ),
              ),
              const SizedBox(height: 2),
              getIt<TextInputWithLabelWidgetInterface>(
                param1: TextInputWithLabelProps(
                  label: 'account.edit-password.new'.tr(),
                  obscureText: true,
                  onChanged: (value) => _store.newPassword = value,
                ),
              ),
              const SizedBox(height: 2),
              getIt<TextInputWithLabelWidgetInterface>(
                param1: TextInputWithLabelProps(
                  label: 'account.edit-password.confirm'.tr(),
                  obscureText: true,
                  onChanged: (value) => _store.confirmPassword = value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return getIt<DialogHeaderWidgetInterface>(
      param1: DialogHeaderProps(
        leftContent: CupertinoButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'cancel'.tr(),
            style: TextStyle(
              color: DialogHeaderWidgetInterface.sideDefaultTextStyle.color,
              fontSize: 17,
            ),
          ),
        ),
        middleContent: Text(
          'account.edit-password.title'.tr(),
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
        rightContent: CupertinoButton(
          onPressed: _store.canUpdate ? () {} : null,
          child: Observer(
            builder: (context) => Text(
              'account.edit-password.submit-button'.tr(),
              style: TextStyle(
                color: _store.canUpdate
                    ? DialogHeaderWidgetInterface.sideDefaultTextStyle.color
                    : MapleCommonColors.greyLight,
                fontSize: 17,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
