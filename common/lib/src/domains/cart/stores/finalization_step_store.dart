import 'dart:async';
import 'package:intl/intl.dart';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'finalization_step_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class FinalizationStepStoreInterface {
  FinalizationStepStoreInterface._(
    this.selectedContactValues,
    this.selectedReps,
    this.selectedRepValues,
    this.keepOldStuff,
  );
  // Variables:-----------------------------------------------------------------
  ObservableList<String> selectedContactValues;

  ObservableList<Representative> selectedReps;

  ObservableList<String> selectedRepValues;

  DateTime? installAt;

  DateTime? endProjectAt;

  bool keepOldStuff;

  // Computed:------------------------------------------------------------------
  bool get isSubmittable;

  Future<List<Contact>> get selectedContacts;

  String get formattedInstallAt;

  String get formattedEndProjectAt;

  bool get isInstallAtUpToDate;

  bool get isEndProjectAtUpToDate;

  bool get canGenerateQuote;

  // Methods:-------------------------------------------------------------------
  Future<void> setSelectedContactValues(List<String> values);

  Future<void> setSelectedRepValues(List<String> values);

  void setInstallationAt(DateTime value);

  void setEndProjectAt(DateTime value);

  void setKeepOldStuff(bool value);

  void dispose();
}

// Params:----------------------------------------------------------------------
class FinalizationStepStoreParams {
  FinalizationStepStoreParams({
    required this.customerOrderStore,
  });

