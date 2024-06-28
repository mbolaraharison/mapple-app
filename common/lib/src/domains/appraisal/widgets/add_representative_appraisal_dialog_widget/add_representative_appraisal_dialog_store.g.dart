// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_representative_appraisal_dialog_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddRepresentativeAppraisalDialogStore
    on _AddRepresentativeAppraisalDialogStoreBase, Store {
  Computed<bool>? _$formIsValidComputed;

  @override
  bool get formIsValid =>
      (_$formIsValidComputed ??= Computed<bool>(() => super.formIsValid,
              name: '_AddRepresentativeAppraisalDialogStoreBase.formIsValid'))
          .value;
  Computed<String>? _$formattedLimitDateComputed;

  @override
  String get formattedLimitDate => (_$formattedLimitDateComputed ??= Computed<
              String>(() => super.formattedLimitDate,
          name:
              '_AddRepresentativeAppraisalDialogStoreBase.formattedLimitDate'))
      .value;

  late final _$typeAtom = Atom(
      name: '_AddRepresentativeAppraisalDialogStoreBase.type',
      context: context);

  @override
  RepresentativeAppraisalType get type {
    _$typeAtom.reportRead();
    return super.type;
  }

  @override
  set type(RepresentativeAppraisalType value) {
    _$typeAtom.reportWrite(value, super.type, () {
      super.type = value;
    });
  }

  late final _$limitDateAtom = Atom(
      name: '_AddRepresentativeAppraisalDialogStoreBase.limitDate',
      context: context);

  @override
  DateTime? get limitDate {
    _$limitDateAtom.reportRead();
    return super.limitDate;
  }

  @override
  set limitDate(DateTime? value) {
    _$limitDateAtom.reportWrite(value, super.limitDate, () {
      super.limitDate = value;
    });
  }

  late final _$createRepresentativeAppraisalAsyncAction = AsyncAction(
      '_AddRepresentativeAppraisalDialogStoreBase.createRepresentativeAppraisal',
      context: context);

  @override
  Future<void> createRepresentativeAppraisal(Representative representative) {
    return _$createRepresentativeAppraisalAsyncAction
        .run(() => super.createRepresentativeAppraisal(representative));
  }

  late final _$_AddRepresentativeAppraisalDialogStoreBaseActionController =
      ActionController(
          name: '_AddRepresentativeAppraisalDialogStoreBase', context: context);

  @override
  void setType(RepresentativeAppraisalType value) {
    final _$actionInfo =
        _$_AddRepresentativeAppraisalDialogStoreBaseActionController
            .startAction(
                name: '_AddRepresentativeAppraisalDialogStoreBase.setType');
    try {
      return super.setType(value);
    } finally {
      _$_AddRepresentativeAppraisalDialogStoreBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setLimitDate(DateTime value) {
    final _$actionInfo =
        _$_AddRepresentativeAppraisalDialogStoreBaseActionController
            .startAction(
                name:
                    '_AddRepresentativeAppraisalDialogStoreBase.setLimitDate');
    try {
      return super.setLimitDate(value);
    } finally {
      _$_AddRepresentativeAppraisalDialogStoreBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
type: ${type},
limitDate: ${limitDate},
formIsValid: ${formIsValid},
formattedLimitDate: ${formattedLimitDate}
    ''';
  }
}
