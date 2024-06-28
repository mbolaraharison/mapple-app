// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terms_dialog_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TermsDialogStore on _TermsDialogStoreBase, Store {
  Computed<bool>? _$formIsValidComputed;

  @override
  bool get formIsValid =>
      (_$formIsValidComputed ??= Computed<bool>(() => super.formIsValid,
              name: '_TermsDialogStoreBase.formIsValid'))
          .value;
  Computed<bool>? _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??= Computed<bool>(() => super.isValid,
          name: '_TermsDialogStoreBase.isValid'))
      .value;

  late final _$acceptanteDematerializationAtom = Atom(
      name: '_TermsDialogStoreBase.acceptanteDematerialization',
      context: context);

  @override
  bool get acceptanteDematerialization {
    _$acceptanteDematerializationAtom.reportRead();
    return super.acceptanteDematerialization;
  }

  @override
  set acceptanteDematerialization(bool value) {
    _$acceptanteDematerializationAtom
        .reportWrite(value, super.acceptanteDematerialization, () {
      super.acceptanteDematerialization = value;
    });
  }

  late final _$acceptanteTermsAtom =
      Atom(name: '_TermsDialogStoreBase.acceptanteTerms', context: context);

  @override
  bool get acceptanteTerms {
    _$acceptanteTermsAtom.reportRead();
    return super.acceptanteTerms;
  }

  @override
  set acceptanteTerms(bool value) {
    _$acceptanteTermsAtom.reportWrite(value, super.acceptanteTerms, () {
      super.acceptanteTerms = value;
    });
  }

  late final _$imageAtom =
      Atom(name: '_TermsDialogStoreBase.image', context: context);

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

  late final _$hasSignatureAtom =
      Atom(name: '_TermsDialogStoreBase.hasSignature', context: context);

  @override
  bool get hasSignature {
    _$hasSignatureAtom.reportRead();
    return super.hasSignature;
  }

  @override
  set hasSignature(bool value) {
    _$hasSignatureAtom.reportWrite(value, super.hasSignature, () {
      super.hasSignature = value;
    });
  }

  late final _$currentAgencyAtom =
      Atom(name: '_TermsDialogStoreBase.currentAgency', context: context);

  @override
  Agency? get currentAgency {
    _$currentAgencyAtom.reportRead();
    return super.currentAgency;
  }

  @override
  set currentAgency(Agency? value) {
    _$currentAgencyAtom.reportWrite(value, super.currentAgency, () {
      super.currentAgency = value;
    });
  }

  late final _$hasBeenSubmittedAtom =
      Atom(name: '_TermsDialogStoreBase.hasBeenSubmitted', context: context);

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

  late final _$_TermsDialogStoreBaseActionController =
      ActionController(name: '_TermsDialogStoreBase', context: context);

  @override
  void setHasBeenSubmitted(bool value) {
    final _$actionInfo = _$_TermsDialogStoreBaseActionController.startAction(
        name: '_TermsDialogStoreBase.setHasBeenSubmitted');
    try {
      return super.setHasBeenSubmitted(value);
    } finally {
      _$_TermsDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleAcceptanteDematerialization() {
    final _$actionInfo = _$_TermsDialogStoreBaseActionController.startAction(
        name: '_TermsDialogStoreBase.toggleAcceptanteDematerialization');
    try {
      return super.toggleAcceptanteDematerialization();
    } finally {
      _$_TermsDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleAcceptanteTerms() {
    final _$actionInfo = _$_TermsDialogStoreBaseActionController.startAction(
        name: '_TermsDialogStoreBase.toggleAcceptanteTerms');
    try {
      return super.toggleAcceptanteTerms();
    } finally {
      _$_TermsDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHasSignature(bool value) {
    final _$actionInfo = _$_TermsDialogStoreBaseActionController.startAction(
        name: '_TermsDialogStoreBase.setHasSignature');
    try {
      return super.setHasSignature(value);
    } finally {
      _$_TermsDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setImage(File? value) {
    final _$actionInfo = _$_TermsDialogStoreBaseActionController.startAction(
        name: '_TermsDialogStoreBase.setImage');
    try {
      return super.setImage(value);
    } finally {
      _$_TermsDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
acceptanteDematerialization: ${acceptanteDematerialization},
acceptanteTerms: ${acceptanteTerms},
image: ${image},
hasSignature: ${hasSignature},
currentAgency: ${currentAgency},
hasBeenSubmitted: ${hasBeenSubmitted},
formIsValid: ${formIsValid},
isValid: ${isValid}
    ''';
  }
}
