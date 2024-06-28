import 'package:mobx/mobx.dart';

part 'row_button_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class RowButtonStoreInterface {
  RowButtonStoreInterface._(this.isTapped);

  bool isTapped;

  void setTapped(bool value);
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class RowButtonStore = _RowButtonStore with _$RowButtonStore;

abstract class _RowButtonStore with Store implements RowButtonStoreInterface {
  // Store variables:-----------------------------------------------------------
  @override
  @observable
  bool isTapped = false;

  // actions:-------------------------------------------------------------------
  @override
  @action
  void setTapped(bool value) {
    isTapped = value;
  }
}
