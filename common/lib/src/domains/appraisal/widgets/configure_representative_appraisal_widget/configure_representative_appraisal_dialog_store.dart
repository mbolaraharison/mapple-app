import 'dart:async';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'configure_representative_appraisal_dialog_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class ConfigureRepresentativeAppraisalDialogStoreInterface {
  ConfigureRepresentativeAppraisalDialogStoreInterface._(
    this.representative,
    this.probationaryPeriodValidation,
    this.corporateVehicle,
    this.twoMonthsWith3540BookedMeetings,
    this.firstIntroductionBeforeMentor,
    this.twoMonthsWith15OpportunityRequests,
    this.aloneOnFirstSale,
    this.firstSaleAtFair,
    this.aloneOn4FundingSales,
    this.twoMonthsWith20KTurnover,
    this.aloneOnFirstAdditionalSale,
    this.aloneOn30KOrMoreTurnoverInOneMonth,
    this.soldTwoProductsInOneSale,
  );

  Representative representative;

  bool probationaryPeriodValidation;

  bool corporateVehicle;

  // First base
  bool twoMonthsWith3540BookedMeetings;

  bool firstIntroductionBeforeMentor;

  bool twoMonthsWith15OpportunityRequests;

  bool aloneOnFirstSale;

  // Second base
  bool firstSaleAtFair;

  bool aloneOn4FundingSales;

  bool twoMonthsWith20KTurnover;

  bool aloneOnFirstAdditionalSale;

  // Third base
  bool aloneOn30KOrMoreTurnoverInOneMonth;

  bool soldTwoProductsInOneSale;

  void setProbationaryPeriodValidation(bool value);

  void setCorporateVehicle(bool value);

  void setTwoMonthsWith3540BookedMeetings(bool value);

  void setFirstIntroductionBeforeMentor(bool value);

  void setTwoMonthsWith15OpportunityRequests(bool value);

  void setAloneOnFirstSale(bool value);

  void setFirstSaleAtFair(bool value);

  void setAloneOn4FundingSales(bool value);

  void setTwoMonthsWith20KTurnover(bool value);

  void setAloneOnFirstAdditionalSale(bool value);

  void setAloneOn30KOrMoreTurnoverInOneMonth(bool value);

  void setSoldTwoProductsInOneSale(bool value);

  Future<void> updateRepresentative();
}

// Params:----------------------------------------------------------------------
class ConfigureRepresentativeAppraisalDialogStoreParams {
  ConfigureRepresentativeAppraisalDialogStoreParams(
      {required this.representative});

