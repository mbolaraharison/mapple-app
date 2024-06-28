// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terms_document_dialog_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TermsDocumentDialogStore on _TermsDocumentDialogStoreBase, Store {
  Computed<bool>? _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??= Computed<bool>(() => super.isValid,
          name: '_TermsDocumentDialogStoreBase.isValid'))
      .value;

  late final _$imageAtom =
      Atom(name: '_TermsDocumentDialogStoreBase.image', context: context);

  @override
  File? get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(File? value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  late final _$_TermsDocumentDialogStoreBaseActionController =
      ActionController(name: '_TermsDocumentDialogStoreBase', context: context);

  @override
  void setImage(File? value) {
    final _$actionInfo = _$_TermsDocumentDialogStoreBaseActionController
        .startAction(name: '_TermsDocumentDialogStoreBase.setImage');
    try {
      return super.setImage(value);
    } finally {
      _$_TermsDocumentDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
image: ${image},
isValid: ${isValid}
    ''';
  }
}
