// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_media_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CustomerMediaStore on _CustomerMediaStoreBase, Store {
  late final _$mediaFamilyAtom =
      Atom(name: '_CustomerMediaStoreBase.mediaFamily', context: context);

  @override
  FileDataFamily? get mediaFamily {
    _$mediaFamilyAtom.reportRead();
    return super.mediaFamily;
  }

  @override
  set mediaFamily(FileDataFamily? value) {
    _$mediaFamilyAtom.reportWrite(value, super.mediaFamily, () {
      super.mediaFamily = value;
    });
  }

  late final _$mediaFamiliesAtom =
      Atom(name: '_CustomerMediaStoreBase.mediaFamilies', context: context);

  @override
  ObservableList<FileDataFamily> get mediaFamilies {
    _$mediaFamiliesAtom.reportRead();
    return super.mediaFamilies;
  }

  @override
  set mediaFamilies(ObservableList<FileDataFamily> value) {
    _$mediaFamiliesAtom.reportWrite(value, super.mediaFamilies, () {
      super.mediaFamilies = value;
    });
  }

  late final _$mediaListAtom =
      Atom(name: '_CustomerMediaStoreBase.mediaList', context: context);

  @override
  ObservableList<FileData> get mediaList {
    _$mediaListAtom.reportRead();
    return super.mediaList;
  }

  @override
  set mediaList(ObservableList<FileData> value) {
    _$mediaListAtom.reportWrite(value, super.mediaList, () {
      super.mediaList = value;
    });
  }

  late final _$_CustomerMediaStoreBaseActionController =
      ActionController(name: '_CustomerMediaStoreBase', context: context);

  @override
  void setMediaFamily(FileDataFamily value) {
    final _$actionInfo = _$_CustomerMediaStoreBaseActionController.startAction(
        name: '_CustomerMediaStoreBase.setMediaFamily');
    try {
      return super.setMediaFamily(value);
    } finally {
      _$_CustomerMediaStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
mediaFamily: ${mediaFamily},
mediaFamilies: ${mediaFamilies},
mediaList: ${mediaList}
    ''';
  }
}
