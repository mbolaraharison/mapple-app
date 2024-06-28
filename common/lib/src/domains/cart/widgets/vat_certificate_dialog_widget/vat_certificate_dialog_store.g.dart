// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vat_certificate_dialog_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$VatCertificateDialogStore on _VatCertificateDialogStoreBase, Store {
  Computed<bool>? _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??= Computed<bool>(() => super.isValid,
          name: '_VatCertificateDialogStoreBase.isValid'))
      .value;

  late final _$imageAtom =
      Atom(name: '_VatCertificateDialogStoreBase.image', context: context);

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

  late final _$hasBeenSubmittedAtom = Atom(
      name: '_VatCertificateDialogStoreBase.hasBeenSubmitted',
      context: context);

  @override
  bool get hasBeenSubmitted {
    _$hasBeenSubmittedAtom.reportRead();
    return super.hasBeenSubmitted;
  }

  @override
  set hasBeenSubmitted(bool value) {
    _$hasBeenSubmittedAtom.reportWrite(value, super.hasBeenSubmitted, () {
      super.hasBeenSubmitted = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_VatCertificateDialogStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$_loadFileDataAsyncAction = AsyncAction(
      '_VatCertificateDialogStoreBase._loadFileData',
      context: context);

  @override
  Future<void> _loadFileData(FileData fileData) {
    return _$_loadFileDataAsyncAction.run(() => super._loadFileData(fileData));
  }

  late final _$_VatCertificateDialogStoreBaseActionController =
      ActionController(
          name: '_VatCertificateDialogStoreBase', context: context);

  @override
  void setImage(File? value) {
    final _$actionInfo = _$_VatCertificateDialogStoreBaseActionController
        .startAction(name: '_VatCertificateDialogStoreBase.setImage');
    try {
      return super.setImage(value);
    } finally {
      _$_VatCertificateDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHasBeenSubmitted(bool value) {
    final _$actionInfo =
        _$_VatCertificateDialogStoreBaseActionController.startAction(
            name: '_VatCertificateDialogStoreBase.setHasBeenSubmitted');
    try {
      return super.setHasBeenSubmitted(value);
    } finally {
      _$_VatCertificateDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
image: ${image},
hasBeenSubmitted: ${hasBeenSubmitted},
isLoading: ${isLoading},
isValid: ${isValid}
    ''';
  }
}
