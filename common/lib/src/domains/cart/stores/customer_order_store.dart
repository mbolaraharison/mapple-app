import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'customer_order_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class CustomerOrderStoreInterface {
  CustomerOrderStoreInterface._(
    this.order,
    this.step,
    this.activeStep,
    this.percentage,
  );

  // Children stores:-----------------------------------------------------------
  late OrderStepStoreInterface orderStepStore;
  late PaymentStepStoreInterface paymentStepStore;
  late FinalizationStepStoreInterface finalizationStepStore;
  late SignatureStepStoreInterface signatureStepStore;

  // Variables:-----------------------------------------------------------------
  Order order;
  int step;
  int activeStep;
  double percentage;

  // Computed:------------------------------------------------------------------
  bool get canGoNext;

  // Methods:-------------------------------------------------------------------
  void initStep();
  void setStep(int value);
  void setActiveStep({required int value, required BuildContext context});
  Future<void> setNextStep(BuildContext context);
  Future<void> updateOrder();
  Future<void> resetCartStatus();
  Future<void> setOrderFormFileDataId(String value, {bool withUpdate = true});
  Future<void> setTermsDocumentFileDataId(String value);
  Future<void> setVatCertificateFileDataId(String value);
  Future<void> setFairId(String value);
  void dispose();
}

// Params:----------------------------------------------------------------------
class CustomerOrderStoreParams {
  CustomerOrderStoreParams({required this.order});

