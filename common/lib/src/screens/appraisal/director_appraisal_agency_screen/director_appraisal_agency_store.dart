import 'dart:async';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'director_appraisal_agency_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class DirectorAppraisalAgencyStoreInterface {
  DirectorAppraisalAgencyStoreInterface._(
    this.agency,
    this.selectTabIndex,
    this.isMultiSelection,
    this.selectedAppraisals,
  );

  // Variables
  DirectorAppraisalAgencyStoreParams get params;
  Agency agency;
  int selectTabIndex;
  int? selectedYear;
  bool isMultiSelection;
  ObservableList<RepresentativeAppraisal> selectedAppraisals;
  ObservableList<RepresentativeAppraisal> appraisalsForRepresentatives =
      ObservableList<RepresentativeAppraisal>();
  ObservableList<RepresentativeAppraisal> appraisalsForDirector =
      ObservableList<RepresentativeAppraisal>();
  ObservableMap<int, List<RepresentativeAppraisal>> appraisalsHistoryByYear =
      ObservableMap<int, List<RepresentativeAppraisal>>();
  ObservableList<Representative> representatives =
      ObservableList<Representative>();
  ObservableList<Representative> representativesWithoutAppraisal =
      ObservableList<Representative>();

  // Methods
  Future<void> setSelectedTabIndex(int selectTabIndex);
  void setSelectedYear(int? selectedYear);
  Future<void> init();
  void toggleMultiSelection();
  void selectAppraisal(RepresentativeAppraisal appraisal);
  void dispose();
}

// Params:----------------------------------------------------------------------
class DirectorAppraisalAgencyStoreParams {
  const DirectorAppraisalAgencyStoreParams({
    required this.agency,
  });

