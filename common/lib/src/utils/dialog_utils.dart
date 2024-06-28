import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

// Interface:-------------------------------------------------------------------
abstract class DialogUtilsInterface {
  void showErrorDialog({
    required BuildContext context,
    required String errorMessage,
  });
}

// Implementation:--------------------------------------------------------------
class DialogUtils implements DialogUtilsInterface {
  @override
  void showErrorDialog({
    required BuildContext context,
    required String errorMessage,
  }) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('error_title').tr(),
          content: Text(errorMessage),
          actions: [
            CupertinoDialogAction(
              child: const Text('ok').tr(),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
