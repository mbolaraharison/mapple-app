import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:maple_common/maple_common.dart';

class SiteSheet extends AbstractBaseModel {
  // Constructor:---------------------------------------------------------------
  SiteSheet({
    required super.id,
    required this.orderId,
    this.version,
    this.houseTypes = const [],
    this.numberOfSections = '',
    this.hasReturnInL = false,
    this.totalRoofArea = '',
    this.ageOfRoof = '',
    this.stateOfRoof,
    this.vegetation,
    this.existingGutter = '',
    this.existingGuttersColors = '',
    this.gotVeranda,
    this.gotPhotovoltaic,
    this.numberOfChimneys = '',
    this.needToPaintChimneys,
    this.chimneysToPaintColor = '',
    this.numberOfDormers = '',
    this.numberOfVelux = '',
    this.typeOfRidge = '',
    this.stateOfRidge,
    this.needForCementWork,
    this.gableHeight = '',
    this.heightUnderGutter = '',
    this.roofPitch,
    this.checkingRecovery = '',
    this.veluxToBeWaterproofed,
    this.rigdeToBeWaterproofed,
    this.claddingToBeWaterproofed,
    this.edgesToBeWaterproofed,
    this.waterRepellentColor = '',
    this.modelsAndDimensions = '',
    this.coverTypes = const [],
    this.numberOfSlatesOrTilesInAdvance = '',
    this.exposures = const [],
    this.gutterTypes = const [],
    this.otherMaterial = '',
    this.lengthInLinearMeters = '',
    this.downspoutLength = '',
    this.guttersColor = '',
    this.downspoutsColor = '',
    this.downspoutType,
    this.leftAngleQuantity = '',
    this.rightAngleQuantity = '',
    this.numberOfGutterBottoms = '',
    this.numberOfGutterBirths = '',
    this.numberOfGutterBends = '',
    this.numberOfGutterSleevesOrDolphin = '',
    this.withWaterRecuperator,
    this.withLeafGuard,
    this.fasciaBoardLength = '',
    this.fasciaBoardAdvanceInCm = '',
    this.fasciaBoardColor = '',
    this.fasciaBoardReturn = '',
    this.facadeArea = '',
    this.facadeAge = '',
    this.typeOfExistingSupport = '',
    this.facadeExistingSupportTypes = const [],
    this.facadePointings = const [],
    this.isDampSupport = false,
    this.isBlownCoating,
    this.facadeTypeOfWork,
    this.waterRepellentType,
    this.numberOfWindows = '',
    this.cracks = '',
    this.microCracks = '',
    this.facadeColor = '',
    this.baseColor = '',
    this.windowSurroundingColor = '',
    this.externalVentilationGrilles = '',
    this.surroundingWindowsTypes = const [],
    this.woodTreatmentType,
    this.woodTreatmentArea = '',
    this.insulationAccessType,
    this.insulators = const [],
    this.insulationArea = '',
    this.mineralWoolType = '',
    this.insulationTypeOfInstallation,
    this.existingInsulationType,
    this.existingInsulationAge = '',
    this.removalOfExistingInsulation,
    this.atticFloorType,
    this.roofStructureType,
    this.ventilationSystem,
    this.ventilationSystemAge = '',
    this.waterRecuperator,
    this.waterSupplyType,
    this.waterSupplyOutdoorType,
    this.waterPressionType,
    this.electricityType,
    this.periodsOfUnavailability = '',
    this.heatingSystem,
    this.zone,
    this.othersObservations = '',
    this.drawingFileDataId,
    super.createdAt,
    super.updatedAt,
  });

  // Variables:-----------------------------------------------------------------
  final String orderId;
  final int? version;

  // #1 - General
  List<HouseType> houseTypes;

  // #2 - Roof
  // #2.1 - Roof
  String numberOfSections;
  bool hasReturnInL;
  String totalRoofArea;
  String ageOfRoof;
  StateOfRoof? stateOfRoof;
  Vegetation? vegetation;
  RoofPitch? roofPitch;
  String checkingRecovery;

  // #2.2 - Gutter
  String existingGutter;
  String existingGuttersColors;
  String gableHeight;
  String heightUnderGutter;

  // #2.3 - Roofing elements
  bool? gotVeranda;
  bool? gotPhotovoltaic;
  String numberOfChimneys;
  bool? needToPaintChimneys;
  String chimneysToPaintColor;
  String numberOfDormers;
  String numberOfVelux;
  String typeOfRidge;
  StateOfRidge? stateOfRidge;
  bool? needForCementWork;

  // #2.4 - Water repellent
  bool? veluxToBeWaterproofed;
  bool? rigdeToBeWaterproofed;
  bool? claddingToBeWaterproofed;
  bool? edgesToBeWaterproofed;
  String waterRepellentColor;

  // #3 - Cover
  String modelsAndDimensions;
  List<CoverType> coverTypes;
  String numberOfSlatesOrTilesInAdvance;

  // #4 - Exposure
  List<Exposure> exposures;

