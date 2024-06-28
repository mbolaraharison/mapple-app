import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';
export 'package:collection/collection.dart';

part 'service_dialog_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class ServiceDialogStoreInterface {
  ServiceDialogStoreInterface._(
    this.service,
    this.taxLevel,
    this.quantity,
    this.quantityController,
    this.designationController,
    this.grossPriceWithoutTaxMiscellaneousController,
    this.option1Choices,
    this.option2Choices,
    this.grossPriceWithoutTaxMiscellaneous,
    this.designation,
  );

  // Params
  ServiceDialogStoreParams get params;

  // Variables
  OrderRow? orderRow;
  Service service;
  ServiceOptionItem? option1;
  ServiceOptionItem? option2;
  TaxLevel taxLevel;
  String quantity;
  TextEditingController quantityController;
  TextEditingController designationController;
  TextEditingController grossPriceWithoutTaxMiscellaneousController;
  PriceListItem? priceListItem;
  ObservableList<PickerChoice<ServiceOptionItem?>> option1Choices;
  ObservableList<PickerChoice<ServiceOptionItem?>> option2Choices;
  String grossPriceWithoutTaxMiscellaneous;
  String designation;
  PriceListItem? defaultPriceListItem;
  PriceListItem? alternativePriceListItem;

  // Computed
  bool get isEditing;
  bool get option2isDisabled;
  bool get allOptionsAreValid;
  num get quantityValue;
  num get grossPriceWithoutTaxMiscellaneousValue;
  bool get quantityIsValid;
  String get formattedUnitPriceWithoutTax;
  num get grossPriceInclTax;
  String get formattedGrossPriceInclTax;
  num get totalGrossInclTax;
  String get formattedTotalGrossInclTax;
  bool get isFormValid;
  bool get canUpdate;
  bool get canSubmit;
  String get computedDesignation;
  List<PickerChoice<String>> get unitChoices;
  bool get isUnitSelectDisabled;
  String? get selectedUnit;

  // Methods
  Future<void> init();
  void setGrossPriceWithoutTaxMiscellaneous(String value);
  void setDesignation(String value);
  Future<List<PickerChoice<ServiceOptionItem?>>> getOption1Choices();
  Future<List<PickerChoice<ServiceOptionItem?>>> getOption2Choices();
  void setOption1(ServiceOptionItem? value);
  void setOption2(ServiceOptionItem? value);
  void setTaxLevel(TaxLevel value);
  void setQuantity(String value);
  void setUnit(String value);
  Future<void> findPriceList({bool setPriceListItem = true});
  void dispose();
}

// Params:----------------------------------------------------------------------
class ServiceDialogStoreParams {
  ServiceDialogStoreParams({
    this.orderRow,
    required this.service,
  });

