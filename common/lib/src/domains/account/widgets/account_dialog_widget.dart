import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class AccountDialogWidgetInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class AccountDialog extends StatefulWidget
    implements AccountDialogWidgetInterface {
  const AccountDialog({super.key});

  @override
  State<AccountDialog> createState() => _AccountDialogState();
}

class _AccountDialogState extends State<AccountDialog> {
  // Store:---------------------------------------------------------------------
  final AccountDialogStoreInterface _accountDialogStore =
      getIt<AccountDialogStoreInterface>();

  // Navigators:----------------------------------------------------------------
  final AccountDialogNavigatorInterface _accountDialogNavigator =
      getIt<AccountDialogNavigatorInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return getIt<DialogWrapperWidgetInterface>(
      param1: DialogWrapperProps(
        width: 540,
        height: 592,
        disableContentWrapper: true,
        child: Provider<AccountDialogStoreInterface>(
          create: (_) => _accountDialogStore,
          child: Navigator(
            key: _accountDialogNavigator.key,
            initialRoute: _accountDialogNavigator.accountHome,
            onGenerateRoute: _accountDialogNavigator.onGenerateRoute,
          ),
        ),
      ),
    );
  }
}
