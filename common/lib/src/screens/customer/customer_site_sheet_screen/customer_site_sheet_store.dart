import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'customer_site_sheet_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class CustomerSiteSheetStoreInterface {
  // Constructor
  CustomerSiteSheetStoreInterface._(
    this.currentTab,
  );

  // Variables
  SiteSheet? siteSheet;
  CustomerSiteSheetScreenTab currentTab;
  Uint8List? drawing;

  // Computed
  Map<CustomerSiteSheetScreenTab, bool> get completedTabs;
  bool get isCompleted;

  // Methods
  Future<void> init();
  void dispose();
  void setCurrentTab(CustomerSiteSheetScreenTab tab);
  // #1 - General
  void setHouseTypes(List<String> values);
  // #2 - Roof
  // #2.1 - Roof
  void setNumberOfSections(String value);
  void setHasReturnInL(bool value);
  void setTotalRoofArea(String value);
  void setAgeOfRoof(String value);
  void setStateOfRoof(StateOfRoof? value);
  void setVegetation(Vegetation? value);
  void setRoofPitch(RoofPitch? value);
  void setCheckingRecovery(String value);
  // #2.2 - Gutter
  void setExistingGutters(String value);
  void setExistingGuttersColors(String value);
  void setGableHeight(String value);
  void setHeightUnderGutter(String value);
  // #2.3 - Roofing elements
  void setGotVeranda(bool? value);
  void setGotPhotovoltaic(bool? value);
  void setNumberOfChimneys(String value);
  void setNeedToPaintChimneys(bool? value);
  void setChimneysToPaintColor(String value);
  void setNumberOfDormers(String value);
  void setNumberOfVelux(String value);
  void setTypeOfRidge(String value);
  void setStateOfRidge(StateOfRidge? value);
  void setNeedForCementWork(bool? value);
  // #2.4 - Water repellent
  void setVeluxToBeWaterproofed(bool? value);
  void setRigdeToBeWaterproofed(bool? value);
  void setCladdingToBeWaterproofed(bool? value);
  void setEdgesToBeWaterproofed(bool? value);
  void setWaterRepellentColor(String value);
  // #3 - Cover
  void setModelsAndDimensions(String value);
  void setCoverTypes(List<String> values);
  void setNumberOfSlatesOrTilesInAdvance(String value);
  // #4 - Exposure
  void setExposures(List<String> values);
  // #5 - Gutter
  void setGutterTypes(List<String> values);
  void setOtherMaterial(String value);
  void setLengthInLinearMeters(String value);
  void setDownspoutLength(String value);
  void setGuttersColor(String value);
  void setDownspoutsColor(String value);
  void setDownspoutType(DownspoutType? value);
  void setLeftAngleQuantity(String value);
  void setRightAngleQuantity(String value);
  void setNumberOfGutterBottoms(String value);
  void setNumberOfGutterBirths(String value);
  void setNumberOfGutterBends(String value);
  void setNumberOfGutterSleevesOrDolphin(String value);
  void setWithWaterRecuperator(bool? value);
  void setWithLeafGuard(bool? value);
  // #6 - Fascia board
  void setFasciaBoardLength(String value);
  void setFasciaBoardAdvanceInCm(String value);
  void setFasciaBoardColor(String value);
  void setFasciaBoardReturn(String value);
  // #7 - Facade
  void setFacadeArea(String value);
  void setFacadeAge(String value);
  void setTypeOfExistingSupport(String value);
  void setFacadeExistingSupportTypes(List<String> values);
  void setFacadePointings(List<String> values);
  void setIsDampSupport(bool value);
  void setIsBlownCoating(bool? value);
  void setFacadeTypeOfWork(FacadeTypeOfWork? value);
  void setWaterRepellentType(WaterRepellentType? value);
  void setNumberOfWindows(String value);
  void setCracks(String value);
  void setMicroCracks(String value);
  void setFacadeColor(String value);
  void setBaseColor(String value);
  void setWindowSurroundingColor(String value);
  void setExternalVentilationGrilles(String value);
  void setSurroundingWindowsTypes(List<String> values);
  // #8 - Wood treatment
  void setWoodTreatmentType(WoodTreatmentType? value);
  void setWoodTreatmentArea(String value);
  // #9 - Insulation
  void setInsulationAccessType(InsulationAccessType? value);
  void setInsulators(List<String> values);
  void setInsulationArea(String value);
  void setMineralWoolType(String value);
  void setInsulationTypeOfInstallation(InsulationTypeOfInstallation? value);
  void setExistingInsulationType(ExistingInsulationType? value);
  void setExistingInsulationAge(String value);
  void setRemovalOfExistingInsulation(bool? value);
  void setAtticFloorType(AtticFloorType? value);
  void setRoofStructureType(RoofStructureType? value);
  void setVentilationSystem(bool? value);
  void setVentilationSystemAge(String value);
  // #10 - Connection
  void setWaterRecuperator(bool? value);
  void setWaterSupplyType(WaterSupplyType? value);
  void setWaterSupplyOutdoorType(WaterSupplyOutdoorType? value);
  void setWaterPressionType(WaterPressionType? value);
  void setElectricityType(ElectricityType? value);
  // #11 - Comments
  void setPeriodsOfUnavailability(String value);
  void setHeatingSystem(HeatingSystem? value);
  void setZone(Zone? value);
  void setOthersObservations(String value);
  Future<void> setDrawing(Uint8List? image);
  Future<void> clearDrawing();
}

