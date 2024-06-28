// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_dialog_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ServiceDialogStore on _ServiceDialogStoreBase, Store {
  Computed<bool>? _$isEditingComputed;

  @override
  bool get isEditing =>
      (_$isEditingComputed ??= Computed<bool>(() => super.isEditing,
              name: '_ServiceDialogStoreBase.isEditing'))
          .value;
  Computed<bool>? _$option2isDisabledComputed;

  @override
  bool get option2isDisabled => (_$option2isDisabledComputed ??= Computed<bool>(
          () => super.option2isDisabled,
          name: '_ServiceDialogStoreBase.option2isDisabled'))
      .value;
  Computed<bool>? _$allOptionsAreValidComputed;

  @override
  bool get allOptionsAreValid => (_$allOptionsAreValidComputed ??=
          Computed<bool>(() => super.allOptionsAreValid,
              name: '_ServiceDialogStoreBase.allOptionsAreValid'))
      .value;
  Computed<num>? _$quantityValueComputed;

  @override
  num get quantityValue =>
      (_$quantityValueComputed ??= Computed<num>(() => super.quantityValue,
              name: '_ServiceDialogStoreBase.quantityValue'))
          .value;
  Computed<num>? _$grossPriceWithoutTaxMiscellaneousValueComputed;

  @override
  num get grossPriceWithoutTaxMiscellaneousValue =>
      (_$grossPriceWithoutTaxMiscellaneousValueComputed ??= Computed<num>(
              () => super.grossPriceWithoutTaxMiscellaneousValue,
              name:
                  '_ServiceDialogStoreBase.grossPriceWithoutTaxMiscellaneousValue'))
          .value;
  Computed<bool>? _$quantityIsValidComputed;

  @override
  bool get quantityIsValid =>
      (_$quantityIsValidComputed ??= Computed<bool>(() => super.quantityIsValid,
              name: '_ServiceDialogStoreBase.quantityIsValid'))
          .value;
  Computed<String>? _$formattedUnitPriceWithoutTaxComputed;

  @override
  String get formattedUnitPriceWithoutTax =>
      (_$formattedUnitPriceWithoutTaxComputed ??= Computed<String>(
              () => super.formattedUnitPriceWithoutTax,
              name: '_ServiceDialogStoreBase.formattedUnitPriceWithoutTax'))
          .value;
  Computed<num>? _$grossPriceInclTaxComputed;

  @override
  num get grossPriceInclTax => (_$grossPriceInclTaxComputed ??= Computed<num>(
          () => super.grossPriceInclTax,
          name: '_ServiceDialogStoreBase.grossPriceInclTax'))
      .value;
  Computed<String>? _$formattedGrossPriceInclTaxComputed;

  @override
  String get formattedGrossPriceInclTax =>
      (_$formattedGrossPriceInclTaxComputed ??= Computed<String>(
              () => super.formattedGrossPriceInclTax,
              name: '_ServiceDialogStoreBase.formattedGrossPriceInclTax'))
          .value;
  Computed<num>? _$totalGrossInclTaxComputed;

  @override
  num get totalGrossInclTax => (_$totalGrossInclTaxComputed ??= Computed<num>(
          () => super.totalGrossInclTax,
          name: '_ServiceDialogStoreBase.totalGrossInclTax'))
      .value;
  Computed<String>? _$formattedTotalGrossInclTaxComputed;

  @override
  String get formattedTotalGrossInclTax =>
      (_$formattedTotalGrossInclTaxComputed ??= Computed<String>(
              () => super.formattedTotalGrossInclTax,
              name: '_ServiceDialogStoreBase.formattedTotalGrossInclTax'))
          .value;
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_ServiceDialogStoreBase.isFormValid'))
          .value;
  Computed<bool>? _$canUpdateComputed;

  @override
  bool get canUpdate =>
      (_$canUpdateComputed ??= Computed<bool>(() => super.canUpdate,
              name: '_ServiceDialogStoreBase.canUpdate'))
          .value;
  Computed<bool>? _$canSubmitComputed;

  @override
  bool get canSubmit =>
      (_$canSubmitComputed ??= Computed<bool>(() => super.canSubmit,
              name: '_ServiceDialogStoreBase.canSubmit'))
          .value;
  Computed<String>? _$computedDesignationComputed;

  @override
  String get computedDesignation => (_$computedDesignationComputed ??=
          Computed<String>(() => super.computedDesignation,
              name: '_ServiceDialogStoreBase.computedDesignation'))
      .value;
  Computed<List<PickerChoice<String>>>? _$unitChoicesComputed;

  @override
  List<PickerChoice<String>> get unitChoices => (_$unitChoicesComputed ??=
          Computed<List<PickerChoice<String>>>(() => super.unitChoices,
              name: '_ServiceDialogStoreBase.unitChoices'))
      .value;
  Computed<bool>? _$isUnitSelectDisabledComputed;

  @override
  bool get isUnitSelectDisabled => (_$isUnitSelectDisabledComputed ??=
          Computed<bool>(() => super.isUnitSelectDisabled,
              name: '_ServiceDialogStoreBase.isUnitSelectDisabled'))
      .value;
  Computed<String?>? _$selectedUnitComputed;

  @override
  String? get selectedUnit =>
      (_$selectedUnitComputed ??= Computed<String?>(() => super.selectedUnit,
              name: '_ServiceDialogStoreBase.selectedUnit'))
          .value;

  late final _$orderRowAtom =
      Atom(name: '_ServiceDialogStoreBase.orderRow', context: context);

  @override
  OrderRow? get orderRow {
    _$orderRowAtom.reportRead();
    return super.orderRow;
  }

  @override
  set orderRow(OrderRow? value) {
    _$orderRowAtom.reportWrite(value, super.orderRow, () {
      super.orderRow = value;
    });
  }

  late final _$serviceAtom =
      Atom(name: '_ServiceDialogStoreBase.service', context: context);

  @override
  Service get service {
    _$serviceAtom.reportRead();
    return super.service;
  }

  @override
  set service(Service value) {
    _$serviceAtom.reportWrite(value, super.service, () {
      super.service = value;
    });
  }

  late final _$option1Atom =
      Atom(name: '_ServiceDialogStoreBase.option1', context: context);

  @override
  ServiceOptionItem? get option1 {
    _$option1Atom.reportRead();
    return super.option1;
  }

  @override
  set option1(ServiceOptionItem? value) {
    _$option1Atom.reportWrite(value, super.option1, () {
      super.option1 = value;
    });
  }

  late final _$option2Atom =
      Atom(name: '_ServiceDialogStoreBase.option2', context: context);

  @override
  ServiceOptionItem? get option2 {
    _$option2Atom.reportRead();
    return super.option2;
  }

  @override
  set option2(ServiceOptionItem? value) {
    _$option2Atom.reportWrite(value, super.option2, () {
      super.option2 = value;
    });
  }

  late final _$taxLevelAtom =
      Atom(name: '_ServiceDialogStoreBase.taxLevel', context: context);

  @override
  TaxLevel get taxLevel {
    _$taxLevelAtom.reportRead();
    return super.taxLevel;
  }

  @override
  set taxLevel(TaxLevel value) {
    _$taxLevelAtom.reportWrite(value, super.taxLevel, () {
      super.taxLevel = value;
    });
  }

  late final _$quantityAtom =
      Atom(name: '_ServiceDialogStoreBase.quantity', context: context);

  @override
  String get quantity {
    _$quantityAtom.reportRead();
    return super.quantity;
  }

  @override
  set quantity(String value) {
    _$quantityAtom.reportWrite(value, super.quantity, () {
      super.quantity = value;
    });
  }

  late final _$quantityControllerAtom = Atom(
      name: '_ServiceDialogStoreBase.quantityController', context: context);

  @override
  TextEditingController get quantityController {
    _$quantityControllerAtom.reportRead();
    return super.quantityController;
  }

  @override
  set quantityController(TextEditingController value) {
    _$quantityControllerAtom.reportWrite(value, super.quantityController, () {
      super.quantityController = value;
    });
  }

  late final _$designationControllerAtom = Atom(
      name: '_ServiceDialogStoreBase.designationController', context: context);

  @override
  TextEditingController get designationController {
    _$designationControllerAtom.reportRead();
    return super.designationController;
  }

  @override
  set designationController(TextEditingController value) {
    _$designationControllerAtom.reportWrite(value, super.designationController,
        () {
      super.designationController = value;
    });
  }

  late final _$grossPriceWithoutTaxMiscellaneousControllerAtom = Atom(
      name:
          '_ServiceDialogStoreBase.grossPriceWithoutTaxMiscellaneousController',
      context: context);

  @override
  TextEditingController get grossPriceWithoutTaxMiscellaneousController {
    _$grossPriceWithoutTaxMiscellaneousControllerAtom.reportRead();
    return super.grossPriceWithoutTaxMiscellaneousController;
  }

  @override
  set grossPriceWithoutTaxMiscellaneousController(TextEditingController value) {
    _$grossPriceWithoutTaxMiscellaneousControllerAtom.reportWrite(
        value, super.grossPriceWithoutTaxMiscellaneousController, () {
      super.grossPriceWithoutTaxMiscellaneousController = value;
    });
  }

  late final _$priceListItemAtom =
      Atom(name: '_ServiceDialogStoreBase.priceListItem', context: context);

  @override
  PriceListItem? get priceListItem {
    _$priceListItemAtom.reportRead();
    return super.priceListItem;
  }

  @override
  set priceListItem(PriceListItem? value) {
    _$priceListItemAtom.reportWrite(value, super.priceListItem, () {
      super.priceListItem = value;
    });
  }

  late final _$defaultPriceListItemAtom = Atom(
      name: '_ServiceDialogStoreBase.defaultPriceListItem', context: context);

  @override
  PriceListItem? get defaultPriceListItem {
    _$defaultPriceListItemAtom.reportRead();
    return super.defaultPriceListItem;
  }

  @override
  set defaultPriceListItem(PriceListItem? value) {
    _$defaultPriceListItemAtom.reportWrite(value, super.defaultPriceListItem,
        () {
      super.defaultPriceListItem = value;
    });
  }

  late final _$alternativePriceListItemAtom = Atom(
      name: '_ServiceDialogStoreBase.alternativePriceListItem',
      context: context);

  @override
  PriceListItem? get alternativePriceListItem {
    _$alternativePriceListItemAtom.reportRead();
    return super.alternativePriceListItem;
  }

  @override
  set alternativePriceListItem(PriceListItem? value) {
    _$alternativePriceListItemAtom
        .reportWrite(value, super.alternativePriceListItem, () {
      super.alternativePriceListItem = value;
    });
  }

  late final _$option1ChoicesAtom =
      Atom(name: '_ServiceDialogStoreBase.option1Choices', context: context);

  @override
  ObservableList<PickerChoice<ServiceOptionItem?>> get option1Choices {
    _$option1ChoicesAtom.reportRead();
    return super.option1Choices;
  }

  @override
  set option1Choices(ObservableList<PickerChoice<ServiceOptionItem?>> value) {
    _$option1ChoicesAtom.reportWrite(value, super.option1Choices, () {
      super.option1Choices = value;
    });
  }

  late final _$option2ChoicesAtom =
      Atom(name: '_ServiceDialogStoreBase.option2Choices', context: context);

  @override
  ObservableList<PickerChoice<ServiceOptionItem?>> get option2Choices {
    _$option2ChoicesAtom.reportRead();
    return super.option2Choices;
  }

  @override
  set option2Choices(ObservableList<PickerChoice<ServiceOptionItem?>> value) {
    _$option2ChoicesAtom.reportWrite(value, super.option2Choices, () {
      super.option2Choices = value;
    });
  }

  late final _$grossPriceWithoutTaxMiscellaneousAtom = Atom(
      name: '_ServiceDialogStoreBase.grossPriceWithoutTaxMiscellaneous',
      context: context);

  @override
  String get grossPriceWithoutTaxMiscellaneous {
    _$grossPriceWithoutTaxMiscellaneousAtom.reportRead();
    return super.grossPriceWithoutTaxMiscellaneous;
  }

  @override
  set grossPriceWithoutTaxMiscellaneous(String value) {
    _$grossPriceWithoutTaxMiscellaneousAtom
        .reportWrite(value, super.grossPriceWithoutTaxMiscellaneous, () {
      super.grossPriceWithoutTaxMiscellaneous = value;
    });
  }

  late final _$designationAtom =
      Atom(name: '_ServiceDialogStoreBase.designation', context: context);

  @override
  String get designation {
    _$designationAtom.reportRead();
    return super.designation;
  }

  @override
  set designation(String value) {
    _$designationAtom.reportWrite(value, super.designation, () {
      super.designation = value;
    });
  }

  late final _$getOption1ChoicesAsyncAction = AsyncAction(
      '_ServiceDialogStoreBase.getOption1Choices',
      context: context);

  @override
  Future<List<PickerChoice<ServiceOptionItem?>>> getOption1Choices() {
    return _$getOption1ChoicesAsyncAction.run(() => super.getOption1Choices());
  }

  late final _$getOption2ChoicesAsyncAction = AsyncAction(
      '_ServiceDialogStoreBase.getOption2Choices',
      context: context);

  @override
  Future<List<PickerChoice<ServiceOptionItem?>>> getOption2Choices() {
    return _$getOption2ChoicesAsyncAction.run(() => super.getOption2Choices());
  }

  late final _$findPriceListAsyncAction =
      AsyncAction('_ServiceDialogStoreBase.findPriceList', context: context);

  @override
  Future<void> findPriceList({bool setPriceListItem = true}) {
    return _$findPriceListAsyncAction
        .run(() => super.findPriceList(setPriceListItem: setPriceListItem));
  }

  late final _$initAsyncAction =
      AsyncAction('_ServiceDialogStoreBase.init', context: context);

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$loadOrderRowDataAsyncAction =
      AsyncAction('_ServiceDialogStoreBase.loadOrderRowData', context: context);

  @override
  Future<void> loadOrderRowData() {
    return _$loadOrderRowDataAsyncAction.run(() => super.loadOrderRowData());
  }

  late final _$loadServiceDataAsyncAction =
      AsyncAction('_ServiceDialogStoreBase.loadServiceData', context: context);

  @override
  Future<void> loadServiceData() {
    return _$loadServiceDataAsyncAction.run(() => super.loadServiceData());
  }

  late final _$_ServiceDialogStoreBaseActionController =
      ActionController(name: '_ServiceDialogStoreBase', context: context);

  @override
  void setGrossPriceWithoutTaxMiscellaneous(String value) {
    final _$actionInfo = _$_ServiceDialogStoreBaseActionController.startAction(
        name: '_ServiceDialogStoreBase.setGrossPriceWithoutTaxMiscellaneous');
    try {
      return super.setGrossPriceWithoutTaxMiscellaneous(value);
    } finally {
      _$_ServiceDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDesignation(String value) {
    final _$actionInfo = _$_ServiceDialogStoreBaseActionController.startAction(
        name: '_ServiceDialogStoreBase.setDesignation');
    try {
      return super.setDesignation(value);
    } finally {
      _$_ServiceDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOption1(ServiceOptionItem? value) {
    final _$actionInfo = _$_ServiceDialogStoreBaseActionController.startAction(
        name: '_ServiceDialogStoreBase.setOption1');
    try {
      return super.setOption1(value);
    } finally {
      _$_ServiceDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOption2(ServiceOptionItem? value) {
    final _$actionInfo = _$_ServiceDialogStoreBaseActionController.startAction(
        name: '_ServiceDialogStoreBase.setOption2');
    try {
      return super.setOption2(value);
    } finally {
      _$_ServiceDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTaxLevel(TaxLevel value) {
    final _$actionInfo = _$_ServiceDialogStoreBaseActionController.startAction(
        name: '_ServiceDialogStoreBase.setTaxLevel');
    try {
      return super.setTaxLevel(value);
    } finally {
      _$_ServiceDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setQuantity(String value) {
    final _$actionInfo = _$_ServiceDialogStoreBaseActionController.startAction(
        name: '_ServiceDialogStoreBase.setQuantity');
    try {
      return super.setQuantity(value);
    } finally {
      _$_ServiceDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUnit(String value) {
    final _$actionInfo = _$_ServiceDialogStoreBaseActionController.startAction(
        name: '_ServiceDialogStoreBase.setUnit');
    try {
      return super.setUnit(value);
    } finally {
      _$_ServiceDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void watchOption1() {
    final _$actionInfo = _$_ServiceDialogStoreBaseActionController.startAction(
        name: '_ServiceDialogStoreBase.watchOption1');
    try {
      return super.watchOption1();
    } finally {
      _$_ServiceDialogStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
orderRow: ${orderRow},
service: ${service},
option1: ${option1},
option2: ${option2},
taxLevel: ${taxLevel},
quantity: ${quantity},
quantityController: ${quantityController},
designationController: ${designationController},
grossPriceWithoutTaxMiscellaneousController: ${grossPriceWithoutTaxMiscellaneousController},
priceListItem: ${priceListItem},
defaultPriceListItem: ${defaultPriceListItem},
alternativePriceListItem: ${alternativePriceListItem},
option1Choices: ${option1Choices},
option2Choices: ${option2Choices},
grossPriceWithoutTaxMiscellaneous: ${grossPriceWithoutTaxMiscellaneous},
designation: ${designation},
isEditing: ${isEditing},
option2isDisabled: ${option2isDisabled},
allOptionsAreValid: ${allOptionsAreValid},
quantityValue: ${quantityValue},
grossPriceWithoutTaxMiscellaneousValue: ${grossPriceWithoutTaxMiscellaneousValue},
quantityIsValid: ${quantityIsValid},
formattedUnitPriceWithoutTax: ${formattedUnitPriceWithoutTax},
grossPriceInclTax: ${grossPriceInclTax},
formattedGrossPriceInclTax: ${formattedGrossPriceInclTax},
totalGrossInclTax: ${totalGrossInclTax},
formattedTotalGrossInclTax: ${formattedTotalGrossInclTax},
isFormValid: ${isFormValid},
canUpdate: ${canUpdate},
canSubmit: ${canSubmit},
computedDesignation: ${computedDesignation},
unitChoices: ${unitChoices},
isUnitSelectDisabled: ${isUnitSelectDisabled},
selectedUnit: ${selectedUnit}
    ''';
  }
}