  final CustomerOrderStoreInterface customerOrderStore;
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class FinalizationStepStore = _FinalizationStepStoreBase
    with _$FinalizationStepStore;

abstract class _FinalizationStepStoreBase
    with Store
    implements FinalizationStepStoreInterface {
  _FinalizationStepStoreBase({required FinalizationStepStoreParams params})
      : customerOrderStore = params.customerOrderStore {
    init();
  }

  final CustomerOrderStoreInterface customerOrderStore;

  // Reactions:-----------------------------------------------------------------
  ReactionDisposer? _orderReactionDisposer;
  StreamSubscription? _currentRepresentativeSubscription;

  // Services:------------------------------------------------------------------
  final RepresentativeServiceInterface _representativeService =
      getIt<RepresentativeServiceInterface>();
  final ContactServiceInterface _contactService =
      getIt<ContactServiceInterface>();

  @observable
  Representative? _currentRepresentative;

  // Store variables:-----------------------------------------------------------
  @override
  @observable
  DateTime? installAt;

  @override
  @observable
  DateTime? endProjectAt;

  @override
  @observable
  ObservableList<String> selectedContactValues = ObservableList();

  @override
  @observable
  ObservableList<String> selectedRepValues = ObservableList();

  @override
  @observable
  bool keepOldStuff = false;

  @override
  @observable
  ObservableList<Representative> selectedReps = ObservableList();

  // Computed:------------------------------------------------------------------
  @override
  @computed
  String get formattedInstallAt =>
      installAt != null ? DateFormat('dd/MM/yyyy').format(installAt!) : '';

  @override
  @computed
  String get formattedEndProjectAt => endProjectAt != null
      ? DateFormat('dd/MM/yyyy').format(endProjectAt!)
      : '';

  @override
  @computed
  Future<List<Contact>> get selectedContacts async {
    return await _contactService.getByIds(selectedContactValues);
  }

  @override
  @computed
  bool get isSubmittable {
    return selectedContactValues.isNotEmpty &&
        selectedRepValues.isNotEmpty &&
        installAt != null &&
        isInstallAtUpToDate &&
        endProjectAt != null &&
        isEndProjectAtUpToDate;
  }

  @override
  @computed
  bool get isInstallAtUpToDate {
    if (installAt == null) {
      return true;
    }
    DateTime now = DateTime.now();
    DateTime nowAfter15days =
        DateTime(now.year, now.month, now.day).add(const Duration(days: 16));
    return !DateTime.utc(installAt!.year, installAt!.month, installAt!.day)
        .isBefore(nowAfter15days);
  }

  @override
  @computed
  bool get canGenerateQuote {
    return installAt != null && selectedContactValues.isNotEmpty;
  }

  @override
  @computed
  bool get isEndProjectAtUpToDate {
    if (endProjectAt == null) {
      return true;
    }
    DateTime now = DateTime.now();
    DateTime nowAfter1year = DateTime(now.year + 1, now.month, now.day);
    return !endProjectAt!.isBefore(nowAfter1year);
  }

  // Actions:-------------------------------------------------------------------
  Future<void> init() async {
    await initStreams();

    await loadData();
    // watch order
    _orderReactionDisposer?.reaction.dispose();
    _orderReactionDisposer = reaction(
      (_) => customerOrderStore.order,
      (Order? order) async {
        await loadData();
      },
    );
  }

  @action
  Future<void> loadData() async {
    // set selected contacts
    selectedContactValues = ObservableList.of(
        (await _contactService.getByOrderId(customerOrderStore.order.id))
            .map((e) => e.id)
            .toList());

    final alreadySelectedReps = customerOrderStore.order.representatives;
    for (var element in alreadySelectedReps) {
      if (!selectedRepValues.contains(element.id)) {
        selectedRepValues.add(element.id);
      }
    }
    selectedReps = ObservableList.of((await _representativeService.getAll())
        .where((element) => selectedRepValues.contains(element.id))
        .toList());

    installAt = customerOrderStore.order.installAt;
    endProjectAt = customerOrderStore.order.endProjectAt;
    keepOldStuff = customerOrderStore.order.keepOldStuff;

    // reaction to selected rep values
    reaction((_) => selectedRepValues, (_) async {
      selectedReps = ObservableList.of((await _representativeService.getAll())
          .where((element) => selectedRepValues.contains(element.id))
          .toList());
    });
  }

  @action
  void updateCartData() {
    customerOrderStore.order.installAt = installAt;
    customerOrderStore.order.endProjectAt = endProjectAt;
  }

  @override
  @action
  void setKeepOldStuff(bool value) {
    keepOldStuff = value;
    // update cart
    if (customerOrderStore.order.keepOldStuff != keepOldStuff) {
      customerOrderStore.order.keepOldStuff = keepOldStuff;
      customerOrderStore.order.setShouldRecreateEnvelope(true);
      customerOrderStore.updateOrder();
    }
  }

  @override
  @action
  Future<void> setSelectedContactValues(List<String> values) async {
    selectedContactValues = ObservableList.of(values);
    // update cart
    customerOrderStore.order.contacts = values;
    customerOrderStore.order.setShouldRecreateEnvelope(true);
    await customerOrderStore.updateOrder();
  }

  @override
  @action
  Future<void> setSelectedRepValues(List<String> values) async {
    // get unique values
    values = values.toSet().toList();
    // update cart
    customerOrderStore.order.representative1Id =
        values.isNotEmpty && values[0].isNotEmpty ? values[0] : null;
    customerOrderStore.order.representative2Id =
        values.length >= 2 && values[1].isNotEmpty ? values[1] : null;
    customerOrderStore.order.representative3Id =
        values.length >= 3 && values[2].isNotEmpty ? values[2] : null;
    selectedRepValues = ObservableList.of(values);
    selectedReps = ObservableList.of((await _representativeService.getAll())
        .where((element) => selectedRepValues.contains(element.id))
        .toList());
    customerOrderStore.order.setShouldRecreateEnvelope(true);
    customerOrderStore.updateOrder();
  }

  @override
  @action
  void setInstallationAt(DateTime value) {
    installAt = value;
    if (customerOrderStore.order.installAt != installAt) {
      customerOrderStore.order.installAt = installAt;
      customerOrderStore.order.setShouldRecreateEnvelope(true);
      customerOrderStore.updateOrder();
    }
  }

  @override
  @action
  void setEndProjectAt(DateTime value) {
    endProjectAt = value;
    if (customerOrderStore.order.endProjectAt != endProjectAt) {
      customerOrderStore.order.endProjectAt = endProjectAt;
      customerOrderStore.order.setShouldRecreateEnvelope(true);
      customerOrderStore.updateOrder();
    }
  }

  // Other methods:-------------------------------------------------------------
  Future<void> initStreams() async {
    _currentRepresentative = await _representativeService.getCurrent();
    // listen to representative store
    _currentRepresentativeSubscription =
        _representativeService.getCurrentAsStream().listen((event) {
      _currentRepresentative = event;
    });
    return Future.value();
  }

  // Dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    _currentRepresentativeSubscription?.cancel();
    _orderReactionDisposer?.reaction.dispose();
  }
}
