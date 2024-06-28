// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_dialog_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SelectDialogStore<T> on _SelectDialogStoreBase<T>, Store {
  late final _$valueAtom =
      Atom(name: '_SelectDialogStoreBase.value', context: context);

  @override
  T? get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(T? value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  late final _$_SelectDialogStoreBaseActionController =
      ActionController(name: '_SelectDialogStoreBase', context: context);

  @override
  void setValue(T value) {
    final _$actionInfo = _$_SelectDialogStoreBaseActionController.startAction(
        name: '_SelectDialogStoreBase.setValue');
    try {
      return super.setValue(value);
    } finally {
      _$_SelectDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value}
    ''';
  }
}