  final Order order;
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class CustomerOrderStore = _CustomerOrderStoreBase with _$CustomerOrderStore;

abstract class _CustomerOrderStoreBase
    with Store
    implements CustomerOrderStoreInterface {
  _CustomerOrderStoreBase({required CustomerOrderStoreParams params})
      : order = params.order {
    init();
    orderStepStore = getIt<OrderStepStoreInterface>(
      param1: OrderStepStoreParams(
        customerOrderStore: this as CustomerOrderStore,
      ),
    );
    paymentStepStore = getIt<PaymentStepStoreInterface>(
      param1: PaymentStepStoreParams(
          customerOrderStore: this as CustomerOrderStore),
    );
    finalizationStepStore = getIt<FinalizationStepStoreInterface>(
      param1: FinalizationStepStoreParams(
        customerOrderStore: this as CustomerOrderStore,
      ),
    );
    signatureStepStore = getIt<SignatureStepStoreInterface>(
      param1: SignatureStepStoreParams(
        customerOrderStore: this as CustomerOrderStore,
      ),
    );
  }

  // Child stores:--------------------------------------------------------------
  @override
  late OrderStepStoreInterface orderStepStore;
  @override
  late PaymentStepStoreInterface paymentStepStore;
  @override
  late FinalizationStepStoreInterface finalizationStepStore;
  @override
  late SignatureStepStoreInterface signatureStepStore;

  // Services:------------------------------------------------------------------
  late final OrderServiceInterface _orderService =
      getIt<OrderServiceInterface>();
  final UuidUtilsInterface uuidUtils = getIt<UuidUtilsInterface>();
  late final FileDataServiceInterface _fileDataService =
      getIt<FileDataServiceInterface>();
  late final DialogUtilsInterface _dialogUtils = getIt<DialogUtilsInterface>();

  // Variables:-----------------------------------------------------------------
  @override
  @observable
  Order order;

  @observable
  bool isLoading = false;

  @override
  @observable
  int step = 1;

  @override
  @observable
  int activeStep = 1;

  @override
  @observable
  double percentage = 0;

  // Other variables:-----------------------------------------------------------
  StreamSubscription<Order?>? _currentOrderSubscription;

  // Computed:------------------------------------------------------------------
  @override
  @computed
  bool get canGoNext {
    if (step == 1 && orderStepStore.isSubmittable) {
      return true;
    }

    if (step == 2 && paymentStepStore.isSubmittable) {
      return true;
    }

    if (step == 3 && finalizationStepStore.isSubmittable) {
      return true;
    }

    return false;
  }

  // Actions:-------------------------------------------------------------------
  @override
  @action
  void initStep() {
    int statusStep = !order.isReadonly ? order.cartStatus.step : 4;
    step = statusStep;
    percentage = step / 4;
    activeStep = 1;
  }

  @override
  @action
  void setStep(int value) {
    step = value;
    percentage = value / 4;
    activeStep = value;
  }

  @override
  @action
  Future<void> setNextStep(BuildContext context) async {
    int value = step + 1;
    if (value > 4) {
      return;
    }

    // Validate steps
    if (step == 2) {
      try {
        final hasSave = await paymentStepStore.save(context);
        if (!hasSave) {
          return;
        }
      } on ValidationException catch (e) {
        if (!context.mounted) {
          return;
        }
        _dialogUtils.showErrorDialog(
          context: context,
          errorMessage: e.message,
        );
        return;
      }
    }

    step = value;
    activeStep = value;
    percentage = value / 4;

    // update cart status
    CartStatus status = CartStatus.fromStep(step);
    setCartStatus(status);
  }

  @action
  Future<void> initOrderRows() async {
    orderStepStore.orderRows = ObservableList.of(order.orderRows);
  }

  @override
  @action
  void setActiveStep({required int value, required BuildContext context}) {
    // Current active step is payment => check if has changes
    // If changes => ask for save
    if (activeStep == 2 && activeStep != value && paymentStepStore.hasChanges) {
      showChangeTabWithoutSavingDialog(context: context, nextStep: value);
      return;
    }

    activeStep = value;
  }

  @action
  Future<void> setCartStatus(CartStatus status) async {
    order.cartStatus = status;
    updateOrder();
  }

  @override
  @action
  Future<void> setOrderFormFileDataId(String value,
      {bool withUpdate = true}) async {
    order.orderFormFileDataId = value;
    if (withUpdate) {
      updateOrder();
    }
  }

  @override
  @action
  Future<void> setTermsDocumentFileDataId(String value) async {
    order.termsDocumentFileDataId = value;
    updateOrder();
  }

  @override
  @action
  Future<void> setVatCertificateFileDataId(String value) async {
    order.vatCertificateFileDataId = value;
    updateOrder();
  }

  @override
  @action
  Future<void> setFairId(String value) async {
    order.fairId = value;
    await updateOrder();
  }

  @override
  @action
  Future<void> updateOrder() async {
    // update order
    await _orderService.update(order);
  }

  @override
  @action
  Future<void> resetCartStatus() async {
    order.cartStatus = CartStatus.order;
    order.signatureStep = 1;
    order.isCashPayment = false;
    order.cashPaymentMethod = null;
    order.isFinancingPayment = false;
    order.financingPaymentMethod = null;
    order.paymentTerms = PaymentTerms.CB;
    order.depositAmount = 0;
    order.creditAmount = 0;
    order.monthlyPaymentAmount = 0;
    order.monthlyPaymentsCount = 0;
    order.creditTotalCost = 0;
    order.nominalRate = 0;
    order.apr = 0;
    order.insuranceType = InsuranceType.none;
    order.deferment = Deferment.thirtyDays;
    String? lastTermsDocumentFileDataId = order.termsDocumentFileDataId;
    if (lastTermsDocumentFileDataId != null) {
      order.termsDocumentFileDataId = null;
    }
    initStep();
    await updateOrder();
    if (lastTermsDocumentFileDataId != null &&
        order.termsDocumentFileDataId == null) {
      await _fileDataService.deleteById(lastTermsDocumentFileDataId);
    }
    paymentStepStore.init();
  }

  void showChangeTabWithoutSavingDialog({
    required BuildContext context,
    required int nextStep,
  }) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('warning').tr(),
          content: const Text('cart.change_tab_without_save').tr(),
          actions: [
            CupertinoDialogAction(
              child: const Text('yes').tr(),
              onPressed: () async {
                Navigator.pop(context);
                try {
                  final hasSave = await paymentStepStore.save(context);
                  if (hasSave) {
                    activeStep = nextStep;
                  }
                } on ValidationException catch (e) {
                  if (!context.mounted) {
                    return;
                  }
                  _dialogUtils.showErrorDialog(
                    context: context,
                    errorMessage: e.message,
                  );
                }
              },
            ),
            CupertinoDialogAction(
              child: const Text('no').tr(),
              onPressed: () {
                Navigator.pop(context);
                paymentStepStore.paymentFormErrorStore.resetErrors();
                paymentStepStore.loadData();
                paymentStepStore.initTextEditingControllers?.call();
                activeStep = nextStep;
              },
            ),
          ],
        );
      },
    );
  }

  // Methods:-------------------------------------------------------------------
  @action
  Future<void> init() async {
    watchOrder();
  }

  @action
  void watchOrder() {
    // watch order
    _currentOrderSubscription?.cancel();
    _currentOrderSubscription = _orderService
        .getByIdAsStream(order.id, eager: true)
        .listen((Order? value) {
      if (value != null) {
        order = value;
      }
    });
  }

  // Dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    orderStepStore.dispose();
    paymentStepStore.dispose();
    finalizationStepStore.dispose();
    signatureStepStore.dispose();
    _currentOrderSubscription?.cancel();
  }
}
