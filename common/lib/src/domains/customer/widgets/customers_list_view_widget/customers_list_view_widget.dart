import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class CustomersListViewWidgetInterface implements Widget {
  CustomersListViewProps get props;
}

// Props:-----------------------------------------------------------------------
class CustomersListViewProps {
  const CustomersListViewProps({
    required this.customerListStore,
  });

  final CustomerListStoreInterface customerListStore;
}

// Theme:-----------------------------------------------------------------------
abstract class CustomersListViewThemeInterface {
  Color get rowCircleBackgroundColor;
}

// Implementation:--------------------------------------------------------------
class CustomersListView extends StatefulWidget
    implements CustomersListViewWidgetInterface {
  const CustomersListView({super.key, required this.props});

  @override
  final CustomersListViewProps props;

  @override
  State<CustomersListView> createState() => _CustomersListViewState();
}

class _CustomersListViewState extends State<CustomersListView> {
  // Stores:--------------------------------------------------------------------
  late final CustomersListViewStoreInterface _store =
      getIt<CustomersListViewStoreInterface>(
    param1: CustomersListViewStoreParams(
      customerListStore: widget.props.customerListStore,
    ),
  );

  // Navigators:----------------------------------------------------------------
  late final CustomerTabNavigatorInterface _customerTabNavigator =
      getIt<CustomerTabNavigatorInterface>();

  // Themes:--------------------------------------------------------------------
  final CustomersListViewThemeInterface _theme =
      getIt<CustomersListViewThemeInterface>();
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchRow(),
        const SizedBox(height: 16),
        _buildHeaders(),
        _buildRows(),
      ],
    );
  }

  // Widget methods:------------------------------------------------------------
  Widget _buildSearchRow() {
    return CupertinoSearchTextField(onChanged: _store.setSearch);
  }

  Widget _buildHeaders() {
    return Row(
      children: <Widget>[
        const SizedBox(
          width: 73,
        ),
        _buildHeader('customer_list.header.name'.tr()),
        _buildHeader('customer_list.header.address'.tr()),
        _buildHeader('customer_list.header.postal_code'.tr()),
        _buildHeader('customer_list.header.city'.tr()),
      ],
    );
  }

  Widget _buildHeader(String headerName) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          headerName,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.normal,
            color: MapleCommonColors.greyLighter,
          ),
        ),
      ),
    );
  }

  Widget _buildRows() {
    return Expanded(
      child: Observer(
        builder: (_) {
          return StreamBuilder<List<Customer>>(
            stream: _store.filteredCustomers,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }

              List<Customer> customers = snapshot.data;

              return ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                itemCount: customers.length,
                itemBuilder: (context, index) {
                  return _buildRow(customers[index]);
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildRow(Customer customer) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        _customerTabNavigator.viewRoute,
        arguments: CustomerViewScreenArguments(customer: customer),
      ),
      child: Container(
        height: 44,
        decoration: const BoxDecoration(
          color: MapleCommonColors.greyLightest,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 73,
              child: Center(
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: _theme.rowCircleBackgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      customer.initials,
                      style: const TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _buildCell(customer.name),
            _buildCell(customer.address),
            _buildCell(customer.addressPostalCode),
            _buildCell(customer.addressCity),
          ],
        ),
      ),
    );
  }

  Widget _buildCell(String cellValue) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          cellValue,
          maxLines: 2,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: _appThemeData.defaultTextColor,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
