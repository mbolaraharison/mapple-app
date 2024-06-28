import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'payment_step_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class PaymentStepStoreInterface {
  PaymentStepStoreInterface._(
    this.paymentFormErrorStore,
    this.isCashPayment,
    this.isFinancingPayment,
    this.creditAmount,
  );
  // Variables:-----------------------------------------------------------------
  int? intermediatePaymentPercentage;
  double? intermediatePaymentAmount;
  double? endOfWorksPaymentAmount;
  PaymentTerms? paymentTerms;
  InsuranceType? insuranceType;
  Deferment? deferment;
  double? depositAmount;
  double? nominalRate;
  int? monthlyPaymentsCount;
  double? apr;
  double? creditTotalCost;
  double? monthlyPaymentAmount;
  FormErrorStoreInterface paymentFormErrorStore;
  VoidCallback? initTextEditingControllers;
  bool isCashPayment;
  bool isFinancingPayment;
  CashPaymentMethod? cashPaymentMethod;
  FinancingPaymentMethod? financingPaymentMethod;
  double creditAmount;

  // Computed:------------------------------------------------------------------
  bool get isSubmittable;
  String get formattedIntermediatePaymentPercentage;
  List<SelectChoice<int>> get intermediatePaymentChoices;
  double? get computedIntermediatePaymentAmount;
  String get formattedIntermediatePaymentAmount;
  int? get endOfWorksPaymentPercentage;
  String get formattedEndOfWorksPaymentPercentage;
  double? get computedEndOfWorksPaymentAmount;
  String get formattedEndOfWorksPaymentAmount;
  double get totalWithDepositDeducted;
  String get formattedTotalWithDepositDeducted;
  bool get depositAmountIsInvalid;
  bool get monthlyPaymentsCountIsInvalid;
  bool get creditTotalCostIsInvalid;
  bool get monthlyPaymentAmountIsInvalid;
  bool get nominalRateIsInvalid;
  bool get aprIsInvalid;
  bool get hasChanges;

  // Methods:-------------------------------------------------------------------
  void init();
  void loadData();
  Future<bool> save(BuildContext context);
  void setDepositAmount(String value);
  void setDepositAmountController(TextEditingController? controller);
  void setPaymentTerms(PaymentTerms value);
  void setIntermediatePaymentPercentage(int value);
  void setIntermediatePaymentAmount(String value, {bool save = false});
  void setIntermediatePaymentAmountController(
      TextEditingController? controller);
  void setEndOfWorksPaymentAmount(String value);
  void setEndOfWorksPaymentAmountController(TextEditingController? controller);
  void setNominalRate(String value);
  void setNumberOfMonthlyPayments(String value);
  void setApr(String value);
  void setCreditTotalCost(String value);
  void setInsuranceType(InsuranceType value);
  void setMonthlyPaymentsAmount(String value);
  void setDeferment(Deferment value);
  void setInitTextEditingControllers(VoidCallback? cb);
  void checkIntermediatePaymentCompatibility();
  void setIsCashPayment(bool value);
  void setIsFinancingPayment(bool value);
  void setCashPaymentMethod(CashPaymentMethod value);
  void setFinancingPaymentMethod(FinancingPaymentMethod value);
  void dispose();
}

// Params:----------------------------------------------------------------------
class PaymentStepStoreParams {
  PaymentStepStoreParams({
    required this.customerOrderStore,
  });

