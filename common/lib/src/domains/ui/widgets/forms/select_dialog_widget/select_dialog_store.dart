import 'package:mobx/mobx.dart';

part 'select_dialog_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class SelectDialogStoreInterface<T> {
  SelectDialogStoreParams<T> get params;

  // Variables
  T? value;

  // Methods
  void setValue(T value);
}

// Params:----------------------------------------------------------------------
class SelectDialogStoreParams<T> {
  const SelectDialogStoreParams({
    required this.value,
  });

  final T? value;
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class SelectDialogStore<T> = _SelectDialogStoreBase<T> with _$SelectDialogStore;

abstract class _SelectDialogStoreBase<T>
    with Store
    implements SelectDialogStoreInterface<T> {
  _SelectDialogStoreBase({required this.params}) : value = params.value;

  // Params:---------------------------------------------------------------------
  @override
  final SelectDialogStoreParams<T> params;

  // Variables:-----------------------------------------------------------------
  @override
  @observable
  T? value;

  // Actions:-------------------------------------------------------------------
  @override
  @action
  void setValue(T value) {
    this.value = value;
  }
}
