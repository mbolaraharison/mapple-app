import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:maple_common/maple_common.dart';
import 'package:number_text_input_formatter/number_text_input_formatter.dart';
import 'package:provider/provider.dart';

// Interface:-------------------------------------------------------------------
abstract class CartPaymentWidgetInterface implements Widget {}

// Theme:-----------------------------------------------------------------------
abstract class CartPaymentWidgetThemeInterface {
  String get bannerImage;
}

// Implementation:--------------------------------------------------------------
class CartPayment extends StatefulWidget implements CartPaymentWidgetInterface {
  const CartPayment({super.key});

  @override
  State<CartPayment> createState() => _CartPaymentState();
}

class _CartPaymentState extends State<CartPayment> {
  // Dependencies:--------------------------------------------------------------
  final NumberFormatterUtilsInterface _numberFormatterUtils =
      getIt<NumberFormatterUtilsInterface>();
  // Stores:--------------------------------------------------------------------
  late final CustomerOrderStoreInterface _customerOrderStore;

  // TextEditingController:-----------------------------------------------------
  final TextEditingController _depositController = TextEditingController();
  final TextEditingController _nominalRateController = TextEditingController();
  final TextEditingController _numberOfMonthlyPaymentsController =
      TextEditingController();
  final TextEditingController _aprController = TextEditingController();
  final TextEditingController _totalCostOfCreditController =
      TextEditingController();
  final TextEditingController _amountOfMonthlyPaymentsController =
      TextEditingController();
  final TextEditingController _intermediatePaymentController =
      TextEditingController();
  final TextEditingController _endOfWorksPaymentController =
      TextEditingController();

  // FocusNode:-----------------------------------------------------------------
  final FocusNode _depositFocusNode = FocusNode();
  final FocusNode _nominalRateFocusNode = FocusNode();
  final FocusNode _numberOfMonthlyPaymentsFocusNode = FocusNode();
  final FocusNode _aprFocusNode = FocusNode();
  final FocusNode _totalCostOfCreditFocusNode = FocusNode();
  final FocusNode _amountOfMonthlyPaymentsFocusNode = FocusNode();

  // Themes:--------------------------------------------------------------------
  final AppThemeDataInterface _appThemeData = getIt<AppThemeDataInterface>();
  final CartPaymentWidgetThemeInterface _theme =
      getIt<CartPaymentWidgetThemeInterface>();

