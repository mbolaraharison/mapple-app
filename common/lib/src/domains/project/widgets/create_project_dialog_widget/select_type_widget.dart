import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class SelectTypeWidgetInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class SelectType extends StatefulWidget implements SelectTypeWidgetInterface {
  const SelectType({super.key});

  @override
  State<SelectType> createState() => _SelectTypeState();
}

class _SelectTypeState extends State<SelectType> {
  // Stores:--------------------------------------------------------------------
  late CreateProjectDialogStoreInterface _createProjectDialogStore;

  // Navigators:----------------------------------------------------------------
  late final RootNavigatorInterface _rootNavigator =
      getIt<RootNavigatorInterface>();
  late final CreateProjectNavigatorInterface _createProjectNavigator =
      getIt<CreateProjectNavigatorInterface>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _createProjectDialogStore =
        Provider.of<CreateProjectDialogStoreInterface>(context);
  }

  @override
  Widget build(BuildContext context) {
    return getIt<DialogContentWrapperWidgetInterface>(
      param1: DialogContentWrapperProps(
        header: _buildHeader(),
        child: Column(
          children: [
            getIt<CreateProjectDialogTitleWidgetInterface>(
              param1: CreateProjectDialogTitleProps(
                title: 'home_create_project_dialog_select_type'.tr(),
                step: 1,
              ),
            ),
            Container(
              height: 292,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 38),
              padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 55),
              decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildChoice(CustomerType.individual),
                  _buildChoice(CustomerType.professional),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widgets methods:-----------------------------------------------------------
  Widget _buildHeader() {
    return getIt<DialogHeaderWidgetInterface>(
      param1: DialogHeaderProps(
        leftContent: CupertinoButton(
          onPressed: () => _rootNavigator.key.currentState?.pop(),
          child: Text('cancel'.tr(),
              style: DialogHeaderWidgetInterface.sideDefaultTextStyle),
        ),
        middleContent: Text(
          'home_create_project_dialog_title'.tr(),
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
        rightContent: CupertinoButton(
          onPressed: () => _createProjectNavigator.key.currentState
              ?.pushNamed(_createProjectNavigator.createCustomerRoute),
          child: Text(
            'next'.tr(),
            style: DialogHeaderWidgetInterface.sideDefaultTextStyle
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _buildChoice(CustomerType type) {
    return Observer(builder: (_) {
      String labelKey = type.labelKey;
      String icon = type.icon;
      bool isActive = type == _createProjectDialogStore.customerType;

      return CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => _createProjectDialogStore.customerType = type,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                icon,
                height: 100,
                colorFilter: ColorFilter.mode(
                  isActive == false
                      ? MapleCommonColors.greyLighter
                      : type.activeColor,
                  BlendMode.srcIn,
                ),
              ),
              Text(
                labelKey.tr(),
                style: TextStyle(
                  fontSize: 17,
                  color: isActive == false
                      ? MapleCommonColors.greyLighter
                      : CupertinoColors.black,
                ),
              ),
              getIt<RadioWidgetInterface>(param1: RadioProps(value: isActive)),
            ],
          ));
    });
  }
}