  final Representative representative;
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class ConfigureRepresentativeAppraisalDialogStore = _ConfigureRepresentativeAppraisalDialogStoreBase
    with _$ConfigureRepresentativeAppraisalDialogStore;

abstract class _ConfigureRepresentativeAppraisalDialogStoreBase
    with Store
    implements ConfigureRepresentativeAppraisalDialogStoreInterface {
  // Constructor:---------------------------------------------------------------
  _ConfigureRepresentativeAppraisalDialogStoreBase(
      {required ConfigureRepresentativeAppraisalDialogStoreParams params})
      : representative = params.representative {
    _initStreams();
  }
  // Services:------------------------------------------------------------------
  late final RepresentativeServiceInterface _representativeService =
      getIt<RepresentativeServiceInterface>();

  // Variables:-----------------------------------------------------------------
  @override
  @observable
  Representative representative;

  @override
  @observable
  bool probationaryPeriodValidation = false;

  @override
  @observable
  bool corporateVehicle = false;

  @override
  @observable
  bool twoMonthsWith3540BookedMeetings = false;

  @override
  @observable
  bool firstIntroductionBeforeMentor = false;

  @override
  @observable
  bool twoMonthsWith15OpportunityRequests = false;

  @override
  @observable
  bool aloneOnFirstSale = false;

  @override
  @observable
  bool firstSaleAtFair = false;

  @override
  @observable
  bool aloneOn4FundingSales = false;

  @override
  @observable
  bool twoMonthsWith20KTurnover = false;

  @override
  @observable
  bool aloneOnFirstAdditionalSale = false;

  @override
  @observable
  bool aloneOn30KOrMoreTurnoverInOneMonth = false;

  @override
  @observable
  bool soldTwoProductsInOneSale = false;

  // Actions:-------------------------------------------------------------------

  @override
  @action
  void setProbationaryPeriodValidation(bool value) {
    probationaryPeriodValidation = value;
  }

  @override
  @action
  void setCorporateVehicle(bool value) {
    corporateVehicle = value;
  }

  @override
  @action
  void setTwoMonthsWith3540BookedMeetings(bool value) {
    twoMonthsWith3540BookedMeetings = value;
  }

  @override
  @action
  void setFirstIntroductionBeforeMentor(bool value) {
    firstIntroductionBeforeMentor = value;
  }

  @override
  @action
  void setTwoMonthsWith15OpportunityRequests(bool value) {
    twoMonthsWith15OpportunityRequests = value;
  }

  @override
  @action
  void setAloneOnFirstSale(bool value) {
    aloneOnFirstSale = value;
  }

  @override
  @action
  void setFirstSaleAtFair(bool value) {
    firstSaleAtFair = value;
  }

  @override
  @action
  void setAloneOn4FundingSales(bool value) {
    aloneOn4FundingSales = value;
  }

  @override
  @action
  void setTwoMonthsWith20KTurnover(bool value) {
    twoMonthsWith20KTurnover = value;
  }

  @override
  @action
  void setAloneOnFirstAdditionalSale(bool value) {
    aloneOnFirstAdditionalSale = value;
  }

  @override
  @action
  void setAloneOn30KOrMoreTurnoverInOneMonth(bool value) {
    aloneOn30KOrMoreTurnoverInOneMonth = value;
  }

  @override
  @action
  void setSoldTwoProductsInOneSale(bool value) {
    soldTwoProductsInOneSale = value;
  }

  @override
  @action
  Future<void> updateRepresentative() {
    representative.probationaryPeriodValidation = probationaryPeriodValidation;
    representative.corporateVehicle = corporateVehicle;
    representative.twoMonthsWith3540BookedMeetings =
        twoMonthsWith3540BookedMeetings;
    representative.firstIntroductionBeforeMentor =
        firstIntroductionBeforeMentor;
    representative.twoMonthsWith15OpportunityRequests =
        twoMonthsWith15OpportunityRequests;
    representative.aloneOnFirstSale = aloneOnFirstSale;
    representative.firstSaleAtFair = firstSaleAtFair;
    representative.aloneOn4FundingSales = aloneOn4FundingSales;
    representative.twoMonthsWith20KTurnover = twoMonthsWith20KTurnover;
    representative.aloneOnFirstAdditionalSale = aloneOnFirstAdditionalSale;
    representative.aloneOn30KOrMoreTurnoverInOneMonth =
        aloneOn30KOrMoreTurnoverInOneMonth;
    representative.soldTwoProductsInOneSale = soldTwoProductsInOneSale;
    return _representativeService.updateToFirestore(representative);
  }

  // Other methods:-------------------------------------------------------------
  void _initStreams() {
    setProbationaryPeriodValidation(
        representative.probationaryPeriodValidation);
    setCorporateVehicle(representative.corporateVehicle);
    setTwoMonthsWith3540BookedMeetings(
        representative.twoMonthsWith3540BookedMeetings);
    setFirstIntroductionBeforeMentor(
        representative.firstIntroductionBeforeMentor);
    setTwoMonthsWith15OpportunityRequests(
        representative.twoMonthsWith15OpportunityRequests);
    setAloneOnFirstSale(representative.aloneOnFirstSale);
    setFirstSaleAtFair(representative.firstSaleAtFair);
    setAloneOn4FundingSales(representative.aloneOn4FundingSales);
    setTwoMonthsWith20KTurnover(representative.twoMonthsWith20KTurnover);
    setAloneOnFirstAdditionalSale(representative.aloneOnFirstAdditionalSale);
    setAloneOn30KOrMoreTurnoverInOneMonth(
        representative.aloneOn30KOrMoreTurnoverInOneMonth);
    setSoldTwoProductsInOneSale(representative.soldTwoProductsInOneSale);
  }
}
