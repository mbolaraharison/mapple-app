import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class ContactsListWidgetInterface implements Widget {}

// Implementation:--------------------------------------------------------------
class ContactsList extends StatefulWidget
    implements ContactsListWidgetInterface {
  const ContactsList({super.key});

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  // Services:------------------------------------------------------------------
  final CustomerServiceInterface _customerService =
      getIt<CustomerServiceInterface>();

  // Stores:--------------------------------------------------------------------
  late CreateProjectDialogStoreInterface _store;
  late final NavigationStoreInterface _navigationStore =
      getIt<NavigationStoreInterface>();

  // Navigators:----------------------------------------------------------------
  late final RootNavigatorInterface _rootNavigator =
      getIt<RootNavigatorInterface>();
  late final CustomerTabNavigatorInterface _customerTabNavigator =
      getIt<CustomerTabNavigatorInterface>();
  late final CreateProjectNavigatorInterface _createProjectNavigator =
      getIt<CreateProjectNavigatorInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<CreateProjectDialogStoreInterface>(context);
  }

  @override
  Widget build(BuildContext context) {
    return getIt<DialogContentWrapperWidgetInterface>(
      param1: DialogContentWrapperProps(
        header: _buildHeader(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            getIt<CreateProjectDialogTitleWidgetInterface>(
              param1: CreateProjectDialogTitleProps(
                title: 'home_create_project_dialog_contacts'.tr(),
                step: 3,
              ),
            ),
            _buildContacts(),
            _buildAddContactButton(),
          ],
        ),
      ),
    );
  }

  // Widgets methods:---------------------------------------------------------
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
                'back'.tr(),
                style: TextStyle(
                  color: DialogHeaderWidgetInterface.sideDefaultTextStyle.color,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
        middleContent: Text(
          'home_create_project_dialog_title'.tr(),
          style: DialogHeaderWidgetInterface.middleDefaultTextStyle,
        ),
        rightContent: Observer(
          builder: (_) => CupertinoButton(
            onPressed: _store.contactsListIsValid ? _onPressedFinish : null,
            child: Text(
              'finish'.tr(),
              style: _store.contactsListIsValid
                  ? DialogHeaderWidgetInterface.sideDefaultTextStyle
                      .copyWith(fontWeight: FontWeight.w600)
                  : const TextStyle(
                      color: CupertinoColors.inactiveGray,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContacts() {
    return Observer(
      builder: (context) {
        List<Widget> contacts = [];

        _store.contacts.asMap().forEach(
          (_, contact) {
            contacts.add(_buildContactItem(contact));
            contacts.add(getIt<SeparatorWidgetInterface>());
          },
        );

        return Column(children: contacts);
      },
    );
  }

  Widget _buildContactItem(Contact contact) {
    return getIt<RowButtonWidgetInterface>(
      param1: RowButtonProps(
        onPressed: () => _onPressedContact(contact),
        child: Text(contact.fullName),
      ),
    );
  }

  Widget _buildAddContactButton() {
    return getIt<RowButtonWidgetInterface>(
      param1: RowButtonProps(
        child: Text(
          'home_create_project_dialog_add_contact'.tr(),
        ),
        onPressed: _onPressedAddContact,
      ),
    );
  }

  // General methods:-----------------------------------------------------------
  void _onPressedAddContact() {
    _store.contactFormStore.reset();

    _createProjectNavigator.key.currentState!
        .pushNamed(_createProjectNavigator.addEditContactRoute);
  }

  void _onPressedContact(Contact contact) {
    _store.contactFormStore.fromContact(contact);

    _createProjectNavigator.key.currentState!
        .pushNamed(_createProjectNavigator.addEditContactRoute);
  }

  Future<void> _onPressedFinish() async {
    // search for duplicates
    List<Customer> customersWithTheSameAddressOrPhoneOrEmail =
        await _customerService
            .searchByAddressOrByPhoneOrByEmail(_store.contactsData);
    // if there are duplicates, show the duplicates screen
    if (customersWithTheSameAddressOrPhoneOrEmail.isNotEmpty) {
      _createProjectNavigator.key.currentState!
          .pushNamed(_createProjectNavigator.duplicatesRoute);
      return;
    }
    // if there are no duplicates, create the project
    final order = await _store.createProject();
    await order.loadData(eager: true);
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
  }
}
