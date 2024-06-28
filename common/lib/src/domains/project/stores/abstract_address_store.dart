import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'abstract_address_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class AbstractAddressStoreInterface {
  void setAddress(AddressDTO? addressDetails);
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
abstract class AbstractAddressStore = _AbstractAddressStoreBase
    with _$AbstractAddressStore;

abstract class _AbstractAddressStoreBase
    with Store
    implements AbstractAddressStoreInterface {
  @override
  @action
  void setAddress(AddressDTO? addressDetails) {}
}
