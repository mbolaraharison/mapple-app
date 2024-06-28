import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class AccountSelectFairWidgetInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class AccountSelectFair extends StatefulWidget
    implements AccountSelectFairWidgetInterface {
  const AccountSelectFair({super.key});

  @override
  State<AccountSelectFair> createState() => _AccountSelectFairState();
}

class _AccountSelectFairState extends State<AccountSelectFair> {
  // Stores:--------------------------------------------------------------------
  late AccountDialogStoreInterface _accountDialogStore;
  final FairServiceInterface _fairService = getIt<FairServiceInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _accountDialogStore = Provider.of<AccountDialogStoreInterface>(context);
  }

  // Lifecycle methods:----------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return getIt<DialogContentWrapperWidgetInterface>(
      param1: DialogContentWrapperProps(
        header: _buildHeader(),
        child: Column(
          children: [
            const SizedBox(height: 39),
            FutureBuilder(
              future: _fairService.getAll(),
              builder: (context, AsyncSnapshot<List<Fair>> snapshot) =>
                  _buildSelect(snapshot),
            ),
          ],
        ),
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
          'account.fair'.tr(),
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
      ),
    );
  }

  Widget _buildSelect(AsyncSnapshot<List<Fair>> snapshot) {
    List<SelectChoice> choices = [];

    for (Fair fair in snapshot.data ?? []) {
      choices.add(SelectChoice(
          value: fair.id, label: fair.label, disable: !fair.isValid));
    }

    return Observer(
      builder: (_) => getIt<SelectWidgetInterface<String>>(
        param1: SelectProps<String>(
          value: _accountDialogStore.fairId,
          onChanged: (value) {
            _accountDialogStore.setFairId(value!);
          },
          choices: choices,
        ),
      ),
    );
  }
}
