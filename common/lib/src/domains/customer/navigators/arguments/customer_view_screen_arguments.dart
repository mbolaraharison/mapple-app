import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';

class CustomerViewScreenArguments {
  final Customer customer;
  final int? tabIndex;
  final void Function(BuildContext context)? onBackButtonTap;

  CustomerViewScreenArguments(
      {required this.customer, this.tabIndex, this.onBackButtonTap});
}