  // Lifecycle methods:---------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _customerOrderStore = context.read<CustomerOrderStoreInterface>();
    _customerOrderStore.paymentStepStore
        .setDepositAmountController(_depositController);
    _customerOrderStore.paymentStepStore
        .setIntermediatePaymentAmountController(_intermediatePaymentController);
    _customerOrderStore.paymentStepStore
        .setEndOfWorksPaymentAmountController(_endOfWorksPaymentController);
    _initTextEditingController();
    _customerOrderStore.paymentStepStore
        .setInitTextEditingControllers(_initTextEditingController);
    _depositFocusNode.addListener(_onDepositFocusChange);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom > 70
            ? MediaQuery.of(context).viewInsets.bottom
            : 0,
      ),
      child: CupertinoScrollbar(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 12),
              _buildContent(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget methods:------------------------------------------------------------
  Widget _buildHeader() {
    return Stack(
      children: [
        Container(
          height: 174,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(_theme.bannerImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 14, left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'cart.total_with_vat'.tr(),
                style: const TextStyle(color: CupertinoColors.white),
              ),
              const SizedBox(height: 6),
              Text(
                _customerOrderStore.order.formattedTotalNetInclTax,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: CupertinoColors.white,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Observer(builder: (_) {
                      return getIt<TextInputWidgetInterface>(
                        param1: TextInputProps(
                          borderRadius: BorderRadius.circular(8),
                          label: 'cart.deposit'.tr(),
                          placeholder: 'cart.deposit_placeholder'.tr(),
                          inputFormatters: [
                            _numberFormatterUtils.filteringDecimalOnly,
                          ],
                          keyboardType: TextInputType.number,
                          controller: _depositController,
                          focusNode: _depositFocusNode,
                          disable: _customerOrderStore.order.isReadonly,
                          hasError: _customerOrderStore
                              .paymentStepStore.depositAmountIsInvalid,
                          onChanged: (value) {
                            _customerOrderStore.paymentStepStore
                                .setDepositAmount(value);
                          },
                        ),
                      );
                    }),
                  ),
                  const SizedBox(width: 17),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Observer(builder: (_) {
                return CupertinoSwitch(
                  value: _customerOrderStore.paymentStepStore.isCashPayment,
                  activeColor: _appThemeData.activeSwitchButtonColor,
                  onChanged: _customerOrderStore.order.isReadonly
                      ? null
                      : _customerOrderStore.paymentStepStore.setIsCashPayment,
                );
              }),
              const SizedBox(width: 10),
              Text(
                'cart.cash'.tr(),
                style: TextStyle(
                  color: _customerOrderStore.order.isReadonly
                      ? CupertinoColors.inactiveGray
                      : _appThemeData.defaultTextColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildCashContent(),
          const SizedBox(height: 24),
          Row(
            children: [
              Observer(builder: (_) {
                return CupertinoSwitch(
                  value:
                      _customerOrderStore.paymentStepStore.isFinancingPayment,
                  activeColor: _appThemeData.activeSwitchButtonColor,
                  onChanged: _customerOrderStore.order.isReadonly
                      ? null
                      : _customerOrderStore
                          .paymentStepStore.setIsFinancingPayment,
                );
              }),
              const SizedBox(width: 10),
              Text(
                'cart.financing'.tr(),
                style: TextStyle(
                  color: _customerOrderStore.order.isReadonly
                      ? CupertinoColors.inactiveGray
                      : _appThemeData.defaultTextColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildFinancingContent(),
        ],
      ),
    );
  }

  Widget _buildCashContent() {
    return Observer(builder: (_) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Observer(builder: (_) {
                  return getIt<SelectDialogWidgetInterface>(
                    param1: SelectDialogProps(
                      label: '${'cart.payment_method'.tr()}*',
                      value: _customerOrderStore
                          .paymentStepStore.cashPaymentMethod,
                      choices: CashPaymentMethod.choices,
                      displayedValue: _customerOrderStore
                                  .paymentStepStore.cashPaymentMethod !=
                              null
                          ? _customerOrderStore
                              .paymentStepStore.cashPaymentMethod!.label
                          : '',
                      disable: _customerOrderStore.order.isReadonly ||
                          !_customerOrderStore.paymentStepStore.isCashPayment,
                      onChanged: (value) => _customerOrderStore.paymentStepStore
                          .setCashPaymentMethod(value),
                    ),
                  );
                }),
              ),
              const SizedBox(width: 17),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 19),
          Row(
            children: [
              Expanded(
                child: getIt<RowButtonWidgetInterface>(
                  param1: RowButtonProps(
                    borderRadius: BorderRadius.circular(8),
                    disable: _customerOrderStore.order.isReadonly ||
                        !_customerOrderStore.paymentStepStore.isCashPayment,
                    child: Text(
                      'cart.intermediate_payment'.tr(),
                      style: TextStyle(
                        color: _customerOrderStore.order.isReadonly ||
                                !_customerOrderStore
                                    .paymentStepStore.isCashPayment
                            ? CupertinoColors.inactiveGray
                            : _appThemeData.defaultTextColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 17),
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      width: 188,
                      child: getIt<TextInputWidgetInterface>(
                        param1: TextInputProps(
                          controller: _intermediatePaymentController,
                          borderRadius: BorderRadius.circular(8),
                          textAlign: TextAlign.center,
                          disable: _customerOrderStore.order.isReadonly ||
                              !_customerOrderStore
                                  .paymentStepStore.isCashPayment,
                          suffix: Text(
                            '€',
                            style: TextStyle(
                              color: _customerOrderStore.order.isReadonly ||
                                      !_customerOrderStore
                                          .paymentStepStore.isCashPayment
                                  ? CupertinoColors.inactiveGray
                                  : _appThemeData.defaultTextColor,
                            ),
                          ),
                          inputFormatters: [
                            NumberTextInputFormatter(
                              decimalDigits: 2,
                              decimalSeparator: ',',
                              groupSeparator: ' ',
                              allowNegative: false,
                            ),
                          ],
                          onChanged: _customerOrderStore
                              .paymentStepStore.setIntermediatePaymentAmount,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 19),
          Row(
            children: [
              Expanded(
                child: getIt<RowButtonWidgetInterface>(
                  param1: RowButtonProps(
                    borderRadius: BorderRadius.circular(8),
                    child: Text(
                      'cart.end_of_works_payment'.tr(),
                      style: TextStyle(
                        color: _customerOrderStore.order.isReadonly ||
                                !_customerOrderStore
                                    .paymentStepStore.isCashPayment
                            ? CupertinoColors.inactiveGray
                            : _appThemeData.defaultTextColor,
                      ),
                    ),
                    disable: _customerOrderStore.order.isReadonly ||
                        !_customerOrderStore.paymentStepStore.isCashPayment,
                  ),
                ),
              ),
              const SizedBox(width: 17),
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      width: 188,
                      child: getIt<TextInputWidgetInterface>(
                        param1: TextInputProps(
                          controller: _endOfWorksPaymentController,
                          borderRadius: BorderRadius.circular(8),
                          textAlign: TextAlign.center,
                          disable: _customerOrderStore.order.isReadonly ||
                              !_customerOrderStore
                                  .paymentStepStore.isCashPayment,
                          suffix: Text(
                            '€',
                            style: TextStyle(
                              color: _customerOrderStore.order.isReadonly ||
                                      !_customerOrderStore
                                          .order.isCleaningRelated ||
                                      !_customerOrderStore
                                          .paymentStepStore.isCashPayment
                                  ? CupertinoColors.inactiveGray
                                  : _appThemeData.defaultTextColor,
                            ),
                          ),
                          inputFormatters: [
                            NumberTextInputFormatter(
                              decimalDigits: 2,
                              decimalSeparator: ',',
                              groupSeparator: ' ',
                              allowNegative: false,
                            ),
                          ],
                          onChanged: _customerOrderStore
                              .paymentStepStore.setEndOfWorksPaymentAmount,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      );
    });
  }

  Widget _buildFinancingContent() {
    return Observer(builder: (_) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Observer(builder: (_) {
                  return getIt<SelectDialogWidgetInterface>(
                    param1: SelectDialogProps(
                      label: '${'cart.lending_institution'.tr()}*',
                      value: _customerOrderStore
                          .paymentStepStore.financingPaymentMethod,
                      choices: FinancingPaymentMethod.choices,
                      displayedValue: _customerOrderStore
                                  .paymentStepStore.financingPaymentMethod !=
                              null
                          ? _customerOrderStore
                              .paymentStepStore.financingPaymentMethod!.label
                          : '',
                      disable: _customerOrderStore.order.isReadonly ||
                          !_customerOrderStore
                              .paymentStepStore.isFinancingPayment,
                      onChanged: (value) => _customerOrderStore.paymentStepStore
                          .setFinancingPaymentMethod(value),
                    ),
                  );
                }),
              ),
              const SizedBox(width: 17),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 19),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: _customerOrderStore.order.isReadonly ||
                            !_customerOrderStore
                                .paymentStepStore.isFinancingPayment
                        ? MapleCommonColors.disabledBackground
                        : CupertinoColors.white,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 230,
                        child: Text(
                          'cart.credit_amount'.tr(),
                          style: TextStyle(
                            color: _customerOrderStore.order.isReadonly ||
                                    !_customerOrderStore
                                        .paymentStepStore.isFinancingPayment
                                ? CupertinoColors.inactiveGray
                                : _appThemeData.defaultTextColor,
                          ),
                        ),
                      ),
                      Observer(builder: (_) {
                        return Text(
                          'cart.amount_with_vat'.tr(
                            namedArgs: {
                              'amount': _numberFormatterUtils.formatToCurrency(
                                  _customerOrderStore
                                      .paymentStepStore.creditAmount),
                            },
                          ),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: _customerOrderStore.order.isReadonly ||
                                    !_customerOrderStore
                                        .paymentStepStore.isFinancingPayment
                                ? CupertinoColors.inactiveGray
                                : _appThemeData.cartPaymentTotalColor,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 17),
              Expanded(
                child: getIt<TextInputWidgetInterface>(
                  param1: TextInputProps(
                    label: 'cart.nominal_rate'.tr(),
                    labelWidth: 220,
                    borderRadius: BorderRadius.circular(8),
                    placeholder: 'cart.percentage_placeholder'.tr(),
                    inputFormatters: [
                      NumberTextInputFormatter(
                        decimalDigits: 3,
                        decimalSeparator: ',',
                        groupSeparator: ' ',
                      ),
                    ],
                    keyboardType: TextInputType.number,
                    controller: _nominalRateController,
                    focusNode: _nominalRateFocusNode,
                    hasError: _customerOrderStore
                        .paymentStepStore.nominalRateIsInvalid,
                    disable: _customerOrderStore.order.isReadonly ||
                        !_customerOrderStore
                            .paymentStepStore.isFinancingPayment,
                    onChanged:
                        _customerOrderStore.paymentStepStore.setNominalRate,
                    onSubmitted: (_) => FocusScope.of(context)
                        .requestFocus(_numberOfMonthlyPaymentsFocusNode),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 19),
          Row(
            children: [
              Expanded(
                child: getIt<TextInputWidgetInterface>(
                  param1: TextInputProps(
                    label: 'cart.number_of_monthly_payments'.tr(),
                    labelWidth: 220,
                    borderRadius: BorderRadius.circular(8),
                    placeholder:
                        'cart.number_of_monthly_payments_placeholder'.tr(),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    controller: _numberOfMonthlyPaymentsController,
                    focusNode: _numberOfMonthlyPaymentsFocusNode,
                    disable: _customerOrderStore.order.isReadonly ||
                        !_customerOrderStore
                            .paymentStepStore.isFinancingPayment,
                    hasError: _customerOrderStore
                        .paymentStepStore.monthlyPaymentsCountIsInvalid,
                    onChanged: _customerOrderStore
                        .paymentStepStore.setNumberOfMonthlyPayments,
                    onSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_aprFocusNode),
                  ),
                ),
              ),
              const SizedBox(width: 17),
              Expanded(
                child: getIt<TextInputWidgetInterface>(
                  param1: TextInputProps(
                    label: 'cart.apr'.tr(),
                    labelWidth: 220,
                    borderRadius: BorderRadius.circular(8),
                    placeholder: 'cart.percentage_placeholder'.tr(),
                    inputFormatters: [
                      NumberTextInputFormatter(
                        decimalDigits: 3,
                        decimalSeparator: ',',
                        groupSeparator: ' ',
                      ),
                    ],
                    keyboardType: TextInputType.number,
                    controller: _aprController,
                    focusNode: _aprFocusNode,
                    hasError: _customerOrderStore.paymentStepStore.aprIsInvalid,
                    disable: _customerOrderStore.order.isReadonly ||
                        !_customerOrderStore
                            .paymentStepStore.isFinancingPayment,
                    onChanged: _customerOrderStore.paymentStepStore.setApr,
                    onSubmitted: (_) => FocusScope.of(context)
                        .requestFocus(_totalCostOfCreditFocusNode),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 19),
          Row(
            children: [
              Expanded(
                child: getIt<TextInputWidgetInterface>(
                  param1: TextInputProps(
                    label: 'cart.total_cost_of_credit'.tr(),
                    labelWidth: 220,
                    borderRadius: BorderRadius.circular(8),
                    placeholder: 'cart.payment_placeholder'.tr(),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^[1-9]\d*(\.|,)?\d*'),
                      )
                    ],
                    keyboardType: TextInputType.number,
                    controller: _totalCostOfCreditController,
                    focusNode: _totalCostOfCreditFocusNode,
                    disable: _customerOrderStore.order.isReadonly ||
                        !_customerOrderStore
                            .paymentStepStore.isFinancingPayment,
                    hasError: _customerOrderStore
                        .paymentStepStore.creditTotalCostIsInvalid,
                    onChanged:
                        _customerOrderStore.paymentStepStore.setCreditTotalCost,
                    onSubmitted: (_) => FocusScope.of(context)
                        .requestFocus(_amountOfMonthlyPaymentsFocusNode),
                  ),
                ),
              ),
              const SizedBox(width: 17),
              Expanded(
                child: getIt<SelectDialogWidgetInterface<InsuranceType>>(
                  param1: SelectDialogProps<InsuranceType>(
                    label: 'cart.type_of_insurance'.tr(),
                    value: _customerOrderStore.paymentStepStore.insuranceType,
                    displayedValue:
                        _customerOrderStore.paymentStepStore.insuranceType !=
                                    null &&
                                _customerOrderStore
                                    .paymentStepStore.isFinancingPayment
                            ? _customerOrderStore
                                .paymentStepStore.insuranceType!.label
                            : '',
                    choices: InsuranceType.choices,
                    disable: _customerOrderStore.order.isReadonly ||
                        !_customerOrderStore
                            .paymentStepStore.isFinancingPayment,
                    onChanged:
                        _customerOrderStore.paymentStepStore.setInsuranceType,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 19),
          Row(
            children: [
              Expanded(
                child: getIt<TextInputWidgetInterface>(
                  param1: TextInputProps(
                    label: 'cart.amount_of_monthly_payments'.tr(),
                    labelWidth: 220,
                    borderRadius: BorderRadius.circular(8),
                    placeholder: 'cart.payment_placeholder'.tr(),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^[1-9]\d*(\.|,)?\d*'),
                      )
                    ],
                    keyboardType: TextInputType.number,
                    controller: _amountOfMonthlyPaymentsController,
                    focusNode: _amountOfMonthlyPaymentsFocusNode,
                    disable: _customerOrderStore.order.isReadonly ||
                        !_customerOrderStore
                            .paymentStepStore.isFinancingPayment,
                    hasError: _customerOrderStore
                        .paymentStepStore.monthlyPaymentAmountIsInvalid,
                    onChanged: _customerOrderStore
                        .paymentStepStore.setMonthlyPaymentsAmount,
                  ),
                ),
              ),
              const SizedBox(width: 17),
              Expanded(
                child: getIt<SelectDialogWidgetInterface<Deferment>>(
                  param1: SelectDialogProps<Deferment>(
                    label: 'cart.deferment'.tr(),
                    value: _customerOrderStore.paymentStepStore.deferment,
                    displayedValue: _customerOrderStore
                                    .paymentStepStore.deferment !=
                                null &&
                            _customerOrderStore
                                .paymentStepStore.isFinancingPayment
                        ? _customerOrderStore.paymentStepStore.deferment!.label
                        : '',
                    choices: Deferment.choices,
                    disable: _customerOrderStore.order.isReadonly ||
                        !_customerOrderStore
                            .paymentStepStore.isFinancingPayment,
                    onChanged:
                        _customerOrderStore.paymentStepStore.setDeferment,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 19),
        ],
      );
    });
  }

  // General methods:-----------------------------------------------------------
  void _initTextEditingController() {
    if (_customerOrderStore.paymentStepStore.intermediatePaymentAmount !=
            null &&
        _customerOrderStore.paymentStepStore.isCashPayment) {
      _intermediatePaymentController.text =
          _numberFormatterUtils.formatToDoubleWith2Decimals(
              _customerOrderStore.paymentStepStore.intermediatePaymentAmount!);
    } else {
      _intermediatePaymentController.text = '';
    }

    if (_customerOrderStore.paymentStepStore.endOfWorksPaymentAmount != null &&
        _customerOrderStore.paymentStepStore.isCashPayment) {
      _endOfWorksPaymentController.text =
          _numberFormatterUtils.formatToDoubleWith2Decimals(
              _customerOrderStore.paymentStepStore.endOfWorksPaymentAmount!);
    } else {
      _endOfWorksPaymentController.text = '';
    }

    if (_customerOrderStore.paymentStepStore.depositAmount != null) {
      _depositController.text =
          _numberFormatterUtils.formatToDoubleWith2Decimals(
              _customerOrderStore.paymentStepStore.depositAmount!);
    } else {
      _depositController.text = '';
    }

    if (_customerOrderStore.paymentStepStore.nominalRate != null &&
        _customerOrderStore.paymentStepStore.isFinancingPayment) {
      _nominalRateController.text =
          _numberFormatterUtils.formatToDoubleWithNDecimals(
              _customerOrderStore.paymentStepStore.nominalRate!, 3);
    } else {
      _nominalRateController.text = '';
    }

    if (_customerOrderStore.paymentStepStore.monthlyPaymentsCount != null &&
        _customerOrderStore.paymentStepStore.isFinancingPayment) {
      _numberOfMonthlyPaymentsController.text =
          _customerOrderStore.paymentStepStore.monthlyPaymentsCount!.toString();
    } else {
      _numberOfMonthlyPaymentsController.text = '';
    }

    if (_customerOrderStore.paymentStepStore.apr != null &&
        _customerOrderStore.paymentStepStore.isFinancingPayment) {
      _aprController.text = _numberFormatterUtils.formatToDoubleWithNDecimals(
          _customerOrderStore.paymentStepStore.apr!, 3);
    } else {
      _aprController.text = '';
    }

    if (_customerOrderStore.paymentStepStore.creditTotalCost != null &&
        _customerOrderStore.paymentStepStore.isFinancingPayment) {
      _totalCostOfCreditController.text =
          _numberFormatterUtils.formatToDoubleWith2Decimals(
              _customerOrderStore.paymentStepStore.creditTotalCost!);
    } else {
      _totalCostOfCreditController.text = '';
    }

    if (_customerOrderStore.paymentStepStore.monthlyPaymentAmount != null &&
        _customerOrderStore.paymentStepStore.isFinancingPayment) {
      _amountOfMonthlyPaymentsController.text =
          _numberFormatterUtils.formatToDoubleWith2Decimals(
              _customerOrderStore.paymentStepStore.monthlyPaymentAmount!);
    } else {
      _amountOfMonthlyPaymentsController.text = '';
    }
  }

  void _onDepositFocusChange() {
    if (_depositFocusNode.hasFocus ||
        _customerOrderStore.paymentStepStore.depositAmount == null ||
        _customerOrderStore.paymentStepStore.depositAmount! <= 0) {
      return;
    }

    _depositController.text = _numberFormatterUtils.formatToDoubleWith2Decimals(
        _customerOrderStore.paymentStepStore.depositAmount!);
  }

  // Dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    _customerOrderStore.paymentStepStore.setDepositAmountController(null);
    _depositController.dispose();
    _nominalRateController.dispose();
    _numberOfMonthlyPaymentsController.dispose();
    _aprController.dispose();
    _totalCostOfCreditController.dispose();
    _amountOfMonthlyPaymentsController.dispose();
    _nominalRateFocusNode.dispose();
    _numberOfMonthlyPaymentsFocusNode.dispose();
    _aprFocusNode.dispose();
    _totalCostOfCreditFocusNode.dispose();
    _amountOfMonthlyPaymentsFocusNode.dispose();
    super.dispose();
  }
}
