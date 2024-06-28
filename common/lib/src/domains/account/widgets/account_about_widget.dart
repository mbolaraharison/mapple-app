import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:package_info_plus/package_info_plus.dart';

// Interface:-------------------------------------------------------------------
abstract class AccountAboutWidgetInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class AccountAbout extends StatefulWidget
    implements AccountAboutWidgetInterface {
  const AccountAbout({super.key});

  @override
  State<AccountAbout> createState() => _AccountAboutState();
}

class _AccountAboutState extends State<AccountAbout> {
  // Stores:---------------------------------------------------------------------
  final TextEditingController _versionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _versionController.text = '';
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
            getIt<TextInputWithLabelWidgetInterface>(
              param1: TextInputWithLabelProps(
                label: 'version'.tr(),
                readOnly: true,
                controller: _versionController,
                onChanged: (value) {},
              ),
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
          'home_account_dialog_about'.tr(),
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
      ),
    );
  }

  Future<void> _initPackageInfo() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _versionController.text = info.version;
    });
  }
}