  final CustomerOrderStore customerOrderStore;
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class PaymentStepStore = _PaymentStepStoreBase with _$PaymentStepStore;

abstract class _PaymentStepStoreBase
    with Store
    implements PaymentStepStoreInterface {
  _PaymentStepStoreBase({required PaymentStepStoreParams params})
      : customerOrderStore = params.customerOrderStore {
    init();
  }

  final CustomerOrderStore customerOrderStore;

  // Dependencies:--------------------------------------------------------------
  final NumberFormatterUtilsInterface _numberFormatterUtils =
      getIt<NumberFormatterUtilsInterface>();

  // Variables:-----------------------------------------------------------------
  @override
  @observable
  int? intermediatePaymentPercentage;

  @override
  @observable
  double? intermediatePaymentAmount;

  @override
  @observable
  double? endOfWorksPaymentAmount;

  @override
  @observable
  double? creditTotalCost;

  @override
  @observable
  double? depositAmount;

  @override
  @observable
  InsuranceType? insuranceType;

  @override
  @observable
  double? monthlyPaymentAmount;

  @override
  @observable
  int? monthlyPaymentsCount;

  @override
  @observable
  double? nominalRate;

  @observable
  String? orderFormId; // This id is generated from app and sent back to Sage

  @observable
  String? orderType;

  @observable
  Origin? origin;

  @observable
  OriginDetails? originDetails;

  @override
  @observable
  PaymentTerms? paymentTerms;

  @override
  @observable
  Deferment? deferment;

  @override
  @observable
  double? apr;

  @observable
  TextEditingController? depositAmountController;

  @observable
  TextEditingController? intermediatePaymentAmountController;

  @observable
  TextEditingController? endOfWorksPaymentAmountController;

  @override
  VoidCallback? initTextEditingControllers;

  @override
  @observable
  bool isCashPayment = false;

  @override
  @observable
  bool isFinancingPayment = false;

  @override
  @observable
  CashPaymentMethod? cashPaymentMethod;

  @override
  @observable
  FinancingPaymentMethod? financingPaymentMethod;

  @override
  @observable
  double creditAmount = 0;

  @override
  FormErrorStoreInterface paymentFormErrorStore =
      getIt<FormErrorStoreInterface>(param1: [
    'intermediatePaymentAmount',
    'nominalRate',
    'apr',
    'creditTotalCost',
    'monthlyPaymentAmount',
    'monthlyPaymentsCount',
    'depositAmount',
  ]);

  // Subscriptions:-------------------------------------------------------------
  ReactionDisposer? _orderReactionDisposer;

  // Computed:------------------------------------------------------------------
  @override
  @computed
  List<SelectChoice<int>> get intermediatePaymentChoices {
    if (customerOrderStore.orderStepStore.isCleaningRelated) {
      return [
        const SelectChoice(value: 0, label: '0 %'),
        const SelectChoice(value: 40, label: '40 %'),
      ];
    } else {
      return [
        const SelectChoice(value: 0, label: '0 %'),
      ];
    }
  }

  @override
  @computed
  double get totalWithDepositDeducted {
    if (depositAmount == null) {
      return customerOrderStore.order.totalNetInclTax;
    }

    return customerOrderStore.order.totalNetInclTax - depositAmount!;
  }

  @override
  @computed
  String get formattedTotalWithDepositDeducted {
    return getIt<NumberFormatterUtilsInterface>()
        .formatToCurrency(totalWithDepositDeducted);
  }

  @override
  @computed
  String get formattedIntermediatePaymentPercentage {
    if (intermediatePaymentPercentage == null) {
      return '';
    }
    return '$intermediatePaymentPercentage%';
  }

  @override
  @computed
  int? get endOfWorksPaymentPercentage {
    if (intermediatePaymentPercentage == null) {
      return null;
    }

    return 100 - intermediatePaymentPercentage!;
  }

  @override
  @computed
  String get formattedEndOfWorksPaymentPercentage {
    if (endOfWorksPaymentPercentage == null) {
      return '';
    }

    return '$endOfWorksPaymentPercentage%';
  }

  @computed
  double get depositPercentage {
    if (depositAmount == null || depositAmount == 0) {
      return 0;
    }
    return (depositAmount! / customerOrderStore.order.totalNetInclTax) * 100;
  }

  @computed
  double get cleaningRelatedTotalWithDeposit {
    return customerOrderStore.orderStepStore.cleaningRelatedTotal *
        (1 - (depositPercentage / 100));
  }

  @override
  @computed
  double? get computedIntermediatePaymentAmount {
    if (intermediatePaymentPercentage == null) {
      return null;
    }

    if (customerOrderStore.orderStepStore.isCleaningRelated) {
      return cleaningRelatedTotalWithDeposit *
          intermediatePaymentPercentage! /
          100;
    } else {
      return totalWithDepositDeducted * intermediatePaymentPercentage! / 100;
    }
  }

  @override
  @computed
  String get formattedIntermediatePaymentAmount {
    if (computedIntermediatePaymentAmount == null) {
      return '';
    }

    return getIt<NumberFormatterUtilsInterface>()
        .formatToCurrency(computedIntermediatePaymentAmount!);
  }

  @override
  @computed
  double? get computedEndOfWorksPaymentAmount {
    if (intermediatePaymentPercentage == null) {
      return null;
    }

    if (customerOrderStore.orderStepStore.isCleaningRelated) {
      return totalWithDepositDeducted - computedIntermediatePaymentAmount!;
    } else {
      return totalWithDepositDeducted * endOfWorksPaymentPercentage! / 100;
    }
  }

  @override
  @computed
  String get formattedEndOfWorksPaymentAmount {
    if (computedEndOfWorksPaymentAmount == null) {
      return '';
    }

    return getIt<NumberFormatterUtilsInterface>()
        .formatToCurrency(computedEndOfWorksPaymentAmount!);
  }

  @override
  @computed
  bool get depositAmountIsInvalid =>
      paymentFormErrorStore.errors['depositAmount'] != null;

  @override
  @computed
  bool get monthlyPaymentsCountIsInvalid =>
      paymentFormErrorStore.errors['monthlyPaymentsCount'] != null;

  @override
  @computed
  bool get creditTotalCostIsInvalid =>
      paymentFormErrorStore.errors['creditTotalCost'] != null;

  @override
  @computed
  bool get monthlyPaymentAmountIsInvalid =>
      paymentFormErrorStore.errors['monthlyPaymentAmount'] != null;

  @override
  @computed
  bool get nominalRateIsInvalid =>
      paymentFormErrorStore.errors['nominalRate'] != null;

  @override
  @computed
  bool get aprIsInvalid => paymentFormErrorStore.errors['apr'] != null;

  @override
  @computed
  bool get isSubmittable {
    if (depositAmount == null) {
      return false;
    }

    // If payment method is cash only
    if (isCashPayment && !isFinancingPayment && cashPaymentMethod != null) {
      return true;
    }

    // If payment method is financing only
    if (!isCashPayment &&
        isFinancingPayment &&
        financingPaymentMethod != null &&
        nominalRate != null &&
        monthlyPaymentsCount != null &&
        apr != null &&
        creditTotalCost != null &&
        monthlyPaymentAmount != null &&
        deferment != null) {
      return true;
    }

    // If payment method is cash and financing
    if (isCashPayment &&
        isFinancingPayment &&
        cashPaymentMethod != null &&
        financingPaymentMethod != null &&
        nominalRate != null &&
        monthlyPaymentsCount != null &&
        apr != null &&
        creditTotalCost != null &&
        monthlyPaymentAmount != null &&
        deferment != null) {
      return true;
    }

    return false;
  }

  @override
  @computed
  bool get hasChanges {
    return customerOrderStore.order.intermediatePaymentPercentage !=
            intermediatePaymentPercentage ||
        customerOrderStore.order.intermediatePaymentAmount !=
            intermediatePaymentAmount ||
        customerOrderStore.order.creditTotalCost != creditTotalCost ||
        customerOrderStore.order.depositAmount != depositAmount ||
        customerOrderStore.order.insuranceType != insuranceType ||
        customerOrderStore.order.monthlyPaymentAmount != monthlyPaymentAmount ||
        customerOrderStore.order.monthlyPaymentsCount != monthlyPaymentsCount ||
        customerOrderStore.order.nominalRate != nominalRate ||
        customerOrderStore.order.deferment != deferment ||
        customerOrderStore.order.apr != apr ||
        customerOrderStore.order.isCashPayment != isCashPayment ||
        customerOrderStore.order.isFinancingPayment != isFinancingPayment ||
        customerOrderStore.order.cashPaymentMethod != cashPaymentMethod ||
        customerOrderStore.order.financingPaymentMethod !=
            financingPaymentMethod ||
        customerOrderStore.order.creditAmount != creditAmount;
  }

  Order get _order => customerOrderStore.order;

  // Actions:-------------------------------------------------------------------
  @override
  @action
  void init() {
    _orderReactionDisposer?.reaction.dispose();
    _orderReactionDisposer = reaction(
      (_) => customerOrderStore.order,
      (Order? order) {
        loadData();
      },
    );
  }

  @override
  @action
  void loadData() {
    if (_order.isCashPayment == null && _order.isFinancingPayment == null) {
      _checkPaymentRetrocompatibility();
    }

    isCashPayment = _order.isCashPayment ?? false;
    isFinancingPayment = _order.isFinancingPayment ?? false;
    cashPaymentMethod = _order.cashPaymentMethod;
    financingPaymentMethod = _order.financingPaymentMethod;
    intermediatePaymentPercentage =
        customerOrderStore.order.intermediatePaymentPercentage;
    intermediatePaymentAmount =
        customerOrderStore.order.intermediatePaymentAmount;
    creditAmount = customerOrderStore.order.creditAmount;
    creditTotalCost = customerOrderStore.order.creditTotalCost;
    depositAmount = customerOrderStore.order.depositAmount;
    insuranceType = customerOrderStore.order.insuranceType;
    monthlyPaymentAmount = customerOrderStore.order.monthlyPaymentAmount;
    monthlyPaymentsCount = customerOrderStore.order.monthlyPaymentsCount;
    nominalRate = customerOrderStore.order.nominalRate;
    deferment = customerOrderStore.order.deferment;
    apr = customerOrderStore.order.apr;

    computeEndOfWorksPaymentAmount();
  }

  @override
  @action
  void setPaymentTerms(PaymentTerms value) {
    paymentTerms = value;
  }

  @override
  @action
  void setDepositAmount(String value) {
    if (value.isEmpty) {
      depositAmount = null;
      return;
    }
    depositAmount = getIt<NumberFormatterUtilsInterface>().parseToDouble(value);
    // If not financing payment => compute intermediate payment amount
    if (!isFinancingPayment) {
      computeEndOfWorksPaymentAmount();
    } else {
      // If financing payment => compute credit amount
      computeCreditAmount();
    }
  }

  @override
  @action
  void setIntermediatePaymentPercentage(int value) {
    intermediatePaymentPercentage = value;
  }

  @override
  @action
  void setIntermediatePaymentAmount(String value, {save = false}) {
    double? parsedValue = _numberFormatterUtils.parseToDoubleOrNull(value);
    if (parsedValue == null) {
      parsedValue = 0;
      intermediatePaymentAmountController!.text = '0';
    }
    intermediatePaymentAmount =
        _numberFormatterUtils.parseToDoubleOrNull(parsedValue);
    // If not financing payment => compute end of works payment amount
    // If financing payment => do not compute end of works payment amount, the rest of the amount is the credit amount
    if (!isFinancingPayment) {
      computeEndOfWorksPaymentAmount();
    } else {
      // If financing payment => compute credit amount
      computeCreditAmount();
    }
    if (save == true) {
      customerOrderStore.order.intermediatePaymentAmount =
          intermediatePaymentAmount;
      customerOrderStore.order.intermediatePaymentPercentage = null;
      customerOrderStore.updateOrder();
    }
  }

  @override
  @action
  void setIntermediatePaymentAmountController(
      TextEditingController? controller) {
    intermediatePaymentAmountController = controller;
  }

  @override
  @action
  void setEndOfWorksPaymentAmount(String value) {
    endOfWorksPaymentAmount = _numberFormatterUtils.parseToDoubleOrNull(value);
    // If not financing payment => compute intermediate payment amount
    // If financing payment => do not compute intermediate payment amount, the rest of the amount is the credit amount
    if (!isFinancingPayment) {
      intermediatePaymentAmount =
          totalWithDepositDeducted - (endOfWorksPaymentAmount ?? 0);
      intermediatePaymentAmountController!.text = _numberFormatterUtils
          .formatToDoubleWith2Decimals(intermediatePaymentAmount!);
    } else {
      // If financing payment => compute credit amount
      computeCreditAmount();
    }
  }

  @override
  @action
  void setEndOfWorksPaymentAmountController(TextEditingController? controller) {
    endOfWorksPaymentAmountController = controller;
  }

  @action
  void computeEndOfWorksPaymentAmount() {
    // If not cash payment => end of works payment amount is 0
    if (!isCashPayment) {
      endOfWorksPaymentAmount = 0;
      return;
    }

    // If cash payment only => end of works payment amount is total with deposit - intermediate payment amount
    if (isCashPayment && !isFinancingPayment) {
      endOfWorksPaymentAmount =
          totalWithDepositDeducted - (intermediatePaymentAmount ?? 0);
    }

    // If cash payment and financing payment => end of works payment amount is total with deposit - intermediate payment amount - credit amount
    if (isCashPayment && isFinancingPayment) {
      endOfWorksPaymentAmount = totalWithDepositDeducted -
          (intermediatePaymentAmount ?? 0) -
          creditAmount;
    }

    if (endOfWorksPaymentAmountController != null) {
      endOfWorksPaymentAmountController!.text = _numberFormatterUtils
          .formatToDoubleWith2Decimals(endOfWorksPaymentAmount!);
    }
  }

  @action
  void computeCreditAmount() {
    if (!isFinancingPayment) {
      creditAmount = 0;
      return;
    }

    // if financing payment only => credit amount is total with deposit
    if (isFinancingPayment && !isCashPayment) {
      creditAmount = totalWithDepositDeducted;
      return;
    }

    // if financing payment and cash payment => credit amount is total with deposit - intermediate payment amount - end of works payment amount
    creditAmount = totalWithDepositDeducted -
        (intermediatePaymentAmount ?? 0) -
        (endOfWorksPaymentAmount ?? 0);
  }

  @override
  @action
  void setInsuranceType(InsuranceType value) {
    insuranceType = value;
  }

  @override
  @action
  void setDeferment(Deferment value) {
    deferment = value;
  }

  @override
  @action
  void setNominalRate(String value) {
    if (value.isEmpty) {
      nominalRate = null;
      return;
    }
    nominalRate =
        getIt<NumberFormatterUtilsInterface>().parseToDoubleOrNull(value);
  }

  @override
  @action
  void setNumberOfMonthlyPayments(String value) {
    if (value.isEmpty) {
      monthlyPaymentsCount = null;
      return;
    }
    monthlyPaymentsCount = int.parse(value);
  }

  @override
  @action
  void setApr(String value) {
    if (value.isEmpty) {
      apr = null;
      return;
    }
    apr = getIt<NumberFormatterUtilsInterface>().parseToDoubleOrNull(value);
  }

  @override
  @action
  void setCreditTotalCost(String value) {
    if (value.isEmpty) {
      creditTotalCost = null;
      return;
    }
    creditTotalCost =
        getIt<NumberFormatterUtilsInterface>().parseToDouble(value);
  }

  @override
  @action
  void setMonthlyPaymentsAmount(String value) {
    if (value.isEmpty) {
      monthlyPaymentAmount = null;
      return;
    }
    monthlyPaymentAmount =
        getIt<NumberFormatterUtilsInterface>().parseToDouble(value);
  }

  @action
  bool validatePaymentForm() {
    paymentFormErrorStore.resetErrors();

    if (depositAmount != null) {
      if (depositAmount! > customerOrderStore.order.totalNetInclTax) {
        paymentFormErrorStore.setError(
          'depositAmount',
          'cart.deposit_amount_greater_than_total_error'.tr(),
        );
        return false;
      }
    }

    if (isCashPayment == false && isFinancingPayment == false) {
      paymentFormErrorStore.setError(
        'payment_type',
        'cart.payment_type_error'.tr(),
      );
      return false;
    }

    if (isCashPayment) {
      if (cashPaymentMethod == null) {
        paymentFormErrorStore.setError(
          'cashPaymentMethod',
          'cart.cash_payment_method_error'.tr(),
        );
        return false;
      }

      if (intermediatePaymentAmount == 0 && endOfWorksPaymentAmount == 0) {
        paymentFormErrorStore.setError(
          'cashPaymentMethod',
          'cart.cash_payment_method_empty_error'.tr(),
        );
        return false;
      }

      if (intermediatePaymentAmount != null &&
          intermediatePaymentAmount! > totalWithDepositDeducted) {
        paymentFormErrorStore.setError(
          'intermediatePaymentAmount',
          'cart.intermediate_payment_greater_than_total_error'.tr(),
        );
        return false;
      }
      if (intermediatePaymentAmount != null && intermediatePaymentAmount! < 0) {
        paymentFormErrorStore.setError(
          'intermediatePaymentAmount',
          'cart.intermediate_payment_less_than_zero_error'.tr(),
        );
        return false;
      }
    }

    if (isFinancingPayment) {
      if (financingPaymentMethod == null) {
        paymentFormErrorStore.setError(
          'financingPaymentMethod',
          'cart.financing_payment_method_error'.tr(),
        );
        return false;
      }

      if (creditAmount <= 0) {
        paymentFormErrorStore.setError(
          'creditAmount',
          'cart.credit_amount_error'.tr(),
        );
        return false;
      }

      if (nominalRate == null ||
          nominalRate! < 0 ||
          nominalRate! > 100 ||
          nominalRate! == 0) {
        paymentFormErrorStore.setError(
            'nominalRate', 'cart.nominal_rate_error'.tr());
        return false;
      }

      if (monthlyPaymentsCount == null || monthlyPaymentsCount! < 1) {
        paymentFormErrorStore.setError(
            'monthlyPaymentsCount', 'cart.monthly_payments_count_error'.tr());
        return false;
      }

      if (apr == null || apr! < 0 || apr! > 100 || apr! == 0) {
        paymentFormErrorStore.setError('apr', 'cart.apr_error'.tr());
        return false;
      }

      if (creditTotalCost == null || creditTotalCost! < 1) {
        paymentFormErrorStore.setError(
            'creditTotalCost', 'cart.credit_total_cost_error'.tr());
        return false;
      }

      if (monthlyPaymentAmount == null || monthlyPaymentAmount! < 1) {
        paymentFormErrorStore.setError(
            'monthlyPaymentAmount', 'cart.monthly_payment_amount_error'.tr());
        return false;
      }
    }

    return true;
  }

  @override
  @action
  void setDepositAmountController(TextEditingController? controller) {
    depositAmountController = controller;
  }

  @override
  @action
  Future<bool> save(BuildContext context) async {
    if (customerOrderStore.step != 2 && !hasChanges) {
      return false;
    }

    validatePaymentForm();
    paymentFormErrorStore.throwIfError();

    customerOrderStore.order.isCashPayment = isCashPayment;
    customerOrderStore.order.isFinancingPayment = isFinancingPayment;
    customerOrderStore.order.cashPaymentMethod = cashPaymentMethod;
    customerOrderStore.order.financingPaymentMethod = financingPaymentMethod;
    if (isFinancingPayment) {
      customerOrderStore.order.paymentTerms =
          PaymentTerms.fromValue(financingPaymentMethod!.name);
    } else {
      customerOrderStore.order.paymentTerms =
          PaymentTerms.fromValue(cashPaymentMethod?.name);
    }

    customerOrderStore.order.depositAmount = depositAmount ?? 0;
    customerOrderStore.order.intermediatePaymentPercentage =
        intermediatePaymentPercentage;
    customerOrderStore.order.insuranceType =
        insuranceType ?? InsuranceType.none;
    customerOrderStore.order.deferment = deferment ?? Deferment.thirtyDays;
    customerOrderStore.order.nominalRate = nominalRate ?? 0;
    customerOrderStore.order.monthlyPaymentAmount = monthlyPaymentAmount ?? 0;
    customerOrderStore.order.monthlyPaymentsCount = monthlyPaymentsCount ?? 0;
    customerOrderStore.order.apr = apr ?? 0;
    customerOrderStore.order.intermediatePaymentAmount =
        intermediatePaymentAmount;
    customerOrderStore.order.creditTotalCost = creditTotalCost ?? 0;
    customerOrderStore.order.creditAmount = creditAmount;
    customerOrderStore.order.setShouldRecreateEnvelope(true);
    customerOrderStore.updateOrder();

    return true;
  }

  @override
  void setInitTextEditingControllers(VoidCallback? cb) {
    initTextEditingControllers = cb;
  }

  @override
  @action
  void setIsCashPayment(bool value) {
    isCashPayment = value;
    if (!value) {
      cashPaymentMethod = null;
      intermediatePaymentAmount = null;
      endOfWorksPaymentAmount = null;

      initTextEditingControllers?.call();

      // If disable cash payment method => recompute credit amount
      computeCreditAmount();
    } else {
      intermediatePaymentAmount = 0;
      endOfWorksPaymentAmount = 0;

      computeEndOfWorksPaymentAmount();

      initTextEditingControllers?.call();
    }
  }

  @override
  @action
  void setIsFinancingPayment(bool value) {
    isFinancingPayment = value;
    // If disable financing payment method => reset all financing payment method fields
    if (!value) {
      financingPaymentMethod = null;
      creditAmount = 0;
      nominalRate = 0;
      monthlyPaymentsCount = 0;
      apr = 0;
      creditTotalCost = 0;
      monthlyPaymentAmount = 0;
      deferment = Deferment.thirtyDays;
      insuranceType = InsuranceType.none;

      computeEndOfWorksPaymentAmount();

      initTextEditingControllers?.call();
      return;
    }

    computeCreditAmount();
    initTextEditingControllers?.call();
  }

  @override
  @action
  void setCashPaymentMethod(CashPaymentMethod value) {
    cashPaymentMethod = value;
  }

  @override
  @action
  void setFinancingPaymentMethod(FinancingPaymentMethod value) {
    financingPaymentMethod = value;
  }

  @override
  void dispose() {
    _orderReactionDisposer?.reaction.dispose();
  }

  // Retrocompatibility:--------------------------------------------------------
  @override
  @action
  void checkIntermediatePaymentCompatibility() {
    if (intermediatePaymentAmount != null ||
        intermediatePaymentPercentage == null) {
      return;
    }

    // If intermediatePaymentPercentage is not null and intermediatePaymentAmount is null
    // => set intermediatePaymentAmount
    setIntermediatePaymentAmount(
      _numberFormatterUtils.formatToDoubleWith2Decimals(
        computedIntermediatePaymentAmount!,
      ),
      save: true,
    );
    if (customerOrderStore.order.status == OrderStatus.Z) {
      Fluttertoast.showToast(
        msg: 'cart.intermediate_payment_change_warning'.tr(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 15,
        backgroundColor: CupertinoColors.activeGreen,
        textColor: CupertinoColors.white,
        fontSize: 16.0,
      );
    }
  }

  void _checkPaymentRetrocompatibility() {
    // If isCashPayment and is FinancingPayment are null => it's the old way of payment
    // Update order to the new way
    // Check if paymentTerms is cash -> if cash set it to cashPaymentMethod
    if (!_order.paymentTerms.isFunderStatus) {
      _order.isCashPayment = true;
      _order.isFinancingPayment = false;
      _order.cashPaymentMethod =
          CashPaymentMethod.fromValue(_order.paymentTerms.name);
    } else {
      _order.isFinancingPayment = true;
      _order.financingPaymentMethod =
          FinancingPaymentMethod.fromValue(_order.paymentTerms.name);

      // Diff is the difference between the total with deposit deducted and the credit amount
      // If diff is inferior or equal to 2, it's not a partial financing
      // Else, it's a partial financing
      final diff = totalWithDepositDeducted - creditAmount;
      if (diff <= 2) {
        _order.isCashPayment = false;
      } else {
        _order.isCashPayment = true;
      }
    }
    customerOrderStore.updateOrder();
  }
}