  // #5 - Gutter
  List<GutterType> gutterTypes;
  String otherMaterial;
  String lengthInLinearMeters;
  String downspoutLength;
  String guttersColor;
  String downspoutsColor;
  DownspoutType? downspoutType;
  String leftAngleQuantity;
  String rightAngleQuantity;
  String numberOfGutterBottoms;
  String numberOfGutterBirths;
  String numberOfGutterBends;
  String numberOfGutterSleevesOrDolphin;
  bool? withWaterRecuperator;
  bool? withLeafGuard;

  // #6 - Fascia board
  String fasciaBoardLength;
  String fasciaBoardAdvanceInCm;
  String fasciaBoardColor;
  String fasciaBoardReturn;

  // #7 - Facade
  String facadeArea;
  String facadeAge;
  String typeOfExistingSupport;
  List<FacadeExistingSupportType> facadeExistingSupportTypes;
  List<FacadePointing> facadePointings;
  bool isDampSupport;
  bool? isBlownCoating;
  FacadeTypeOfWork? facadeTypeOfWork;
  WaterRepellentType? waterRepellentType;
  String numberOfWindows;
  String cracks;
  String microCracks;
  String facadeColor;
  String baseColor;
  String windowSurroundingColor;
  String externalVentilationGrilles;
  List<SurroundingWindowsType> surroundingWindowsTypes;

  // #8 - Wood treatment
  WoodTreatmentType? woodTreatmentType;
  String woodTreatmentArea;

  // #9 - Insulation
  InsulationAccessType? insulationAccessType;
  List<Insulator> insulators;
  String insulationArea;
  String mineralWoolType;
  InsulationTypeOfInstallation? insulationTypeOfInstallation;
  ExistingInsulationType? existingInsulationType;
  String existingInsulationAge;
  bool? removalOfExistingInsulation;
  AtticFloorType? atticFloorType;
  RoofStructureType? roofStructureType;
  bool? ventilationSystem;
  String ventilationSystemAge;

  // #10 - Connection
  bool? waterRecuperator;
  WaterSupplyType? waterSupplyType;
  WaterSupplyOutdoorType? waterSupplyOutdoorType;
  WaterPressionType? waterPressionType;
  ElectricityType? electricityType;

  // #11 - Comments
  String periodsOfUnavailability;
  HeatingSystem? heatingSystem;
  Zone? zone;
  String othersObservations;
  String? drawingFileDataId;

  // Relationships variables
  Order? order;
  FileData? drawingFileData;

  // Static variables:----------------------------------------------------------
  static const double drawingAreaWidth = 1225;
  static const double drawingAreaHeight = 960;

  // Getters:-------------------------------------------------------------------
  String get houseTypesString => houseTypes.map((e) => e.label).join(', ');

  String get coverTypesString => coverTypes.map((e) => e.label).join(', ');

  String get exposuresString => exposures.map((e) => e.label).join(', ');

  String get gutterTypesString => gutterTypes.map((e) => e.label).join(', ');

  String get facadeExistingSupportTypesString =>
      facadeExistingSupportTypes.map((e) => e.label).join(', ');

  String get facadePointingsString =>
      facadePointings.map((e) => e.label).join(', ');

  String get surroundingWindowsTypesString =>
      surroundingWindowsTypes.map((e) => e.label).join(', ');

  String get insulatorsString => insulators.map((e) => e.label).join(', ');

  Future<File?> get drawingFile async {
    if (drawingFileDataId == null) {
      return null;
    }
    final fileData = await getIt<FileDataServiceInterface>().getById(
      drawingFileDataId!,
      isRemote: true,
    );
    if (fileData == null) {
      return null;
    }
    return fileData.file;
  }