// Params:----------------------------------------------------------------------
class CustomerSiteSheetStoreParams {
  const CustomerSiteSheetStoreParams({
    required this.orderId,
  });

  final String orderId;
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class CustomerSiteSheetStore = _CustomerSiteSheetStoreBase
    with _$CustomerSiteSheetStore;

abstract class _CustomerSiteSheetStoreBase
    with Store
    implements CustomerSiteSheetStoreInterface {
  // Constructor:---------------------------------------------------------------
  _CustomerSiteSheetStoreBase({required CustomerSiteSheetStoreParams params})
      : orderId = params.orderId;

  // Dependencies:--------------------------------------------------------------
  late final SiteSheetServiceInterface _siteSheetService =
      getIt<SiteSheetServiceInterface>();
  late final AgencyServiceInterface _agencyService =
      getIt<AgencyServiceInterface>();
  late final OrderServiceInterface _orderService =
      getIt<OrderServiceInterface>();
  late final FileUtilsInterface _fileUtils = getIt<FileUtilsInterface>();
  late final UuidUtilsInterface _uuidUtils = getIt<UuidUtilsInterface>();
  late final FileDataServiceInterface _fileDataService =
      getIt<FileDataServiceInterface>();

  // Variables:-----------------------------------------------------------------
  final String orderId;

  @override
  @observable
  SiteSheet? siteSheet;

  @override
  @observable
  CustomerSiteSheetScreenTab currentTab =
      CustomerSiteSheetScreenTab.statementOfInformation;

  @override
  @observable
  Uint8List? drawing;

  StreamSubscription<DocumentSnapshot<SiteSheet>>? _siteSheetStreamSubscription;

  // Computed:------------------------------------------------------------------
  @override
  @computed
  Map<CustomerSiteSheetScreenTab, bool> get completedTabs => {
        CustomerSiteSheetScreenTab.statementOfInformation:
            siteSheet?.houseTypes.isNotEmpty ?? false,
        CustomerSiteSheetScreenTab.roof:
            (siteSheet?.numberOfSections.isNotEmpty ?? false) ||
                siteSheet?.hasReturnInL == true ||
                (siteSheet?.totalRoofArea.isNotEmpty ?? false) ||
                (siteSheet?.ageOfRoof.isNotEmpty ?? false) ||
                siteSheet?.stateOfRoof != null ||
                siteSheet?.vegetation != null ||
                siteSheet?.roofPitch != null ||
                (siteSheet?.checkingRecovery.isNotEmpty ?? false) ||
                (siteSheet?.existingGutter.isNotEmpty ?? false) ||
                (siteSheet?.existingGuttersColors.isNotEmpty ?? false) ||
                (siteSheet?.gableHeight.isNotEmpty ?? false) ||
                (siteSheet?.heightUnderGutter.isNotEmpty ?? false) ||
                siteSheet?.gotVeranda != null ||
                siteSheet?.gotPhotovoltaic != null ||
                (siteSheet?.numberOfChimneys.isNotEmpty ?? false) ||
                siteSheet?.needToPaintChimneys != null ||
                (siteSheet?.chimneysToPaintColor.isNotEmpty ?? false) ||
                (siteSheet?.numberOfDormers.isNotEmpty ?? false) ||
                (siteSheet?.numberOfVelux.isNotEmpty ?? false) ||
                (siteSheet?.typeOfRidge.isNotEmpty ?? false) ||
                siteSheet?.stateOfRidge != null ||
                siteSheet?.needForCementWork != null ||
                siteSheet?.veluxToBeWaterproofed != null ||
                siteSheet?.rigdeToBeWaterproofed != null ||
                siteSheet?.claddingToBeWaterproofed != null ||
                siteSheet?.edgesToBeWaterproofed != null ||
                (siteSheet?.waterRepellentColor.isNotEmpty ?? false),
        CustomerSiteSheetScreenTab.cover:
            (siteSheet?.modelsAndDimensions.isNotEmpty ?? false) ||
                (siteSheet?.coverTypes.isNotEmpty ?? false) ||
                (siteSheet?.numberOfSlatesOrTilesInAdvance.isNotEmpty ?? false),
        CustomerSiteSheetScreenTab.exposure:
            siteSheet?.exposures.isNotEmpty ?? false,
        CustomerSiteSheetScreenTab.gutters:
            (siteSheet?.gutterTypes.isNotEmpty ?? false) ||
                (siteSheet?.otherMaterial.isNotEmpty ?? false) ||
                (siteSheet?.lengthInLinearMeters.isNotEmpty ?? false) ||
                (siteSheet?.downspoutLength.isNotEmpty ?? false) ||
                (siteSheet?.guttersColor.isNotEmpty ?? false) ||
                (siteSheet?.downspoutsColor.isNotEmpty ?? false) ||
                siteSheet?.downspoutType != null ||
                (siteSheet?.leftAngleQuantity.isNotEmpty ?? false) ||
                (siteSheet?.rightAngleQuantity.isNotEmpty ?? false) ||
                (siteSheet?.numberOfGutterBottoms.isNotEmpty ?? false) ||
                (siteSheet?.numberOfGutterBirths.isNotEmpty ?? false) ||
                (siteSheet?.numberOfGutterBends.isNotEmpty ?? false) ||
                (siteSheet?.numberOfGutterSleevesOrDolphin.isNotEmpty ??
                    false) ||
                siteSheet?.withLeafGuard != null,
        CustomerSiteSheetScreenTab.fasciaBoard:
            (siteSheet?.fasciaBoardLength.isNotEmpty ?? false) ||
                (siteSheet?.fasciaBoardAdvanceInCm.isNotEmpty ?? false) ||
                (siteSheet?.fasciaBoardColor.isNotEmpty ?? false) ||
                (siteSheet?.fasciaBoardReturn.isNotEmpty ?? false),
        CustomerSiteSheetScreenTab.facade:
            (siteSheet?.facadeArea.isNotEmpty ?? false) ||
                (siteSheet?.facadeAge.isNotEmpty ?? false) ||
                (siteSheet?.typeOfExistingSupport.isNotEmpty ?? false) ||
                (siteSheet?.facadeExistingSupportTypes.isNotEmpty ?? false) ||
                (siteSheet?.facadePointings.isNotEmpty ?? false) ||
                siteSheet?.isDampSupport != false ||
                siteSheet?.isBlownCoating != null ||
                siteSheet?.facadeTypeOfWork != null ||
                siteSheet?.waterRepellentType != null ||
                (siteSheet?.numberOfWindows.isNotEmpty ?? false) ||
                (siteSheet?.cracks.isNotEmpty ?? false) ||
                (siteSheet?.microCracks.isNotEmpty ?? false) ||
                (siteSheet?.facadeColor.isNotEmpty ?? false) ||
                (siteSheet?.baseColor.isNotEmpty ?? false) ||
                (siteSheet?.windowSurroundingColor.isNotEmpty ?? false) ||
                (siteSheet?.externalVentilationGrilles.isNotEmpty ?? false) ||
                (siteSheet?.surroundingWindowsTypes.isNotEmpty ?? false),
        CustomerSiteSheetScreenTab.woodTreatment:
            siteSheet?.woodTreatmentType != null ||
                (siteSheet?.woodTreatmentArea.isNotEmpty ?? false),
        CustomerSiteSheetScreenTab.insulation:
            siteSheet?.insulationAccessType != null ||
                (siteSheet?.insulators.isNotEmpty ?? false) ||
                (siteSheet?.insulationArea.isNotEmpty ?? false) ||
                (siteSheet?.mineralWoolType.isNotEmpty ?? false) ||
                siteSheet?.insulationTypeOfInstallation != null ||
                siteSheet?.existingInsulationType != null ||
                (siteSheet?.existingInsulationAge.isNotEmpty ?? false) ||
                siteSheet?.removalOfExistingInsulation != null ||
                siteSheet?.atticFloorType != null ||
                siteSheet?.roofStructureType != null ||
                siteSheet?.ventilationSystem != null ||
                (siteSheet?.ventilationSystemAge.isNotEmpty ?? false),
        CustomerSiteSheetScreenTab.connection:
            siteSheet?.waterRecuperator != null ||
                siteSheet?.waterSupplyType != null ||
                siteSheet?.waterSupplyOutdoorType != null ||
                siteSheet?.waterPressionType != null ||
                siteSheet?.electricityType != null,
        CustomerSiteSheetScreenTab.comments:
            (siteSheet?.periodsOfUnavailability.isNotEmpty ?? false) ||
                siteSheet?.heatingSystem != null ||
                siteSheet?.zone != null ||
                (siteSheet?.othersObservations.isNotEmpty ?? false) ||
                siteSheet?.drawingFileDataId != null,
      };

  @override
  @computed
  bool get isCompleted =>
      siteSheet != null && completedTabs.values.any((element) => element);

  // Methods:-------------------------------------------------------------------
  @override
  @action
  Future<void> init() async {
    siteSheet = await _siteSheetService.getOrCreateByOrderId(orderId);
    _siteSheetStreamSubscription?.cancel();
    _siteSheetStreamSubscription =
        _siteSheetService.getSnapshots(siteSheet!).listen((snapshot) async {
      final newSiteSheet = snapshot.data();
      if (newSiteSheet != null &&
          newSiteSheet.updatedAt.isAfter(siteSheet!.updatedAt)) {
        siteSheet = newSiteSheet;
      }
    });
  }

  @override
  @action
  void setCurrentTab(CustomerSiteSheetScreenTab tab) {
    currentTab = tab;
  }

  // #1 - General
  @override
  @action
  void setHouseTypes(List<String> values) {
    final List<HouseType> houseTypes = HouseType.fromValues(values);
    siteSheet = siteSheet!.copyWith(houseTypes: houseTypes);
    _siteSheetService.update(siteSheet!);
  }

  // #2 - Roof
  // #2.1 - Roof
  @override
  @action
  void setNumberOfSections(String value) {
    siteSheet = siteSheet!.copyWith(numberOfSections: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setHasReturnInL(bool value) {
    siteSheet = siteSheet!.copyWith(hasReturnInL: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setTotalRoofArea(String value) {
    siteSheet = siteSheet!.copyWith(totalRoofArea: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setAgeOfRoof(String value) {
    siteSheet = siteSheet!.copyWith(ageOfRoof: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setStateOfRoof(StateOfRoof? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.stateOfRoof = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setVegetation(Vegetation? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.vegetation = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setRoofPitch(RoofPitch? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.roofPitch = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setCheckingRecovery(String value) {
    siteSheet = siteSheet!.copyWith(checkingRecovery: value);
    _siteSheetService.update(siteSheet!);
  }

  // #2.2 - Gutter
  @override
  @action
  void setExistingGutters(String value) {
    siteSheet = siteSheet!.copyWith(existingGutter: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setExistingGuttersColors(String value) {
    siteSheet = siteSheet!.copyWith(existingGuttersColors: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setGableHeight(String value) {
    siteSheet = siteSheet!.copyWith(gableHeight: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setHeightUnderGutter(String value) {
    siteSheet = siteSheet!.copyWith(heightUnderGutter: value);
    _siteSheetService.update(siteSheet!);
  }

  // #2.3 - Roofing elements
  @override
  @action
  void setGotVeranda(bool? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.gotVeranda = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setGotPhotovoltaic(bool? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.gotPhotovoltaic = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setNumberOfChimneys(String value) {
    siteSheet = siteSheet!.copyWith(numberOfChimneys: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setNeedToPaintChimneys(bool? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.needToPaintChimneys = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setChimneysToPaintColor(String value) {
    siteSheet = siteSheet!.copyWith(chimneysToPaintColor: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setNumberOfDormers(String value) {
    siteSheet = siteSheet!.copyWith(numberOfDormers: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setNumberOfVelux(String value) {
    siteSheet = siteSheet!.copyWith(numberOfVelux: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setTypeOfRidge(String value) {
    siteSheet = siteSheet!.copyWith(typeOfRidge: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setStateOfRidge(StateOfRidge? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.stateOfRidge = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setNeedForCementWork(bool? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.needForCementWork = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  // #2.4 - Water repellent
  @override
  @action
  void setVeluxToBeWaterproofed(bool? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.veluxToBeWaterproofed = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setRigdeToBeWaterproofed(bool? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.rigdeToBeWaterproofed = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setCladdingToBeWaterproofed(bool? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.claddingToBeWaterproofed = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setEdgesToBeWaterproofed(bool? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.edgesToBeWaterproofed = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setWaterRepellentColor(String value) {
    siteSheet = siteSheet!.copyWith(waterRepellentColor: value);
    _siteSheetService.update(siteSheet!);
  }

  // #3 - Cover
  @override
  @action
  void setModelsAndDimensions(String value) {
    siteSheet = siteSheet!.copyWith(modelsAndDimensions: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setCoverTypes(List<String> values) {
    final List<CoverType> coverTypes = CoverType.fromValues(values);
    siteSheet = siteSheet!.copyWith(coverTypes: coverTypes);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setNumberOfSlatesOrTilesInAdvance(String value) {
    siteSheet = siteSheet!.copyWith(numberOfSlatesOrTilesInAdvance: value);
    _siteSheetService.update(siteSheet!);
  }

  // #4 - Exposure
  @override
  @action
  void setExposures(List<String> values) {
    final List<Exposure> exposures = Exposure.fromValues(values);
    siteSheet = siteSheet!.copyWith(exposures: exposures);
    _siteSheetService.update(siteSheet!);
  }

  // #5 - Gutter
  @override
  @action
  void setGutterTypes(List<String> values) {
    final List<GutterType> gutterTypes = GutterType.fromValues(values);
    siteSheet = siteSheet!.copyWith(gutterTypes: gutterTypes);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setOtherMaterial(String value) {
    siteSheet = siteSheet!.copyWith(otherMaterial: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setLengthInLinearMeters(String value) {
    siteSheet = siteSheet!.copyWith(lengthInLinearMeters: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setDownspoutLength(String value) {
    siteSheet = siteSheet!.copyWith(downspoutLength: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setGuttersColor(String value) {
    siteSheet = siteSheet!.copyWith(guttersColor: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setDownspoutsColor(String value) {
    siteSheet = siteSheet!.copyWith(downspoutsColor: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setDownspoutType(DownspoutType? value) {
    siteSheet = siteSheet!.copyWith(downspoutType: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setLeftAngleQuantity(String value) {
    siteSheet = siteSheet!.copyWith(leftAngleQuantity: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setRightAngleQuantity(String value) {
    siteSheet = siteSheet!.copyWith(rightAngleQuantity: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setNumberOfGutterBottoms(String value) {
    siteSheet = siteSheet!.copyWith(numberOfGutterBottoms: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setNumberOfGutterBirths(String value) {
    siteSheet = siteSheet!.copyWith(numberOfGutterBirths: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setNumberOfGutterBends(String value) {
    siteSheet = siteSheet!.copyWith(numberOfGutterBends: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setNumberOfGutterSleevesOrDolphin(String value) {
    siteSheet = siteSheet!.copyWith(numberOfGutterSleevesOrDolphin: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setWithWaterRecuperator(bool? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.withWaterRecuperator = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setWithLeafGuard(bool? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.withLeafGuard = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  // #6 - Fascia board
  @override
  @action
  void setFasciaBoardLength(String value) {
    siteSheet = siteSheet!.copyWith(fasciaBoardLength: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setFasciaBoardAdvanceInCm(String value) {
    siteSheet = siteSheet!.copyWith(fasciaBoardAdvanceInCm: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setFasciaBoardColor(String value) {
    siteSheet = siteSheet!.copyWith(fasciaBoardColor: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setFasciaBoardReturn(String value) {
    siteSheet = siteSheet!.copyWith(fasciaBoardReturn: value);
    _siteSheetService.update(siteSheet!);
  }

  // #7 - Facade
  @override
  @action
  void setFacadeArea(String value) {
    siteSheet = siteSheet!.copyWith(facadeArea: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setFacadeAge(String value) {
    siteSheet = siteSheet!.copyWith(facadeAge: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setTypeOfExistingSupport(String value) {
    siteSheet = siteSheet!.copyWith(typeOfExistingSupport: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setFacadeExistingSupportTypes(List<String> values) {
    final List<FacadeExistingSupportType> facadeExistingSupportTypes =
        FacadeExistingSupportType.fromValues(values);
    siteSheet = siteSheet!
        .copyWith(facadeExistingSupportTypes: facadeExistingSupportTypes);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setFacadePointings(List<String> values) {
    final List<FacadePointing> facadePointings =
        FacadePointing.fromValues(values);
    siteSheet = siteSheet!.copyWith(facadePointings: facadePointings);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setIsDampSupport(bool value) {
    siteSheet = siteSheet!.copyWith(isDampSupport: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setIsBlownCoating(bool? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.isBlownCoating = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setFacadeTypeOfWork(FacadeTypeOfWork? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.facadeTypeOfWork = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setWaterRepellentType(WaterRepellentType? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.waterRepellentType = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setNumberOfWindows(String value) {
    siteSheet = siteSheet!.copyWith(numberOfWindows: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setCracks(String value) {
    siteSheet = siteSheet!.copyWith(cracks: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setMicroCracks(String value) {
    siteSheet = siteSheet!.copyWith(microCracks: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setFacadeColor(String value) {
    siteSheet = siteSheet!.copyWith(facadeColor: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setBaseColor(String value) {
    siteSheet = siteSheet!.copyWith(baseColor: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setWindowSurroundingColor(String value) {
    siteSheet = siteSheet!.copyWith(windowSurroundingColor: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setExternalVentilationGrilles(String value) {
    siteSheet = siteSheet!.copyWith(externalVentilationGrilles: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setSurroundingWindowsTypes(List<String> values) {
    final List<SurroundingWindowsType> surroundingWindowsTypes =
        SurroundingWindowsType.fromValues(values);
    siteSheet =
        siteSheet!.copyWith(surroundingWindowsTypes: surroundingWindowsTypes);
    _siteSheetService.update(siteSheet!);
  }

  // #8 - Wood treatment
  @override
  @action
  void setWoodTreatmentType(WoodTreatmentType? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.woodTreatmentType = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setWoodTreatmentArea(String value) {
    siteSheet = siteSheet!.copyWith(woodTreatmentArea: value);
    _siteSheetService.update(siteSheet!);
  }

  // #9 - Insulation
  @override
  @action
  void setInsulationAccessType(InsulationAccessType? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.insulationAccessType = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setInsulators(List<String> values) {
    final List<Insulator> insulators = Insulator.fromValues(values);
    siteSheet = siteSheet!.copyWith(insulators: insulators);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setInsulationArea(String value) {
    siteSheet = siteSheet!.copyWith(insulationArea: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setMineralWoolType(String value) {
    siteSheet = siteSheet!.copyWith(mineralWoolType: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setInsulationTypeOfInstallation(InsulationTypeOfInstallation? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.insulationTypeOfInstallation = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setExistingInsulationType(ExistingInsulationType? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.existingInsulationType = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setExistingInsulationAge(String value) {
    siteSheet = siteSheet!.copyWith(existingInsulationAge: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setRemovalOfExistingInsulation(bool? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.removalOfExistingInsulation = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setAtticFloorType(AtticFloorType? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.atticFloorType = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setRoofStructureType(RoofStructureType? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.roofStructureType = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setVentilationSystem(bool? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.ventilationSystem = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setVentilationSystemAge(String value) {
    siteSheet = siteSheet!.copyWith(ventilationSystemAge: value);
    _siteSheetService.update(siteSheet!);
  }

  // #10 - Connection
  @override
  @action
  void setWaterRecuperator(bool? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.waterRecuperator = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setWaterSupplyType(WaterSupplyType? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.waterSupplyType = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setWaterSupplyOutdoorType(WaterSupplyOutdoorType? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.waterSupplyOutdoorType = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setWaterPressionType(WaterPressionType? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.waterPressionType = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setElectricityType(ElectricityType? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.electricityType = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  // #11 - Comments
  @override
  @action
  void setPeriodsOfUnavailability(String value) {
    siteSheet = siteSheet!.copyWith(periodsOfUnavailability: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setHeatingSystem(HeatingSystem? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.heatingSystem = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setZone(Zone? value) {
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.zone = value;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  void setOthersObservations(String value) {
    siteSheet = siteSheet!.copyWith(othersObservations: value);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  Future<void> setDrawing(Uint8List? image) async {
    if (image == null) return;

    drawing = image;

    // Create or update file data
    final uniqueName = 'drawing-$orderId.png';
    final Agency currentAgency = (await _agencyService.getCurrent())!;
    final Order order = (await _orderService.getById(orderId, eager: true))!;
    final File file = await _fileUtils.save(
      path: await _fileUtils.getUploadPath(
        agencyName: currentAgency.label,
        customerName: order.customer!.name,
        fileName: uniqueName,
      ),
    );
    await file.writeAsBytes(image);

    // create file data
    FileData fileData = FileData(
      id: _uuidUtils.generate(),
      uniqueName: uniqueName,
      displayName: uniqueName,
      syncStatus: SyncStatus.NOT_READY,
      agencyId: currentAgency.id,
    );

    await _fileDataService.createAndUpload(fileData, file);

    siteSheet = siteSheet!.copyWith(drawingFileDataId: fileData.id);
    _siteSheetService.update(siteSheet!);
  }

  @override
  @action
  Future<void> clearDrawing() async {
    drawing = null;
    _fileDataService.deleteById(siteSheet!.drawingFileDataId!);
    final updatedSiteSheet = siteSheet!.copyWith();
    updatedSiteSheet.drawingFileDataId = null;
    siteSheet = updatedSiteSheet;
    _siteSheetService.update(siteSheet!);
  }

  // Dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    _siteSheetStreamSubscription?.cancel();
  }
}
