import 'dart:async';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'select_agency_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class SelectAgencyStoreInterface {
  SelectAgencyStoreInterface._(this.agencyId);

  // Variables
  String agencyId;
  Agency? currentAgency;
  Representative? currentRepresentative;

  // Methods
  void setAgencyId(String value);
  Future<void> loadRepresentativeStore();
  void dispose();
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class SelectAgencyStore = _SelectAgencyStore with _$SelectAgencyStore;

abstract class _SelectAgencyStore
    with Store
    implements SelectAgencyStoreInterface {
  // Constructor:---------------------------------------------------------------
  _SelectAgencyStore() {
    _initStreams();
  }

  // Services:------------------------------------------------------------------
  final RepresentativeServiceInterface _representativeService =
      getIt<RepresentativeServiceInterface>();
  final AgencyServiceInterface _agencyService = getIt<AgencyServiceInterface>();
  final AgencyDatabase _agencyDatabase = getIt<AgencyDatabase>();

  // Other variables:-----------------------------------------------------------
  StreamSubscription<Map<String, AbstractBaseModel?>>?
      _currentAgencyAndRepresentativeSubscription;

  @override
  @observable
  String agencyId = '';

  @override
  @observable
  Agency? currentAgency;

  @override
  @observable
  Representative? currentRepresentative;

  // Actions:-------------------------------------------------------------------
  @override
  @action
  void setAgencyId(String value) {
    agencyId = value;
  }

  // Methods:-------------------------------------------------------------------
  @override
  @action
  Future<void> loadRepresentativeStore() async {
    await _agencyDatabase.load(
      email: currentRepresentative?.email ?? '',
      agencyId: agencyId,
    );
    agencyId = '';
  }

  // Other methods:-------------------------------------------------------------
  StreamController<Map<String, AbstractBaseModel?>>
      _getCurrentAgencyAndRepresentativeAsStream() {
    return getIt<StreamUtilsInterface>()
        .combine<AbstractBaseModel?, Map<String, AbstractBaseModel?>>([
      _representativeService.getCurrentAsStream(),
      _agencyService.getCurrentAsStream()
    ], (List<AbstractBaseModel?> data) {
      return {
        'representative': data[0] as Representative?,
        'agency': data[1] as Agency?,
      };
    });
  }

  void _initStreams() {
    _currentAgencyAndRepresentativeSubscription?.cancel();
    _currentAgencyAndRepresentativeSubscription =
        _getCurrentAgencyAndRepresentativeAsStream().stream.listen((event) {
      currentRepresentative = event['representative'] as Representative?;
      currentAgency = event['agency'] as Agency?;
    });
  }

  // Dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    _currentAgencyAndRepresentativeSubscription?.cancel();
  }
}
