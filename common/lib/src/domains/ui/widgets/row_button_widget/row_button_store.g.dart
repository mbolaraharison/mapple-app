// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'row_button_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RowButtonStore on _RowButtonStore, Store {
  late final _$isTappedAtom =
      Atom(name: '_RowButtonStore.isTapped', context: context);

  @override
  bool get isTapped {
    _$isTappedAtom.reportRead();
    return super.isTapped;
  }

  @override
  set isTapped(bool value) {
    _$isTappedAtom.reportWrite(value, super.isTapped, () {
      super.isTapped = value;
    });
  }

  late final _$_RowButtonStoreActionController =
      ActionController(name: '_RowButtonStore', context: context);

  @override
  void setTapped(bool value) {
    final _$actionInfo = _$_RowButtonStoreActionController.startAction(
        name: '_RowButtonStore.setTapped');
    try {
      return super.setTapped(value);
    } finally {
      _$_RowButtonStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isTapped: ${isTapped}
    ''';
  }
}
