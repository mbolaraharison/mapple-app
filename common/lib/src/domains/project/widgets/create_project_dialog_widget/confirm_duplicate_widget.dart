import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class ConfirmDuplicateWidgetInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class ConfirmDuplicate extends StatefulWidget
    implements ConfirmDuplicateWidgetInterface {
  const ConfirmDuplicate({super.key});

  @override
  State<ConfirmDuplicate> createState() => _ConfirmDuplicateState();
}

class _ConfirmDuplicateState extends State<ConfirmDuplicate> {
  // Services:------------------------------------------------------------------
  final CustomerServiceInterface _customerService =
      getIt<CustomerServiceInterface>();

  // Controllers:---------------------------------------------------------------
  final TextEditingController _houseAgeController = TextEditingController();

  // Stores:--------------------------------------------------------------------
  late CreateProjectDialogStoreInterface _store;

  // Navigators:----------------------------------------------------------------
  late final NavigationStoreInterface _navigationStore =
      getIt<NavigationStoreInterface>();

  // Navigators:----------------------------------------------------------------
  late final RootNavigatorInterface _rootNavigator =
      getIt<RootNavigatorInterface>();
  late final CustomerTabNavigatorInterface _customerTabNavigator =
      getIt<CustomerTabNavigatorInterface>();
  late final CreateProjectNavigatorInterface _createProjectNavigator =
      getIt<CreateProjectNavigatorInterface>();

  // Properties:----------------------------------------------------------------
  late final Function(
      BuildContext context,
      String value,
      CreateProjectNavigatorInterface navigator,
      CreateProjectDialogStoreInterface store)? _onSelectDuplicateCustomer;

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _onSelectDuplicateCustomer = context.read<
        Function(
            BuildContext context,
            String value,
            CreateProjectNavigatorInterface navigator,
            CreateProjectDialogStoreInterface store)?>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<CreateProjectDialogStoreInterface>(context);
    _houseAgeController.text =
        getIt<StringUtilsInterface>().parse(_store.houseAge);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => getIt<DialogContentWrapperWidgetInterface>(
        param1: DialogContentWrapperProps(
          header: _buildHeader(),
          child: SizedBox(
            height: 600,
            child: Stack(children: [
              SizedBox(
                height: 540,
                child: CupertinoScrollbar(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 15),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 10, left: 35, right: 35),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  CupertinoIcons.exclamationmark_circle,
                                  color: MapleCommonColors.activeBlue,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'customer.duplicate.info'.tr(),
                                    style: const TextStyle(
                                      color: MapleCommonColors.activeBlue,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            'customer.duplicate.customers'.tr(),
                            style: const TextStyle(
                              color: CupertinoColors.inactiveGray,
                              fontSize: 16,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        StreamBuilder(
                          stream: _customerService
                              .searchByAddressOrByPhoneOrByEmailAsStream(
                                  _store.contactsData),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Container();
                            }

                            List<SelectChoice> choices = [];

                            for (Customer customer in snapshot.data ?? []) {
                              choices.add(SelectChoice(
                                  value: customer.id, label: customer.name));
                            }

                            return getIt<SelectWidgetInterface<String>>(
                              param1: SelectProps<String>(
                                value: '',
                                onChanged: (value) async {
                                  if (_onSelectDuplicateCustomer == null) {
                                    return;
                                  }
                                  _onSelectDuplicateCustomer!(context, value!,
                                      _createProjectNavigator, _store);
                                },
                                choices: choices,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: getIt<RowButtonWidgetInterface>(
                  param1: RowButtonProps(
                    disableRightChild: true,
                    onPressed: () => _rootNavigator.key.currentState?.pop(),
                    child: Center(
                      child: Text(
                        'customer.duplicate.cancel'.tr(),
                        style: TextStyle(color: _appThemeData.buttonColor),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  // Widgets methods:-----------------------------------------------------------
  Widget _buildHeader() {
    return getIt<DialogHeaderWidgetInterface>(
      param1: DialogHeaderProps(
        leftContent: CupertinoButton(
          onPressed: () => Navigator.pop(context),
          child: SizedBox(
            width: 100,
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.chevron_left,
                  color: DialogHeaderWidgetInterface.sideDefaultTextStyle.color,
                  size: 22,
                ),
                Text(
                  'back'.tr(),
                  style: TextStyle(
                    color:
                        DialogHeaderWidgetInterface.sideDefaultTextStyle.color,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
        ),
        middleContent: Text(
          'customer.duplicate.title'.tr(),
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
        rightContent: CupertinoButton(
          onPressed:
              _store.createCustomerIsValid ? _onPressedConfirmCreate : null,
          child: Text(
            'confirm'.tr(),
            style: _store.createCustomerIsValid
                ? DialogHeaderWidgetInterface.sideDefaultTextStyle
                    .copyWith(fontWeight: FontWeight.w600)
                : const TextStyle(
                    color: CupertinoColors.inactiveGray,
                  ),
          ),
        ),
      ),
    );
  }

  // General methods:-----------------------------------------------------------
  Future<void> _onPressedConfirmCreate() async {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('customer.duplicate.confirmation-modal.title'.tr()),
          content: Text('customer.duplicate.confirmation-modal.content'.tr()),
          actions: [
            CupertinoDialogAction(
              child: Text('ok'.tr()),
              onPressed: () async {
                final order = await _store.createProject();
                await order.loadData(eager: true);
                _rootNavigator.key.currentState?.pop();
                _rootNavigator.key.currentState?.pop();
                _navigationStore.setTab(Tab.customer);
                _customerTabNavigator.key.currentState!.pushNamed(
                  _customerTabNavigator.viewRoute,
                  arguments: CustomerViewScreenArguments(
                    customer: order.customer!,
                    tabIndex: 1,
                  ),
                );
                _customerTabNavigator.key.currentState!.pushNamed(
                  _customerTabNavigator.viewProjectRoute,
                  arguments: CustomerViewProjectScreenArguments(order: order),
                );
              },
            ),
          ],
        );
      },
    );
  }

  // Dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    super.dispose();
  }
}
