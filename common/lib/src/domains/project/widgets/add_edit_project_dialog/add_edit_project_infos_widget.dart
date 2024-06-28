import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class AddEditProjectInfosWidgetInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class AddEditProjectInfos extends StatefulWidget
    implements AddEditProjectInfosWidgetInterface {
  const AddEditProjectInfos({super.key});

  @override
  State<AddEditProjectInfos> createState() => _AddEditProjectInfosState();
}

class _AddEditProjectInfosState extends State<AddEditProjectInfos> {
  // Controllers:---------------------------------------------------------------
  final TextEditingController _houseAgeController = TextEditingController();

  // Stores:--------------------------------------------------------------------
  late final AddEditProjectDialogStoreInterface _addEditProjectDialogStore;

  // Navigators:----------------------------------------------------------------
  late final RootNavigatorInterface _rootNavigator =
      getIt<RootNavigatorInterface>();
  late final AddEditProjectNavigatorInterface _addEditProjectNavigator =
      getIt<AddEditProjectNavigatorInterface>();

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _addEditProjectDialogStore =
        Provider.of<AddEditProjectDialogStoreInterface>(context, listen: false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _houseAgeController.text = getIt<StringUtilsInterface>()
        .parse(_addEditProjectDialogStore.houseAge);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => getIt<DialogContentWrapperWidgetInterface>(
        param1: DialogContentWrapperProps(
          header: _buildHeader(),
          child: Column(
            children: [
              const SizedBox(height: 15),
              _buildAddressFields(),
              const SizedBox(height: 15),
              getIt<RowButtonWidgetInterface>(
                param1: RowButtonProps(
                  value: _addEditProjectDialogStore.meetingOriginWithDetails,
                  onPressed: () {
                    _addEditProjectNavigator.key.currentState?.pushNamed(
                        _addEditProjectNavigator.selectMeetingOrigin);
                  },
                  child: Text('project.view.data.meeting_origin'.tr()),
                ),
              ),
              const SizedBox(
                height: 19,
              ),
              getIt<TextInputWithLabelWidgetInterface>(
                param1: TextInputWithLabelProps(
                  label: 'project.view.data.house_age'.tr(),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  controller: _houseAgeController,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      _addEditProjectDialogStore.setHouseAge(0);
                    } else {
                      _addEditProjectDialogStore.setHouseAge(int.parse(value));
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 19,
              ),
              getIt<RowButtonWidgetInterface>(
                param1: RowButtonProps(
                  margin: const EdgeInsets.only(bottom: 14),
                  child: Text(
                    'project.view.data.is_pro_premise'.tr(),
                    style: const TextStyle(fontSize: 17),
                  ),
                  rightChild: CupertinoSwitch(
                    value: _addEditProjectDialogStore.isProPremise,
                    activeColor: _appThemeData.buttonColor,
                    onChanged: (value) {
                      _addEditProjectDialogStore.setIsProPremise(value);
                    },
                  ),
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
          onPressed: () async {
            await _addEditProjectDialogStore.reset();
            _rootNavigator.key.currentState?.pop();
          },
          child: Row(
            children: [
              Icon(
                CupertinoIcons.chevron_left,
                color: DialogHeaderWidgetInterface.sideDefaultTextStyle.color,
                size: 22,
              ),
              Text(
                'cancel'.tr(),
                style: TextStyle(
                  color: DialogHeaderWidgetInterface.sideDefaultTextStyle.color,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
        middleContent: Text(
          _addEditProjectDialogStore.isEditing
              ? 'project.view.data.edit_title'.tr()
              : 'project.add.title'.tr(),
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
        rightContent: CupertinoButton(
          onPressed: _addEditProjectDialogStore.canSubmit
              ? () {
                  _addEditProjectDialogStore.submit();
                  _rootNavigator.key.currentState?.pop();
                }
              : null,
          child: Text(
            _addEditProjectDialogStore.isEditing ? 'edit'.tr() : 'add'.tr(),
            style: TextStyle(
              color: _addEditProjectDialogStore.canSubmit
                  ? DialogHeaderWidgetInterface.sideDefaultTextStyle.color
                  : CupertinoColors.inactiveGray,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddressFields() {
    return Observer(builder: (context) {
      List<Widget> children = [];
      List<RowButtonItem> rowButtonItems = [];
      const TextStyle textStyle =
          TextStyle(color: CupertinoColors.inactiveGray);

      children.add(
        getIt<RowButtonWidgetInterface>(
          param1: RowButtonProps(
            onPressed: _onPressedAddress,
            child: Text(
              'address'.tr(),
            ),
          ),
        ),
      );

      if (_addEditProjectDialogStore.address.isNotEmpty) {
        rowButtonItems.add(
          RowButtonItem(
            label: _addEditProjectDialogStore.address,
            textStyle: textStyle,
          ),
        );
      }

      if (_addEditProjectDialogStore.city.isNotEmpty) {
        rowButtonItems.add(
          RowButtonItem(
            label: _addEditProjectDialogStore.city,
            textStyle: textStyle,
          ),
        );
      }

      if (_addEditProjectDialogStore.postalCode.isNotEmpty) {
        rowButtonItems.add(
          RowButtonItem(
            label: _addEditProjectDialogStore.postalCode,
            textStyle: textStyle,
          ),
        );
      }

      if (rowButtonItems.isNotEmpty) {
        children.add(const SizedBox(height: 15));
        children.add(
          getIt<RowButtonGroupWidgetInterface>(
            param1: RowButtonGroupProps(
              items: rowButtonItems,
            ),
          ),
        );
      }

      return Column(
        children: children,
      );
    });
  }

  void _onPressedAddress() {
    FocusManager.instance.primaryFocus?.unfocus();
    _addEditProjectNavigator.key.currentState!.pushNamed(
      _addEditProjectNavigator.selectAddress,
      arguments: SelectAddressArguments(store: _addEditProjectDialogStore),
    );
  }
}
