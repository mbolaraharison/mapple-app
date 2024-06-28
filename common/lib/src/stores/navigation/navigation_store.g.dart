// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NavigationStore on _NavigationStore, Store {
  Computed<int>? _$currentIndexComputed;

  @override
  int get currentIndex =>
      (_$currentIndexComputed ??= Computed<int>(() => super.currentIndex,
              name: '_NavigationStore.currentIndex'))
          .value;

  late final _$currentTabAtom =
      Atom(name: '_NavigationStore.currentTab', context: context);

  @override
  Tab get currentTab {
    _$currentTabAtom.reportRead();
    return super.currentTab;
  }

  @override
  set currentTab(Tab value) {
    _$currentTabAtom.reportWrite(value, super.currentTab, () {
      super.currentTab = value;
    });
  }

  late final _$_NavigationStoreActionController =
      ActionController(name: '_NavigationStore', context: context);

  @override
  void setTab(Tab tab) {
    final _$actionInfo = _$_NavigationStoreActionController.startAction(
        name: '_NavigationStore.setTab');
    try {
      return super.setTab(tab);
    } finally {
      _$_NavigationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentTab: ${currentTab},
currentIndex: ${currentIndex}
    ''';
  }
}
