// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'representative_appraisal_recall_dialog_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RepresentativeAppraisalRecallDialogStore
    on _RepresentativeAppraisalRecallDialogStoreBase, Store {
  late final _$selectedAppraisalsAtom = Atom(
      name: '_RepresentativeAppraisalRecallDialogStoreBase.selectedAppraisals',
      context: context);

  @override
  ObservableList<RepresentativeAppraisal> get selectedAppraisals {
    _$selectedAppraisalsAtom.reportRead();
    return super.selectedAppraisals;
  }

  @override
  set selectedAppraisals(ObservableList<RepresentativeAppraisal> value) {
    _$selectedAppraisalsAtom.reportWrite(value, super.selectedAppraisals, () {
      super.selectedAppraisals = value;
    });
  }

  late final _$sendRecallsAsyncAction = AsyncAction(
      '_RepresentativeAppraisalRecallDialogStoreBase.sendRecalls',
      context: context);

  @override
  Future<void> sendRecalls() {
    return _$sendRecallsAsyncAction.run(() => super.sendRecalls());
  }

  late final _$_RepresentativeAppraisalRecallDialogStoreBaseActionController =
      ActionController(
          name: '_RepresentativeAppraisalRecallDialogStoreBase',
          context: context);

  @override
  void selectAppraisal(RepresentativeAppraisal appraisal) {
    final _$actionInfo =
        _$_RepresentativeAppraisalRecallDialogStoreBaseActionController.startAction(
            name:
                '_RepresentativeAppraisalRecallDialogStoreBase.selectAppraisal');
    try {
      return super.selectAppraisal(appraisal);
    } finally {
      _$_RepresentativeAppraisalRecallDialogStoreBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedAppraisals: ${selectedAppraisals}
    ''';
  }
}