  final OrderRow? orderRow;
  final Service service;
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class ServiceDialogStore = _ServiceDialogStoreBase with _$ServiceDialogStore;

abstract class _ServiceDialogStoreBase
    with Store
    implements ServiceDialogStoreInterface {
  // Constructor:---------------------------------------------------------------
  _ServiceDialogStoreBase({required this.params})
      : orderRow = params.orderRow,
        service = params.service,
        taxLevel = params.orderRow != null
            ? params.orderRow!.service!.defaultVat
            : params.service.defaultVat {
    init();
  }

  // Params:--------------------------------------------------------------------
  @override
  final ServiceDialogStoreParams params;

  // Subscriptions:-------------------------------------------------------------
  StreamSubscription<Service?>? _serviceSubscription;
  ReactionDisposer? _serviceOptionReaction;

  // Services:------------------------------------------------------------------
  late final PriceListItemServiceInterface _priceListItemService =
      getIt<PriceListItemServiceInterface>();
  late final ServiceServiceInterface _serviceService =
      getIt<ServiceServiceInterface>();
  late final StringUtilsInterface _stringUtils = getIt<StringUtilsInterface>();

  // Variables:-----------------------------------------------------------------
  @override
  @observable
  OrderRow? orderRow;

  @override
  @observable
  Service service;

  // Store variables:-----------------------------------------------------------
  @override
  @observable
  ServiceOptionItem? option1;

  @override
  @observable
  ServiceOptionItem? option2;

  @override
  @observable
  TaxLevel taxLevel;

  @override
  @observable
  String quantity = '';

  @override
  @observable
  TextEditingController quantityController = TextEditingController();

  @override
  @observable
  TextEditingController designationController = TextEditingController();

  @override
  @observable
  TextEditingController grossPriceWithoutTaxMiscellaneousController =
      TextEditingController();

  @override
  @observable
  PriceListItem? priceListItem;

  @override
  @observable
  PriceListItem? defaultPriceListItem;

  @override
  @observable
  PriceListItem? alternativePriceListItem;

  @override
  @observable
  ObservableList<PickerChoice<ServiceOptionItem?>> option1Choices =
      ObservableList();

  @override
  @observable
  ObservableList<PickerChoice<ServiceOptionItem?>> option2Choices =
      ObservableList();

  // net price
  @override
  @observable
  String grossPriceWithoutTaxMiscellaneous = '';

  @override
  @observable
  String designation = '';

  // Getters:-------------------------------------------------------------------
  @override
  @computed
  bool get isEditing => orderRow != null;

  @override
  @computed
  bool get option2isDisabled => option1 == null;

  @override
  @computed
  bool get allOptionsAreValid {
    if (!service.hasOptions) {
      return true;
    }

    if (service.optionsCount == 1) {
      return option1 != null;
    }

    return option1 != null && option2 != null;
  }

  @override
  @computed
  num get quantityValue {
    final String quantity = this.quantity.replaceAll(',', '.');
    return num.parse(quantity.trim() == '' ? '0' : quantity);
  }

  @override
  @computed
  num get grossPriceWithoutTaxMiscellaneousValue {
    final String grossPriceWithoutTaxMiscellaneous =
        this.grossPriceWithoutTaxMiscellaneous.replaceAll(',', '.');
    return num.parse(grossPriceWithoutTaxMiscellaneous.trim() == ''
        ? '0'
        : grossPriceWithoutTaxMiscellaneous);
  }

  @override
  @computed
  bool get quantityIsValid => quantity.isNotEmpty && quantityValue > 0;

  @override
  @computed
  String get formattedUnitPriceWithoutTax {
    if (priceListItem == null) return '-';

    return getIt<NumberFormatterUtilsInterface>()
        .formatToCurrency(priceListItem!.price);
  }

  @override
  @computed
  num get grossPriceInclTax {
    if (priceListItem == null && service.isMiscellanous == false) return 0;

    if (service.isMiscellanous == true) {
      return grossPriceWithoutTaxMiscellaneousValue *
          (1 + (taxLevel.value / 100));
    }

    return priceListItem!.price * (1 + (taxLevel.value / 100));
  }

  @override
  @computed
  String get formattedGrossPriceInclTax {
    if (priceListItem == null && service.isMiscellanous == false) return '-';

    return getIt<NumberFormatterUtilsInterface>()
        .formatToCurrency(grossPriceInclTax.toDouble());
  }

  @override
  @computed
  num get totalGrossInclTax {
    if (priceListItem == null && service.isMiscellanous == false) return 0;

    if (service.isMiscellanous == true) {
      return grossPriceInclTax * quantityValue;
    }

    return priceListItem!.unit == PriceListItem.packageUnit
        ? grossPriceInclTax
        : grossPriceInclTax * quantityValue;
  }

  @override
  @computed
  String get formattedTotalGrossInclTax {
    if (priceListItem == null && service.isMiscellanous == false) return '-';

    return getIt<NumberFormatterUtilsInterface>()
        .formatToCurrency(totalGrossInclTax.toDouble());
  }

  @override
  @computed
  bool get isFormValid =>
      allOptionsAreValid &&
      quantityIsValid &&
      (priceListItem != null ||
          (service.isMiscellanous == true &&
              grossPriceWithoutTaxMiscellaneousValue > 0 &&
              designation.isNotEmpty));

  @override
  @computed
  bool get canUpdate =>
      isFormValid &&
      (orderRow!.quantity != quantityValue ||
          orderRow!.taxLevel != taxLevel ||
          orderRow!.priceListItem?.id != priceListItem?.id ||
          orderRow!.grossPrice != grossPriceWithoutTaxMiscellaneousValue ||
          orderRow!.designation != designation ||
          orderRow!.option1?.id != option1?.id ||
          orderRow!.option2?.id != option2?.id);

  @override
  @computed
  bool get canSubmit => isEditing ? canUpdate : isFormValid;

  @override
  @computed
  String get computedDesignation {
    if (option1 == null && option2 == null) {
      return _stringUtils.valueIfNotEmpty(service.designation) ?? '';
    }
    if (option2 == null) {
      ServiceOption? serviceOption = service.options
          .firstWhereOrNull((element) => element.option1Id == option1!.id);
      if (serviceOption == null) {
        return _stringUtils.valueIfNotEmpty(service.designation) ?? '';
      }
      return _stringUtils.valueIfNotEmpty(serviceOption.designation) ??
          _stringUtils.valueIfNotEmpty(service.designation) ??
          '';
    }
    ServiceOption? serviceOption = service.options.firstWhereOrNull((element) =>
        element.option1Id == option1!.id && element.option2Id == option2!.id);
    if (serviceOption == null) {
      return _stringUtils.valueIfNotEmpty(service.designation) ?? '';
    }
    return _stringUtils.valueIfNotEmpty(serviceOption.designation) ??
        _stringUtils.valueIfNotEmpty(service.designation) ??
        '';
  }

  @override
  @computed
  List<PickerChoice<String>> get unitChoices {
    final List<PickerChoice<String>> choices = [];
    if (defaultPriceListItem != null) {
      choices.add(PickerChoice(
        value: defaultPriceListItem!.unit,
        label: '${defaultPriceListItem!.unit} (${'by_default'.tr()})',
      ));
    }
    if (alternativePriceListItem != null) {
      choices.add(PickerChoice(
        value: alternativePriceListItem!.unit,
        label: alternativePriceListItem!.unit,
      ));
    }
    return choices;
  }

  @override
  @computed
  bool get isUnitSelectDisabled {
    return unitChoices.length < 2;
  }

  @override
  @computed
  String? get selectedUnit {
    return priceListItem?.unit;
  }

  // Actions:-------------------------------------------------------------------
  @override
  @action
  void setGrossPriceWithoutTaxMiscellaneous(String value) {
    grossPriceWithoutTaxMiscellaneous = value.trim() == '' ? '0' : value;
  }

  @override
  @action
  void setDesignation(String value) {
    designation = value;
  }

  @override
  @action
  Future<List<PickerChoice<ServiceOptionItem?>>> getOption1Choices() async {
    if (service.hasOptions == false) return [];
    if (service.firstLevelOptionItems == null) return [];

    final List<PickerChoice<ServiceOptionItem?>> options = [
      const PickerChoice(value: null, label: ' '),
    ];
    options.addAll(service.firstLevelOptionItems!
        .map((e) => PickerChoice(value: e, label: e.label))
        .toList());

    // Order by label
    options.sort((a, b) => a.label.compareTo(b.label));

    return options;
  }

  @override
  @action
  Future<List<PickerChoice<ServiceOptionItem?>>> getOption2Choices() async {
    if (service.hasOptions == false || service.optionsCount != 2) return [];

    final List<PickerChoice<ServiceOptionItem?>> options = [
      const PickerChoice(value: null, label: ' '),
    ];

    if (option1 == null) return options;

    options.addAll(service
        .getSecondLevelOptionItems(option1!)!
        .map((e) => PickerChoice(value: e, label: e.label))
        .toList());

    // Order by label
    options.sort((a, b) => a.label.compareTo(b.label));

    return options;
  }

  @override
  @action
  void setOption1(ServiceOptionItem? value) {
    option2 = null;
    option1 = value;
    priceListItem = null;
    findPriceList();
  }

  @override
  @action
  void setOption2(ServiceOptionItem? value) {
    option2 = value;
    priceListItem = null;
    findPriceList();
  }

  @override
  @action
  void setTaxLevel(TaxLevel value) {
    taxLevel = value;
  }

  @override
  @action
  void setQuantity(String value) {
    quantity = value;
    priceListItem = null;
    findPriceList();
  }

  @override
  @action
  void setUnit(String value) {
    if (defaultPriceListItem?.unit == value &&
        priceListItem != defaultPriceListItem) {
      priceListItem = defaultPriceListItem;
    } else if (alternativePriceListItem?.unit == value &&
        priceListItem != alternativePriceListItem) {
      priceListItem = alternativePriceListItem;
    }
  }

  @override
  @action
  Future<void> findPriceList({bool setPriceListItem = true}) async {
    if (!allOptionsAreValid || !quantityIsValid) return;

    final result = await _priceListItemService.findOneByServiceAndOptions(
      service,
      option1,
      option2,
      quantityValue,
    );
    defaultPriceListItem = result.defaultPriceListItem;
    alternativePriceListItem = result.alternativePriceListItem;
    if (setPriceListItem == true) {
      priceListItem = defaultPriceListItem;
    }
  }

  @override
  @action
  Future<void> init() async {
    // load related service objects
    if (isEditing == false) {
      await loadServiceData();
      return;
    }
    await loadOrderRowData();
    option1 = orderRow!.option1;
    option2 = orderRow!.option2;
    quantity = orderRow!.quantity.toString();
    quantityController.text = quantity;
    priceListItem = orderRow!.priceListItem;
    taxLevel = orderRow!.taxLevel;
    designation = orderRow!.designation;
    grossPriceWithoutTaxMiscellaneous = orderRow!.grossPrice.toString();
    grossPriceWithoutTaxMiscellaneousController.text =
        grossPriceWithoutTaxMiscellaneous;
    designationController.text = designation;
    await findPriceList(setPriceListItem: false);
  }

  @action
  Future<void> loadOrderRowData() async {
    await orderRow!.loadData(eager: true);
    for (int i = 0; i < orderRow!.service!.options.length; i++) {
      await orderRow!.service!.options[i].loadData(eager: true);
    }
    service = orderRow!.service!;
    option1Choices = ObservableList.of(await getOption1Choices());
    option2Choices = ObservableList.of(await getOption2Choices());
    watchOption1();
  }

  @action
  Future<void> loadServiceData() async {
    // first load
    await service.loadData(eager: true);
    for (int i = 0; i < service.options.length; i++) {
      await service.options[i].loadData(eager: true);
    }
    option1Choices = ObservableList.of(await getOption1Choices());
    option2Choices = ObservableList.of(await getOption2Choices());
    // then watch
    _serviceSubscription?.cancel();
    _serviceSubscription = _serviceService
        .getByIdAsStream(service.id)
        .listen((watchedService) async {
      if (watchedService != null) {
        await watchedService.loadData(eager: true);
        for (int i = 0; i < watchedService.options.length; i++) {
          await watchedService.options[i].loadData(eager: true);
        }
        service = watchedService;
      }
    });
    // watch option1
    watchOption1();
  }

  @action
  void watchOption1() {
    _serviceOptionReaction?.reaction.dispose();
    _serviceOptionReaction = reaction((_) => option1, (_) async {
      option2Choices = ObservableList.of(await getOption2Choices());
    });
  }

  @override
  void dispose() {
    _serviceSubscription?.cancel();
    _serviceOptionReaction?.reaction.dispose();
  }
}