  // Base methods:--------------------------------------------------------------
  factory SiteSheet.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return SiteSheet(
      id: snapshot.id,
      orderId: data?['orderId'] as String,
      version: data?['version'] as int?,
      houseTypes: (data?['houseTypes'] as List<dynamic>)
          .map((e) =>
              HouseType.values.firstWhere((element) => element.name == e))
          .toList(),
      numberOfSections: data?['numberOfSections'] as String,
      hasReturnInL: data?['hasReturnInL'] as bool,
      totalRoofArea: data?['totalRoofArea'] as String,
      ageOfRoof: data?['ageOfRoof'] as String,
      stateOfRoof: data?['stateOfRoof'] != null
          ? StateOfRoof.values.firstWhere(
              (e) => e.name == data?['stateOfRoof'],
            )
          : null,
      vegetation: data?['vegetation'] != null
          ? Vegetation.values.firstWhere(
              (e) => e.name == data?['vegetation'],
            )
          : null,
      existingGutter: data?['existingGutter'] as String,
      existingGuttersColors: data?['existingGuttersColors'] as String,
      gotVeranda: data?['gotVeranda'] as bool?,
      gotPhotovoltaic: data?['gotPhotovoltaic'] as bool?,
      numberOfChimneys: data?['numberOfChimneys'] as String,
      needToPaintChimneys: data?['needToPaintChimneys'] as bool?,
      chimneysToPaintColor: data?['chimneysToPaintColor'] as String,
      numberOfDormers: data?['numberOfDormers'] as String,
      numberOfVelux: data?['numberOfVelux'] as String,
      typeOfRidge: data?['typeOfRidge'] as String,
      stateOfRidge: data?['stateOfRidge'] != null
          ? StateOfRidge.values.firstWhere(
              (e) => e.name == data?['stateOfRidge'],
            )
          : null,
      needForCementWork: data?['needForCementWork'] as bool?,
      gableHeight: data?['gableHeight'] as String,
      heightUnderGutter: data?['heightUnderGutter'] as String,
      roofPitch: data?['roofPitch'] != null
          ? RoofPitch.values.firstWhere(
              (e) => e.name == data?['roofPitch'],
            )
          : null,
      checkingRecovery: data?['checkingRecovery'] as String,
      veluxToBeWaterproofed: data?['veluxToBeWaterproofed'] as bool?,
      rigdeToBeWaterproofed: data?['rigdeToBeWaterproofed'] as bool?,
      claddingToBeWaterproofed: data?['claddingToBeWaterproofed'] as bool?,
      edgesToBeWaterproofed: data?['edgesToBeWaterproofed'] as bool?,
      waterRepellentColor: data?['waterRepellentColor'] as String,
      modelsAndDimensions: data?['modelsAndDimensions'] as String,
      coverTypes: (data?['coverTypes'] as List<dynamic>)
          .map((e) =>
              CoverType.values.firstWhere((element) => element.name == e))
          .toList(),
      numberOfSlatesOrTilesInAdvance:
          data?['numberOfSlatesOrTilesInAdvance'] as String,
      exposures: (data?['exposures'] as List<dynamic>)
          .map(
              (e) => Exposure.values.firstWhere((element) => element.name == e))
          .toList(),
      gutterTypes: (data?['gutterTypes'] as List<dynamic>)
          .map((e) =>
              GutterType.values.firstWhere((element) => element.name == e))
          .toList(),
      otherMaterial: data?['otherMaterial'] as String,
      lengthInLinearMeters: data?['lengthInLinearMeters'] as String,
      downspoutLength: data?['downspoutLength'] as String,
      guttersColor: data?['guttersColor'] as String,
      downspoutsColor: data?['downspoutsColor'] as String,
      downspoutType: data?['downspoutType'] != null
          ? DownspoutType.values.firstWhere(
              (e) => e.name == data?['downspoutType'],
            )
          : null,
      leftAngleQuantity: data?['leftAngleQuantity'] as String,
      rightAngleQuantity: data?['rightAngleQuantity'] as String,
      numberOfGutterBottoms: data?['numberOfGutterBottoms'] as String,
      numberOfGutterBirths: data?['numberOfGutterBirths'] as String,
      numberOfGutterBends: data?['numberOfGutterBends'] as String,
      numberOfGutterSleevesOrDolphin:
          data?['numberOfGutterSleevesOrDolphin'] as String,
      withWaterRecuperator: data?['withWaterRecuperator'] as bool?,
      withLeafGuard: data?['withLeafGuard'] as bool?,
      fasciaBoardLength: data?['fasciaBoardLength'] as String,
      fasciaBoardAdvanceInCm: data?['fasciaBoardAdvanceInCm'] as String,
      fasciaBoardColor: data?['fasciaBoardColor'] as String,
      fasciaBoardReturn: data?['fasciaBoardReturn'] as String,
      facadeArea: data?['facadeArea'] as String,
      facadeAge: data?['facadeAge'] as String,
      typeOfExistingSupport: data?['typeOfExistingSupport'] as String,
      facadeExistingSupportTypes:
          (data?['facadeExistingSupportTypes'] as List<dynamic>)
              .map((e) => FacadeExistingSupportType.values
                  .firstWhere((element) => element.name == e))
              .toList(),
      facadePointings: (data?['facadePointings'] as List<dynamic>)
          .map((e) =>
              FacadePointing.values.firstWhere((element) => element.name == e))
          .toList(),
      isDampSupport: data?['isDampSupport'] as bool,
      isBlownCoating: data?['isBlownCoating'] as bool?,
      facadeTypeOfWork: data?['facadeTypeOfWork'] != null
          ? FacadeTypeOfWork.values.firstWhere(
              (e) => e.name == data?['facadeTypeOfWork'],
            )
          : null,
      waterRepellentType: data?['waterRepellentType'] != null
          ? WaterRepellentType.values.firstWhere(
              (e) => e.name == data?['waterRepellentType'],
            )
          : null,
      numberOfWindows: data?['numberOfWindows'] as String,
      cracks: data?['cracks'] as String,
      microCracks: data?['microCracks'] as String,
      facadeColor: data?['facadeColor'] as String,
      baseColor: data?['baseColor'] as String,
      windowSurroundingColor: data?['windowSurroundingColor'] as String,
      externalVentilationGrilles: data?['externalVentilationGrilles'] as String,
      surroundingWindowsTypes:
          (data?['surroundingWindowsTypes'] as List<dynamic>)
              .map((e) => SurroundingWindowsType.values
                  .firstWhere((element) => element.name == e))
              .toList(),
      woodTreatmentType: data?['woodTreatmentType'] != null
          ? WoodTreatmentType.values.firstWhere(
              (e) => e.name == data?['woodTreatmentType'],
            )
          : null,
      woodTreatmentArea: data?['woodTreatmentArea'] as String,
      insulationAccessType: data?['insulationAccessType'] != null
          ? InsulationAccessType.values.firstWhere(
              (e) => e.name == data?['insulationAccessType'],
            )
          : null,
      insulators: (data?['insulators'] as List<dynamic>)
          .map((e) =>
              Insulator.values.firstWhere((element) => element.name == e))
          .toList(),
      insulationArea: data?['insulationArea'] as String,
      mineralWoolType: data?['mineralWoolType'] as String,
      insulationTypeOfInstallation:
          data?['insulationTypeOfInstallation'] != null
              ? InsulationTypeOfInstallation.values.firstWhere(
                  (e) => e.name == data?['insulationTypeOfInstallation'],
                )
              : null,
      existingInsulationType: data?['existingInsulationType_v2'] != null
          ? ExistingInsulationType.values.firstWhere(
              (e) => e.name == data?['existingInsulationType_v2'],
            )
          : null,
      existingInsulationAge: data?['existingInsulationAge'] as String,
      removalOfExistingInsulation:
          data?['removalOfExistingInsulation'] as bool?,
      atticFloorType: data?['atticFloorType'] != null
          ? AtticFloorType.values.firstWhere(
              (e) => e.name == data?['atticFloorType'],
            )
          : null,
      roofStructureType: data?['roofStructureType'] != null
          ? RoofStructureType.values.firstWhere(
              (e) => e.name == data?['roofStructureType'],
            )
          : null,
      ventilationSystem: data?['ventilationSystem'] as bool?,
      ventilationSystemAge: data?['ventilationSystemAge'] as String,
      waterRecuperator: data?['waterRecuperator'] as bool?,
      waterSupplyType: data?['waterSupplyType'] != null
          ? WaterSupplyType.values.firstWhere(
              (e) => e.name == data?['waterSupplyType'],
            )
          : null,
      waterSupplyOutdoorType: data?['waterSupplyOutdoorType'] != null
          ? WaterSupplyOutdoorType.values.firstWhere(
              (e) => e.name == data?['waterSupplyOutdoorType'],
            )
          : null,
      waterPressionType: data?['waterPressionType'] != null
          ? WaterPressionType.values.firstWhere(
              (e) => e.name == data?['waterPressionType'],
            )
          : null,
      electricityType: data?['electricityType'] != null
          ? ElectricityType.values.firstWhere(
              (e) => e.name == data?['electricityType'],
            )
          : null,
      periodsOfUnavailability: data?['periodsOfUnavailability'] as String,
      heatingSystem: data?['heatingSystem'] != null
          ? HeatingSystem.values.firstWhere(
              (e) => e.name == data?['heatingSystem'],
            )
          : null,
      zone: data?['zone'] != null
          ? Zone.values.firstWhere(
              (e) => e.name == data?['zone'],
            )
          : null,
      othersObservations: data?['othersObservations'] as String,
      drawingFileDataId: data?['drawingFileDataId'] as String?,
      createdAt: data?['createdAt']?.toDate() as DateTime?,
      updatedAt: data?['updatedAt']?.toDate() as DateTime?,
    );
  }

  @override
  SiteSheet copyWith({
    String? id,
    String? orderId,
    int? version,
    List<HouseType>? houseTypes,
    String? numberOfSections,
    bool? hasReturnInL,
    String? totalRoofArea,
    String? ageOfRoof,
    StateOfRoof? stateOfRoof,
    Vegetation? vegetation,
    String? existingGutter,
    String? existingGuttersColors,
    bool? gotVeranda,
    bool? gotPhotovoltaic,
    String? numberOfChimneys,
    bool? needToPaintChimneys,
    String? chimneysToPaintColor,
    String? numberOfDormers,
    String? numberOfVelux,
    String? typeOfRidge,
    StateOfRidge? stateOfRidge,
    bool? needForCementWork,
    String? gableHeight,
    String? heightUnderGutter,
    RoofPitch? roofPitch,
    String? checkingRecovery,
    bool? veluxToBeWaterproofed,
    bool? rigdeToBeWaterproofed,
    bool? claddingToBeWaterproofed,
    bool? edgesToBeWaterproofed,
    String? waterRepellentColor,
    String? modelsAndDimensions,
    List<CoverType>? coverTypes,
    String? numberOfSlatesOrTilesInAdvance,
    List<Exposure>? exposures,
    List<GutterType>? gutterTypes,
    String? otherMaterial,
    String? lengthInLinearMeters,
    String? downspoutLength,
    String? guttersColor,
    String? downspoutsColor,
    DownspoutType? downspoutType,
    String? leftAngleQuantity,
    String? rightAngleQuantity,
    String? numberOfGutterBottoms,
    String? numberOfGutterBirths,
    String? numberOfGutterBends,
    String? numberOfGutterSleevesOrDolphin,
    bool? withWaterRecuperator,
    bool? withLeafGuard,
    String? fasciaBoardLength,
    String? fasciaBoardAdvanceInCm,
    String? fasciaBoardColor,
    String? fasciaBoardReturn,
    String? facadeArea,
    String? facadeAge,
    String? typeOfExistingSupport,
    List<FacadeExistingSupportType>? facadeExistingSupportTypes,
    List<FacadePointing>? facadePointings,
    bool? isDampSupport,
    bool? isBlownCoating,
    FacadeTypeOfWork? facadeTypeOfWork,
    WaterRepellentType? waterRepellentType,
    String? numberOfWindows,
    String? cracks,
    String? microCracks,
    String? facadeColor,
    String? baseColor,
    String? windowSurroundingColor,
    String? externalVentilationGrilles,
    List<SurroundingWindowsType>? surroundingWindowsTypes,
    WoodTreatmentType? woodTreatmentType,
    String? woodTreatmentArea,
    InsulationAccessType? insulationAccessType,
    List<Insulator>? insulators,
    String? insulationArea,
    String? mineralWoolType,
    InsulationTypeOfInstallation? insulationTypeOfInstallation,
    ExistingInsulationType? existingInsulationType,
    String? existingInsulationAge,
    bool? removalOfExistingInsulation,
    AtticFloorType? atticFloorType,
    RoofStructureType? roofStructureType,
    bool? ventilationSystem,
    String? ventilationSystemAge,
    bool? waterRecuperator,
    WaterSupplyType? waterSupplyType,
    WaterSupplyOutdoorType? waterSupplyOutdoorType,
    WaterPressionType? waterPressionType,
    ElectricityType? electricityType,
    String? periodsOfUnavailability,
    HeatingSystem? heatingSystem,
    Zone? zone,
    String? othersObservations,
    String? drawingFileDataId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SiteSheet(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      version: version ?? this.version,
      houseTypes: houseTypes ?? this.houseTypes,
      numberOfSections: numberOfSections ?? this.numberOfSections,
      hasReturnInL: hasReturnInL ?? this.hasReturnInL,
      totalRoofArea: totalRoofArea ?? this.totalRoofArea,
      ageOfRoof: ageOfRoof ?? this.ageOfRoof,
      stateOfRoof: stateOfRoof ?? this.stateOfRoof,
      vegetation: vegetation ?? this.vegetation,
      existingGutter: existingGutter ?? this.existingGutter,
      existingGuttersColors:
          existingGuttersColors ?? this.existingGuttersColors,
      gotVeranda: gotVeranda ?? this.gotVeranda,
      gotPhotovoltaic: gotPhotovoltaic ?? this.gotPhotovoltaic,
      numberOfChimneys: numberOfChimneys ?? this.numberOfChimneys,
      needToPaintChimneys: needToPaintChimneys ?? this.needToPaintChimneys,
      chimneysToPaintColor: chimneysToPaintColor ?? this.chimneysToPaintColor,
      numberOfDormers: numberOfDormers ?? this.numberOfDormers,
      numberOfVelux: numberOfVelux ?? this.numberOfVelux,
      typeOfRidge: typeOfRidge ?? this.typeOfRidge,
      stateOfRidge: stateOfRidge ?? this.stateOfRidge,
      needForCementWork: needForCementWork ?? this.needForCementWork,
      gableHeight: gableHeight ?? this.gableHeight,
      heightUnderGutter: heightUnderGutter ?? this.heightUnderGutter,
      roofPitch: roofPitch ?? this.roofPitch,
      checkingRecovery: checkingRecovery ?? this.checkingRecovery,
      veluxToBeWaterproofed:
          veluxToBeWaterproofed ?? this.veluxToBeWaterproofed,
      rigdeToBeWaterproofed:
          rigdeToBeWaterproofed ?? this.rigdeToBeWaterproofed,
      claddingToBeWaterproofed:
          claddingToBeWaterproofed ?? this.claddingToBeWaterproofed,
      edgesToBeWaterproofed:
          edgesToBeWaterproofed ?? this.edgesToBeWaterproofed,
      waterRepellentColor: waterRepellentColor ?? this.waterRepellentColor,
      modelsAndDimensions: modelsAndDimensions ?? this.modelsAndDimensions,
      coverTypes: coverTypes ?? this.coverTypes,
      numberOfSlatesOrTilesInAdvance:
          numberOfSlatesOrTilesInAdvance ?? this.numberOfSlatesOrTilesInAdvance,
      exposures: exposures ?? this.exposures,
      gutterTypes: gutterTypes ?? this.gutterTypes,
      otherMaterial: otherMaterial ?? this.otherMaterial,
      lengthInLinearMeters: lengthInLinearMeters ?? this.lengthInLinearMeters,
      downspoutLength: downspoutLength ?? this.downspoutLength,
      guttersColor: guttersColor ?? this.guttersColor,
      downspoutsColor: downspoutsColor ?? this.downspoutsColor,
      downspoutType: downspoutType ?? this.downspoutType,
      leftAngleQuantity: leftAngleQuantity ?? this.leftAngleQuantity,
      rightAngleQuantity: rightAngleQuantity ?? this.rightAngleQuantity,
      numberOfGutterBottoms:
          numberOfGutterBottoms ?? this.numberOfGutterBottoms,
      numberOfGutterBirths: numberOfGutterBirths ?? this.numberOfGutterBirths,
      numberOfGutterBends: numberOfGutterBends ?? this.numberOfGutterBends,
      numberOfGutterSleevesOrDolphin:
          numberOfGutterSleevesOrDolphin ?? this.numberOfGutterSleevesOrDolphin,
      withWaterRecuperator: withWaterRecuperator ?? this.withWaterRecuperator,
      withLeafGuard: withLeafGuard ?? this.withLeafGuard,
      fasciaBoardLength: fasciaBoardLength ?? this.fasciaBoardLength,
      fasciaBoardAdvanceInCm:
          fasciaBoardAdvanceInCm ?? this.fasciaBoardAdvanceInCm,
      fasciaBoardColor: fasciaBoardColor ?? this.fasciaBoardColor,
      fasciaBoardReturn: fasciaBoardReturn ?? this.fasciaBoardReturn,
      facadeArea: facadeArea ?? this.facadeArea,
      facadeAge: facadeAge ?? this.facadeAge,
      typeOfExistingSupport:
          typeOfExistingSupport ?? this.typeOfExistingSupport,
      facadeExistingSupportTypes:
          facadeExistingSupportTypes ?? this.facadeExistingSupportTypes,
      facadePointings: facadePointings ?? this.facadePointings,
      isDampSupport: isDampSupport ?? this.isDampSupport,
      isBlownCoating: isBlownCoating ?? this.isBlownCoating,
      facadeTypeOfWork: facadeTypeOfWork ?? this.facadeTypeOfWork,
      waterRepellentType: waterRepellentType ?? this.waterRepellentType,
      numberOfWindows: numberOfWindows ?? this.numberOfWindows,
      cracks: cracks ?? this.cracks,
      microCracks: microCracks ?? this.microCracks,
      facadeColor: facadeColor ?? this.facadeColor,
      baseColor: baseColor ?? this.baseColor,
      windowSurroundingColor:
          windowSurroundingColor ?? this.windowSurroundingColor,
      externalVentilationGrilles:
          externalVentilationGrilles ?? this.externalVentilationGrilles,
      surroundingWindowsTypes:
          surroundingWindowsTypes ?? this.surroundingWindowsTypes,
      woodTreatmentType: woodTreatmentType ?? this.woodTreatmentType,
      woodTreatmentArea: woodTreatmentArea ?? this.woodTreatmentArea,
      insulationAccessType: insulationAccessType ?? this.insulationAccessType,
      insulators: insulators ?? this.insulators,
      insulationArea: insulationArea ?? this.insulationArea,
      mineralWoolType: mineralWoolType ?? this.mineralWoolType,
      insulationTypeOfInstallation:
          insulationTypeOfInstallation ?? this.insulationTypeOfInstallation,
      existingInsulationType:
          existingInsulationType ?? this.existingInsulationType,
      existingInsulationAge:
          existingInsulationAge ?? this.existingInsulationAge,
      removalOfExistingInsulation:
          removalOfExistingInsulation ?? this.removalOfExistingInsulation,
      atticFloorType: atticFloorType ?? this.atticFloorType,
      roofStructureType: roofStructureType ?? this.roofStructureType,
      ventilationSystem: ventilationSystem ?? this.ventilationSystem,
      ventilationSystemAge: ventilationSystemAge ?? this.ventilationSystemAge,
      waterRecuperator: waterRecuperator ?? this.waterRecuperator,
      waterSupplyType: waterSupplyType ?? this.waterSupplyType,
      waterSupplyOutdoorType:
          waterSupplyOutdoorType ?? this.waterSupplyOutdoorType,
      waterPressionType: waterPressionType ?? this.waterPressionType,
      electricityType: electricityType ?? this.electricityType,
      periodsOfUnavailability:
          periodsOfUnavailability ?? this.periodsOfUnavailability,
      heatingSystem: heatingSystem ?? this.heatingSystem,
      zone: zone ?? this.zone,
      othersObservations: othersObservations ?? this.othersObservations,
      drawingFileDataId: drawingFileDataId ?? this.drawingFileDataId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'orderId': orderId,
      'version': version,
      'houseTypes': houseTypes.map((e) => e.name).toList(),
      'numberOfSections': numberOfSections,
      'hasReturnInL': hasReturnInL,
      'totalRoofArea': totalRoofArea,
      'ageOfRoof': ageOfRoof,
      'stateOfRoof': stateOfRoof?.name,
      'vegetation': vegetation?.name,
      'existingGutter': existingGutter,
      'existingGuttersColors': existingGuttersColors,
      'gotVeranda': gotVeranda,
      'gotPhotovoltaic': gotPhotovoltaic,
      'numberOfChimneys': numberOfChimneys,
      'needToPaintChimneys': needToPaintChimneys,
      'chimneysToPaintColor': chimneysToPaintColor,
      'numberOfDormers': numberOfDormers,
      'numberOfVelux': numberOfVelux,
      'typeOfRidge': typeOfRidge,
      'stateOfRidge': stateOfRidge?.name,
      'needForCementWork': needForCementWork,
      'gableHeight': gableHeight,
      'heightUnderGutter': heightUnderGutter,
      'roofPitch': roofPitch?.name,
      'checkingRecovery': checkingRecovery,
      'veluxToBeWaterproofed': veluxToBeWaterproofed,
      'rigdeToBeWaterproofed': rigdeToBeWaterproofed,
      'claddingToBeWaterproofed': claddingToBeWaterproofed,
      'edgesToBeWaterproofed': edgesToBeWaterproofed,
      'waterRepellentColor': waterRepellentColor,
      'modelsAndDimensions': modelsAndDimensions,
      'coverTypes': coverTypes.map((e) => e.name).toList(),
      'numberOfSlatesOrTilesInAdvance': numberOfSlatesOrTilesInAdvance,
      'exposures': exposures.map((e) => e.name).toList(),
      'gutterTypes': gutterTypes.map((e) => e.name).toList(),
      'otherMaterial': otherMaterial,
      'lengthInLinearMeters': lengthInLinearMeters,
      'downspoutLength': downspoutLength,
      'guttersColor': guttersColor,
      'downspoutsColor': downspoutsColor,
      'downspoutType': downspoutType?.name,
      'leftAngleQuantity': leftAngleQuantity,
      'rightAngleQuantity': rightAngleQuantity,
      'numberOfGutterBottoms': numberOfGutterBottoms,
      'numberOfGutterBirths': numberOfGutterBirths,
      'numberOfGutterBends': numberOfGutterBends,
      'numberOfGutterSleevesOrDolphin': numberOfGutterSleevesOrDolphin,
      'withWaterRecuperator': withWaterRecuperator,
      'withLeafGuard': withLeafGuard,
      'fasciaBoardLength': fasciaBoardLength,
      'fasciaBoardAdvanceInCm': fasciaBoardAdvanceInCm,
      'fasciaBoardColor': fasciaBoardColor,
      'fasciaBoardReturn': fasciaBoardReturn,
      'facadeArea': facadeArea,
      'facadeAge': facadeAge,
      'typeOfExistingSupport': typeOfExistingSupport,
      'facadeExistingSupportTypes':
          facadeExistingSupportTypes.map((e) => e.name).toList(),
      'facadePointings': facadePointings.map((e) => e.name).toList(),
      'isDampSupport': isDampSupport,
      'isBlownCoating': isBlownCoating,
      'facadeTypeOfWork': facadeTypeOfWork?.name,
      'waterRepellentType': waterRepellentType?.name,
      'numberOfWindows': numberOfWindows,
      'cracks': cracks,
      'microCracks': microCracks,
      'facadeColor': facadeColor,
      'baseColor': baseColor,
      'windowSurroundingColor': windowSurroundingColor,
      'externalVentilationGrilles': externalVentilationGrilles,
      'surroundingWindowsTypes':
          surroundingWindowsTypes.map((e) => e.name).toList(),
      'woodTreatmentType': woodTreatmentType?.name,
      'woodTreatmentArea': woodTreatmentArea,
      'insulationAccessType': insulationAccessType?.name,
      'insulators': insulators.map((e) => e.name).toList(),
      'insulationArea': insulationArea,
      'mineralWoolType': mineralWoolType,
      'insulationTypeOfInstallation': insulationTypeOfInstallation?.name,
      'existingInsulationType': existingInsulationType !=
              ExistingInsulationType.blowInInsulation
          ? existingInsulationType?.name
          : null, // TODO: remove this line when all existingInsulationType are migrated to v2
      'existingInsulationType_v2': existingInsulationType?.name,
      'existingInsulationAge': existingInsulationAge,
      'removalOfExistingInsulation': removalOfExistingInsulation,
      'atticFloorType': atticFloorType?.name,
      'roofStructureType': roofStructureType?.name,
      'ventilationSystem': ventilationSystem,
      'ventilationSystemAge': ventilationSystemAge,
      'waterRecuperator': waterRecuperator,
      'waterSupplyType': waterSupplyType?.name,
      'waterSupplyOutdoorType': waterSupplyOutdoorType?.name,
      'waterPressionType': waterPressionType?.name,
      'electricityType': electricityType?.name,
      'periodsOfUnavailability': periodsOfUnavailability,
      'heatingSystem': heatingSystem?.name,
      'zone': zone?.name,
      'othersObservations': othersObservations,
      'drawingFileDataId': drawingFileDataId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  Future<void> loadData({
    bool eager = false,
    List<Type> flow = const [],
  }) async {
    await Future.wait([
      _loadOrder(eager: eager, flow: flow),
      _loadDrawingFileData(),
    ]);
  }

  Future<void> _loadOrder({
    bool eager = false,
    List<Type> flow = const [],
  }) async {
    // check flow
    flow = List.from(flow);
    if (!flow.contains(SiteSheet)) {
      flow.add(SiteSheet);
    } else {
      return;
    }
    order = await getIt<OrderServiceInterface>().getById(
      orderId,
      eager: eager,
      flow: flow,
    );
  }

  Future<void> _loadDrawingFileData() async {
    if (drawingFileDataId == null) {
      return;
    }
    drawingFileData =
        await getIt<FileDataServiceInterface>().getById(drawingFileDataId!);
  }

  @override
  bool identicalTo(AbstractBaseModel other) {
    if (identical(this, other)) return true;

    return other is SiteSheet &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.orderId == orderId &&
        other.version == version &&
        other.houseTypes.equals(houseTypes) &&
        other.numberOfSections == numberOfSections &&
        other.hasReturnInL == hasReturnInL &&
        other.totalRoofArea == totalRoofArea &&
        other.ageOfRoof == ageOfRoof &&
        other.stateOfRoof == stateOfRoof &&
        other.vegetation == vegetation &&
        other.roofPitch == roofPitch &&
        other.checkingRecovery == checkingRecovery &&
        other.existingGutter == existingGutter &&
        other.existingGuttersColors == existingGuttersColors &&
        other.gableHeight == gableHeight &&
        other.heightUnderGutter == heightUnderGutter &&
        other.gotVeranda == gotVeranda &&
        other.gotPhotovoltaic == gotPhotovoltaic &&
        other.numberOfChimneys == numberOfChimneys &&
        other.needToPaintChimneys == needToPaintChimneys &&
        other.chimneysToPaintColor == chimneysToPaintColor &&
        other.numberOfDormers == numberOfDormers &&
        other.numberOfVelux == numberOfVelux &&
        other.typeOfRidge == typeOfRidge &&
        other.stateOfRidge == stateOfRidge &&
        other.needForCementWork == needForCementWork &&
        other.veluxToBeWaterproofed == veluxToBeWaterproofed &&
        other.rigdeToBeWaterproofed == rigdeToBeWaterproofed &&
        other.claddingToBeWaterproofed == claddingToBeWaterproofed &&
        other.edgesToBeWaterproofed == edgesToBeWaterproofed &&
        other.waterRepellentColor == waterRepellentColor &&
        other.modelsAndDimensions == modelsAndDimensions &&
        other.coverTypes.equals(coverTypes) &&
        other.numberOfSlatesOrTilesInAdvance ==
            numberOfSlatesOrTilesInAdvance &&
        other.exposures.equals(exposures) &&
        other.gutterTypes.equals(gutterTypes) &&
        other.otherMaterial == otherMaterial &&
        other.lengthInLinearMeters == lengthInLinearMeters &&
        other.downspoutLength == downspoutLength &&
        other.guttersColor == guttersColor &&
        other.downspoutsColor == downspoutsColor &&
        other.downspoutType == downspoutType &&
        other.leftAngleQuantity == leftAngleQuantity &&
        other.rightAngleQuantity == rightAngleQuantity &&
        other.numberOfGutterBottoms == numberOfGutterBottoms &&
        other.numberOfGutterBirths == numberOfGutterBirths &&
        other.numberOfGutterBends == numberOfGutterBends &&
        other.numberOfGutterSleevesOrDolphin ==
            numberOfGutterSleevesOrDolphin &&
        other.withWaterRecuperator == withWaterRecuperator &&
        other.withLeafGuard == withLeafGuard &&
        other.fasciaBoardLength == fasciaBoardLength &&
        other.fasciaBoardAdvanceInCm == fasciaBoardAdvanceInCm &&
        other.fasciaBoardColor == fasciaBoardColor &&
        other.fasciaBoardReturn == fasciaBoardReturn &&
        other.facadeArea == facadeArea &&
        other.facadeAge == facadeAge &&
        other.typeOfExistingSupport == typeOfExistingSupport &&
        other.facadeExistingSupportTypes.equals(facadeExistingSupportTypes) &&
        other.facadePointings.equals(facadePointings) &&
        other.isDampSupport == isDampSupport &&
        other.isBlownCoating == isBlownCoating &&
        other.facadeTypeOfWork == facadeTypeOfWork &&
        other.waterRepellentType == waterRepellentType &&
        other.numberOfWindows == numberOfWindows &&
        other.cracks == cracks &&
        other.microCracks == microCracks &&
        other.facadeColor == facadeColor &&
        other.baseColor == baseColor &&
        other.windowSurroundingColor == windowSurroundingColor &&
        other.externalVentilationGrilles == externalVentilationGrilles &&
        other.surroundingWindowsTypes.equals(surroundingWindowsTypes) &&
        other.woodTreatmentType == woodTreatmentType &&
        other.woodTreatmentArea == woodTreatmentArea &&
        other.insulationAccessType == insulationAccessType &&
        other.insulators.equals(insulators) &&
        other.insulationArea == insulationArea &&
        other.mineralWoolType == mineralWoolType &&
        other.insulationTypeOfInstallation == insulationTypeOfInstallation &&
        other.existingInsulationType == existingInsulationType &&
        other.existingInsulationAge == existingInsulationAge &&
        other.removalOfExistingInsulation == removalOfExistingInsulation &&
        other.atticFloorType == atticFloorType &&
        other.roofStructureType == roofStructureType &&
        other.ventilationSystem == ventilationSystem &&
        other.ventilationSystemAge == ventilationSystemAge &&
        other.waterRecuperator == waterRecuperator &&
        other.waterSupplyType == waterSupplyType &&
        other.waterSupplyOutdoorType == waterSupplyOutdoorType &&
        other.waterPressionType == waterPressionType &&
        other.electricityType == electricityType &&
        other.periodsOfUnavailability == periodsOfUnavailability &&
        other.heatingSystem == heatingSystem &&
        other.zone == zone &&
        other.othersObservations == othersObservations &&
        other.drawingFileDataId == drawingFileDataId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
}