  final Agency agency;
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class DirectorAppraisalAgencyStore = _DirectorAppraisalAgencyStoreBase
    with _$DirectorAppraisalAgencyStore;

abstract class _DirectorAppraisalAgencyStoreBase
    with Store
    implements DirectorAppraisalAgencyStoreInterface {
  _DirectorAppraisalAgencyStoreBase({required this.params})
      : agency = params.agency {
    init();
  }
  // Services:------------------------------------------------------------------
  late final RepresentativeServiceInterface _representativeService =
      getIt<RepresentativeServiceInterface>();
  late final RepresentativeAppraisalServiceInterface
      _representativeAppraisalService =
      getIt<RepresentativeAppraisalServiceInterface>();

  // Variables:-----------------------------------------------------------------
  @override
  final DirectorAppraisalAgencyStoreParams params;

  @override
  @observable
  Agency agency;

  @override
  @observable
  int selectTabIndex = 1;

  @override
  @observable
  int? selectedYear;

  @override
  @observable
  bool isMultiSelection = false;

  @override
  @observable
  ObservableList<RepresentativeAppraisal> selectedAppraisals =
      ObservableList<RepresentativeAppraisal>();

  @override
  @observable
  ObservableList<RepresentativeAppraisal> appraisalsForRepresentatives =
      ObservableList<RepresentativeAppraisal>();

  @override
  @observable
  ObservableList<RepresentativeAppraisal> appraisalsForDirector =
      ObservableList<RepresentativeAppraisal>();

  @override
  @observable
  ObservableMap<int, List<RepresentativeAppraisal>> appraisalsHistoryByYear =
      ObservableMap<int, List<RepresentativeAppraisal>>();

  @observable
  ObservableList<RepresentativeAppraisal> appraisalsOfTheYear =
      ObservableList<RepresentativeAppraisal>();

  @override
  @observable
  ObservableList<Representative> representatives =
      ObservableList<Representative>();

  @override
  @observable
  ObservableList<Representative> representativesWithoutAppraisal =
      ObservableList<Representative>();

  StreamSubscription<Map<String, dynamic>>?
      _appraisalsAndRepresentativesStreamSubscription;

  // Methods:-------------------------------------------------------------------
  @override
  @action
  Future<void> setSelectedTabIndex(int selectTabIndex) async {
    this.selectTabIndex = selectTabIndex;
    setSelectedYear(null);
    isMultiSelection = false;
    selectedAppraisals.clear();
  }

  @override
  @action
  void setSelectedYear(int? selectedYear) {
    this.selectedYear = selectedYear;
  }

  @override
  @action
  Future<void> init() async {
    selectTabIndex = 1;
    selectedAppraisals.clear();
    _appraisalsAndRepresentativesStreamSubscription?.cancel();
    _appraisalsAndRepresentativesStreamSubscription =
        _getAppraisalsAndRepresentativesAsStream(agency.id, eager: true)
            .stream
            .listen((Map<String, dynamic> data) {
      appraisalsForRepresentatives = ObservableList<RepresentativeAppraisal>.of(
          data['appraisalsForRepresentatives']);
      appraisalsForDirector = ObservableList<RepresentativeAppraisal>.of(
          data['appraisalsForDirector']);
      appraisalsHistoryByYear =
          ObservableMap<int, List<RepresentativeAppraisal>>.of(
              data['appraisalsHistoryByYear']);
      representatives =
          ObservableList<Representative>.of(data['representatives']);
      representativesWithoutAppraisal = ObservableList<Representative>.of(
          data['representativesWithoutAppraisal']);
    });
  }

  StreamController<Map<String, dynamic>>
      _getAppraisalsAndRepresentativesAsStream(String agencyId,
          {bool eager = false}) {
    return getIt<StreamUtilsInterface>()
        .combine<dynamic, Map<String, dynamic>>([
      _representativeAppraisalService.getByAgencyIdAsStream(agencyId,
          eager: eager),
      _representativeService
          .getSalesRepsByAgencyIdFromFirestoreAsStream(agencyId),
    ], (List<dynamic> data) {
      List<RepresentativeAppraisal> representativeAppraisals = data[0] ?? [];
      List<Representative> representatives = data[1] ?? [];
      // appraisalsForRepresentatives
      List<RepresentativeAppraisal> appraisalsForRepresentatives =
          representativeAppraisals
              .where((a) => a.completedByRepresentativeAt == null)
              .toList();
      // appraisalsForDirector
      List<RepresentativeAppraisal> appraisalsForDirector =
          representativeAppraisals
              .where((a) => (a.completedByDirectorAt == null ||
                  a.representativeAppraisalFormFileDataId == null))
              .toList();
      // appraisalsHistory
      List<RepresentativeAppraisal> appraisalsHistory = representativeAppraisals
          .where((a) =>
              a.completedByRepresentativeAt != null &&
              a.completedByDirectorAt != null)
          .toList();
      // appraisalsHistoryByYear
      Map<int, List<RepresentativeAppraisal>> appraisalsHistoryByYear =
          groupBy(appraisalsHistory, (appraisal) => appraisal.limitDate.year);
      // representatives
      representatives.sort((a, b) => a.fullName.compareTo(b.fullName));
      // representativesWithoutAppraisal
      int currentYear = DateTime.now().year;
      List<RepresentativeAppraisal> appraisalsOfTheYear =
          representativeAppraisals
              .where((a) => (a.limitDate.isAfter(DateTime(currentYear)) &&
                  a.limitDate.isBefore(DateTime(currentYear + 1))))
              .toList();
      List<Representative> representativesWithoutAppraisal = representatives
          .where((r) => !appraisalsOfTheYear
              .map((a) => a.representativeId)
              .contains(r.id))
          .toList();
      return {
        'appraisalsForRepresentatives': appraisalsForRepresentatives,
        'appraisalsForDirector': appraisalsForDirector,
        'appraisalsHistoryByYear': appraisalsHistoryByYear,
        'representatives': representatives,
        'representativesWithoutAppraisal': representativesWithoutAppraisal,
      };
    });
  }

  @override
  @action
  void toggleMultiSelection() {
    isMultiSelection = !isMultiSelection;
    selectedAppraisals.clear();
  }

  @override
  @action
  void selectAppraisal(RepresentativeAppraisal appraisal) {
    if (selectedAppraisals.contains(appraisal)) {
      selectedAppraisals.remove(appraisal);
    } else {
      selectedAppraisals.add(appraisal);
    }
  }

  @override
  void dispose() {
    _appraisalsAndRepresentativesStreamSubscription?.cancel();
  }
}
