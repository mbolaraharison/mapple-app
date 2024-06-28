// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'director_appraisal_agency_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DirectorAppraisalAgencyStore
    on _DirectorAppraisalAgencyStoreBase, Store {
  late final _$agencyAtom =
      Atom(name: '_DirectorAppraisalAgencyStoreBase.agency', context: context);

  @override
  Agency get agency {
    _$agencyAtom.reportRead();
    return super.agency;
  }

  @override
  set agency(Agency value) {
    _$agencyAtom.reportWrite(value, super.agency, () {
      super.agency = value;
    });
  }

  late final _$selectTabIndexAtom = Atom(
      name: '_DirectorAppraisalAgencyStoreBase.selectTabIndex',
      context: context);

  @override
  int get selectTabIndex {
    _$selectTabIndexAtom.reportRead();
    return super.selectTabIndex;
  }

  @override
  set selectTabIndex(int value) {
    _$selectTabIndexAtom.reportWrite(value, super.selectTabIndex, () {
      super.selectTabIndex = value;
    });
  }

  late final _$selectedYearAtom = Atom(
      name: '_DirectorAppraisalAgencyStoreBase.selectedYear', context: context);

  @override
  int? get selectedYear {
    _$selectedYearAtom.reportRead();
    return super.selectedYear;
  }

  @override
  set selectedYear(int? value) {
    _$selectedYearAtom.reportWrite(value, super.selectedYear, () {
      super.selectedYear = value;
    });
  }

  late final _$isMultiSelectionAtom = Atom(
      name: '_DirectorAppraisalAgencyStoreBase.isMultiSelection',
      context: context);

  @override
  bool get isMultiSelection {
    _$isMultiSelectionAtom.reportRead();
    return super.isMultiSelection;
  }

  @override
  set isMultiSelection(bool value) {
    _$isMultiSelectionAtom.reportWrite(value, super.isMultiSelection, () {
      super.isMultiSelection = value;
    });
  }

  late final _$selectedAppraisalsAtom = Atom(
      name: '_DirectorAppraisalAgencyStoreBase.selectedAppraisals',
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

  late final _$appraisalsForRepresentativesAtom = Atom(
      name: '_DirectorAppraisalAgencyStoreBase.appraisalsForRepresentatives',
      context: context);

  @override
  ObservableList<RepresentativeAppraisal> get appraisalsForRepresentatives {
    _$appraisalsForRepresentativesAtom.reportRead();
    return super.appraisalsForRepresentatives;
  }

  @override
  set appraisalsForRepresentatives(
      ObservableList<RepresentativeAppraisal> value) {
    _$appraisalsForRepresentativesAtom
        .reportWrite(value, super.appraisalsForRepresentatives, () {
      super.appraisalsForRepresentatives = value;
    });
  }

  late final _$appraisalsForDirectorAtom = Atom(
      name: '_DirectorAppraisalAgencyStoreBase.appraisalsForDirector',
      context: context);

  @override
  ObservableList<RepresentativeAppraisal> get appraisalsForDirector {
    _$appraisalsForDirectorAtom.reportRead();
    return super.appraisalsForDirector;
  }

  @override
  set appraisalsForDirector(ObservableList<RepresentativeAppraisal> value) {
    _$appraisalsForDirectorAtom.reportWrite(value, super.appraisalsForDirector,
        () {
      super.appraisalsForDirector = value;
    });
  }

  late final _$appraisalsHistoryByYearAtom = Atom(
      name: '_DirectorAppraisalAgencyStoreBase.appraisalsHistoryByYear',
      context: context);

  @override
  ObservableMap<int, List<RepresentativeAppraisal>>
      get appraisalsHistoryByYear {
    _$appraisalsHistoryByYearAtom.reportRead();
    return super.appraisalsHistoryByYear;
  }

  @override
  set appraisalsHistoryByYear(
      ObservableMap<int, List<RepresentativeAppraisal>> value) {
    _$appraisalsHistoryByYearAtom
        .reportWrite(value, super.appraisalsHistoryByYear, () {
      super.appraisalsHistoryByYear = value;
    });
  }

  late final _$appraisalsOfTheYearAtom = Atom(
      name: '_DirectorAppraisalAgencyStoreBase.appraisalsOfTheYear',
      context: context);

  @override
  ObservableList<RepresentativeAppraisal> get appraisalsOfTheYear {
    _$appraisalsOfTheYearAtom.reportRead();
    return super.appraisalsOfTheYear;
  }

  @override
  set appraisalsOfTheYear(ObservableList<RepresentativeAppraisal> value) {
    _$appraisalsOfTheYearAtom.reportWrite(value, super.appraisalsOfTheYear, () {
      super.appraisalsOfTheYear = value;
    });
  }

  late final _$representativesAtom = Atom(
      name: '_DirectorAppraisalAgencyStoreBase.representatives',
      context: context);

  @override
  ObservableList<Representative> get representatives {
    _$representativesAtom.reportRead();
    return super.representatives;
  }

  @override
  set representatives(ObservableList<Representative> value) {
    _$representativesAtom.reportWrite(value, super.representatives, () {
      super.representatives = value;
    });
  }

  late final _$representativesWithoutAppraisalAtom = Atom(
      name: '_DirectorAppraisalAgencyStoreBase.representativesWithoutAppraisal',
      context: context);

  @override
  ObservableList<Representative> get representativesWithoutAppraisal {
    _$representativesWithoutAppraisalAtom.reportRead();
    return super.representativesWithoutAppraisal;
  }

  @override
  set representativesWithoutAppraisal(ObservableList<Representative> value) {
    _$representativesWithoutAppraisalAtom
        .reportWrite(value, super.representativesWithoutAppraisal, () {
      super.representativesWithoutAppraisal = value;
    });
  }

  late final _$setSelectedTabIndexAsyncAction = AsyncAction(
      '_DirectorAppraisalAgencyStoreBase.setSelectedTabIndex',
      context: context);

  @override
  Future<void> setSelectedTabIndex(int selectTabIndex) {
    return _$setSelectedTabIndexAsyncAction
        .run(() => super.setSelectedTabIndex(selectTabIndex));
  }

  late final _$initAsyncAction =
      AsyncAction('_DirectorAppraisalAgencyStoreBase.init', context: context);

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$_DirectorAppraisalAgencyStoreBaseActionController =
      ActionController(
          name: '_DirectorAppraisalAgencyStoreBase', context: context);

  @override
  void setSelectedYear(int? selectedYear) {
    final _$actionInfo = _$_DirectorAppraisalAgencyStoreBaseActionController
        .startAction(name: '_DirectorAppraisalAgencyStoreBase.setSelectedYear');
    try {
      return super.setSelectedYear(selectedYear);
    } finally {
      _$_DirectorAppraisalAgencyStoreBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void toggleMultiSelection() {
    final _$actionInfo =
        _$_DirectorAppraisalAgencyStoreBaseActionController.startAction(
            name: '_DirectorAppraisalAgencyStoreBase.toggleMultiSelection');
    try {
      return super.toggleMultiSelection();
    } finally {
      _$_DirectorAppraisalAgencyStoreBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void selectAppraisal(RepresentativeAppraisal appraisal) {
    final _$actionInfo = _$_DirectorAppraisalAgencyStoreBaseActionController
        .startAction(name: '_DirectorAppraisalAgencyStoreBase.selectAppraisal');
    try {
      return super.selectAppraisal(appraisal);
    } finally {
      _$_DirectorAppraisalAgencyStoreBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
agency: ${agency},
selectTabIndex: ${selectTabIndex},
selectedYear: ${selectedYear},
isMultiSelection: ${isMultiSelection},
selectedAppraisals: ${selectedAppraisals},
appraisalsForRepresentatives: ${appraisalsForRepresentatives},
appraisalsForDirector: ${appraisalsForDirector},
appraisalsHistoryByYear: ${appraisalsHistoryByYear},
appraisalsOfTheYear: ${appraisalsOfTheYear},
representatives: ${representatives},
representativesWithoutAppraisal: ${representativesWithoutAppraisal}
    ''';
  }
}
