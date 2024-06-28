import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pull_down_button/pull_down_button.dart';

// Interface:-------------------------------------------------------------------
abstract class CustomerListScreenInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class CustomerListScreen extends StatefulWidget
    implements CustomerListScreenInterface {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  // Services:------------------------------------------------------------------
  final CustomerServiceInterface _customerService =
      getIt<CustomerServiceInterface>();

  // Stores:--------------------------------------------------------------------
  late final CustomerListStoreInterface _store =
      getIt<CustomerListStoreInterface>();

  // Navigators:----------------------------------------------------------------
  late final RootNavigatorInterface _rootNavigator =
      getIt<RootNavigatorInterface>();
  late final CustomerTabNavigatorInterface _customerTabNavigator =
      getIt<CustomerTabNavigatorInterface>();

  // Themes:--------------------------------------------------------------------
  late final AppThemeDataInterface _appThemeData =
      getIt<AppThemeDataInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return getIt<MainLayoutWidgetInterface>(
      param1: MainLayoutProps(
        headerTitle: 'customer_list.title'.tr(),
        headerRightChild: Row(
          children: [
            _buildViewTypeButton(),
            CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              onPressed: _showCreateProjectDialog,
              child: SvgPicture.asset(
                MapleCommonAssets.plus,
                colorFilter: ColorFilter.mode(
                  _appThemeData.topBarButtonColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            PullDownButton(
              itemBuilder: (context) => [
                PullDownMenuItem(
                  title: 'customer_list.filters.my_customers'.tr(),
                  icon: _store.filterMyCustomers
                      ? CupertinoIcons.check_mark_circled_solid
                      : CupertinoIcons.circle,
                  iconColor: _appThemeData.repCustomersColor,
                  onTap: _store.toggleFilterMyCustomers,
                ),
                PullDownMenuItem(
                  title: 'customer_list.filters.other_customers'.tr(),
                  icon: _store.filterOtherCustomers
                      ? CupertinoIcons.check_mark_circled_solid
                      : CupertinoIcons.circle,
                  iconColor: _appThemeData.repOtherCustomersColor,
                  onTap: _store.toggleFilterOtherCustomers,
                ),
              ],
              position: PullDownMenuPosition.automatic,
              buttonBuilder: (context, showMenu) => CupertinoButton(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                onPressed: showMenu,
                child: SvgPicture.asset(
                  MapleCommonAssets.filterCircle,
                  colorFilter: ColorFilter.mode(
                    _appThemeData.topBarButtonColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            getIt<UserButtonDialogWidgetInterface>(
              param1: UserButtonDialogProps(
                iconColor: _appThemeData.topBarButtonColor,
              ),
            ),
          ],
        ),
        child: Expanded(child: _buildContent()),
      ),
    );
  }

  // Widgets methods:-----------------------------------------------------------
  Widget _buildViewTypeButton() {
    return Observer(builder: (_) {
      return CupertinoButton(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        onPressed: _store.toggleViewTypes,
        child: Icon(
          _store.isListView ? CupertinoIcons.map : CupertinoIcons.list_bullet,
          color: _appThemeData.topBarButtonColor,
          size: 30,
        ),
      );
    });
  }

  Widget _buildContent() {
    return Observer(builder: (_) {
      return Column(
        children: <Widget>[
          const SizedBox(height: 16),
          Expanded(
            child: _store.isListView
                ? getIt<CustomersListViewWidgetInterface>(
                    param1: CustomersListViewProps(
                    customerListStore: _store,
                  ))
                : getIt<CustomersMapViewWidgetInterface>(),
          ),
        ],
      );
    });
  }

  // General methods:-----------------------------------------------------------
  void _showCreateProjectDialog(
      {CreateProjectDialogStoreInterface? store,
      List<String>? routesToPush = const []}) {
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (context) => getIt<CreateProjectDialogWidgetInterface>(
        param1: CreateProjectDialogProps(
          store: store ?? getIt<CreateProjectDialogStoreInterface>(),
          routesToPush: routesToPush,
          onSelectDuplicateCustomer: (context, value, navigator, store) async {
            // This function is called when the user selects a customer from the duplicate customer list
            // Here we handle the push to the customer view screen and implement the back button logic,
            // so that when the user presses the back button, the create project dialog is shown again on the correct screen (here on customer list screen)
            Customer? customer =
                await _customerService.getById(value, eager: true);
            if (customer == null) {
              return;
            }
            _rootNavigator.key.currentState?.pop();
            _customerTabNavigator.key.currentState!.pushNamed(
              _customerTabNavigator.viewRoute,
              arguments: CustomerViewScreenArguments(
                  customer: customer,
                  tabIndex: 1,
                  onBackButtonTap: (context) {
                    _customerTabNavigator.key.currentState!
                        .popUntil((route) => route.isFirst);
                    _showCreateProjectDialog(
                      store: store,
                      routesToPush: [
                        navigator.createCustomerRoute,
                        navigator.contactsRoute,
                        navigator.duplicatesRoute,
                      ],
                    );
                  }),
            );
          },
        ),
      ),
    );
  }
}
