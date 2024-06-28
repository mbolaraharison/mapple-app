import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class ResetPasswordDialogWidgetInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class ResetPasswordDialog extends StatelessWidget
    implements ResetPasswordDialogWidgetInterface {
  ResetPasswordDialog({super.key});

  // Utils:---------------------------------------------------------------------
  late final DeviceUtilsInterface _deviceUtils = getIt<DeviceUtilsInterface>();
  late final LoaderUtilsInterface _loaderUtils = getIt<LoaderUtilsInterface>();

  // Variables:-----------------------------------------------------------------
  final ResetPasswordDialogStoreInterface _store =
      getIt<ResetPasswordDialogStoreInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('auth.reset_password_dialog.title'.tr()),
      content: Column(
        children: [
          Text('auth.reset_password_dialog.instruction'.tr()),
          const SizedBox(height: 10),
          CupertinoTextField(
            autofocus: true,
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            textInputAction: TextInputAction.done,
            onChanged: _store.setEmail,
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          child: Text('cancel'.tr()),
          onPressed: () {
            _deviceUtils.hideKeyboard(context);
            Navigator.of(context).pop();
          },
        ),
        CupertinoDialogAction(
          child: Text('auth.reset_password_dialog.send'.tr()),
          onPressed: () => _onSubmit(context),
        ),
      ],
    );
  }

  // General methods:-----------------------------------------------------------
  Future<void> _onSubmit(BuildContext context) async {
    _deviceUtils.hideKeyboard(context);

    try {
      _loaderUtils.startLoading(context);
      await _store.resetPassword();
      if (!context.mounted) return;
      await _loaderUtils.stopLoading(context);
      if (!context.mounted) return;
      Navigator.of(context).pop();
      Fluttertoast.showToast(
        msg: 'auth.reset_password_dialog.success'.tr(namedArgs: {
          'email': _store.email,
        }),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: CupertinoColors.activeGreen,
        textColor: CupertinoColors.white,
        fontSize: 16.0,
      );
    } on ResetPasswordException catch (e) {
      if (context.mounted) {
        await _loaderUtils.stopLoading(context);
      }
      if (context.mounted) {
        _showErrorDialog(e.message, context);
      }
    } catch (e) {
      if (context.mounted) {
        await _loaderUtils.stopLoading(context);
      }
      rethrow;
    }
  }

  void _showErrorDialog(String message, BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('error'.tr()),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: Text('ok'.tr()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
