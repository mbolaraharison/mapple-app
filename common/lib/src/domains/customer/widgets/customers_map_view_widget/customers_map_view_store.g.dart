// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customers_map_view_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CustomersMapViewStore on _CustomersMapViewStoreBase, Store {
  late final _$isMapReadyAtom =
      Atom(name: '_CustomersMapViewStoreBase.isMapReady', context: context);

  @override
  bool get isMapReady {
    _$isMapReadyAtom.reportRead();
    return super.isMapReady;
  }

  @override
  set isMapReady(bool value) {
    _$isMapReadyAtom.reportWrite(value, super.isMapReady, () {
      super.isMapReady = value;
    });
  }

  late final _$_CustomersMapViewStoreBaseActionController =
      ActionController(name: '_CustomersMapViewStoreBase', context: context);

  @override
  void setMapReady() {
    final _$actionInfo = _$_CustomersMapViewStoreBaseActionController
        .startAction(name: '_CustomersMapViewStoreBase.setMapReady');
    try {
      return super.setMapReady();
    } finally {
      _$_CustomersMapViewStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isMapReady: ${isMapReady}
    ''';
  }
}
