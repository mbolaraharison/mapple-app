import 'package:easy_localization/easy_localization.dart';
import 'package:maple_common/maple_common.dart';

enum HouseType {
  // Values
  groundFloor,
  multiFloor,
  semiDetached,
  gotPowerLines,
  needDICT;

  // Getters
  String get label => 'site_sheet.house_type.$name'.tr();

  // Static
  static HouseType fromValue(String value) {
    return HouseType.values.firstWhere((e) => e.name == value);
  }

  static List<HouseType> fromValues(List<String> values) {
    return values.map((e) => fromValue(e)).toList();
  }

  static List<SelectChoice<String>> get choices => HouseType.values
      .map((e) => SelectChoice(value: e.name, label: e.label))
      .toList();
}

enum StateOfRoof {
  // Values
  good,
  dirty,
  veryDirty,
  existingPaint;

  // Getters
  String get label => 'site_sheet.state_of_roof.$name'.tr();

  // Static
  static StateOfRoof fromValue(String value) {
    return StateOfRoof.values.firstWhere((e) => e.name == value);
  }

  static List<SelectChoice<StateOfRoof>> get choices => StateOfRoof.values
      .map((e) => SelectChoice(value: e, label: e.label))
      .toList();
}

enum Vegetation {
  normal,
  important;

  // Getters
  String get label => 'site_sheet.vegetation.$name'.tr();

  // Static
  static Vegetation fromValue(String value) {
    return Vegetation.values.firstWhere((e) => e.name == value);
  }

  static List<SelectChoice<Vegetation>> get choices => Vegetation.values
      .map((e) => SelectChoice(value: e, label: e.label))
      .toList();
}

enum StateOfRidge {
  good,
  medium,
  bad;

  // Getters
  String get label => 'site_sheet.state_of_ridge.$name'.tr();

  // Static
  static StateOfRidge fromValue(String value) {
    return StateOfRidge.values.firstWhere((e) => e.name == value);
  }

  static List<SelectChoice<StateOfRidge>> get choices => StateOfRidge.values
      .map((e) => SelectChoice(value: e, label: e.label))
      .toList();
}

enum RoofPitch {
  thirtyDegrees,
  fortyFiveDegrees,
  seventyDegrees;

  // Getters
  String get label => 'site_sheet.roof_pitch.$name'.tr();

  // Static
  static RoofPitch fromValue(String value) {
    return RoofPitch.values.firstWhere((e) => e.name == value);
  }

  static List<SelectChoice<RoofPitch>> get choices => RoofPitch.values
      .map((e) => SelectChoice(value: e, label: e.label))
      .toList();
}

enum CoverType {
  fiberCementSlates,
  asbestos,
  naturalSlates,
  cementTiles,
  concreteTiles,
  terracottaTiles,
  countryTiles;

  // Getters
  String get label => 'site_sheet.cover_type.$name'.tr();

  // Static
  static CoverType fromValue(String value) {
    return CoverType.values.firstWhere((e) => e.name == value);
  }

  static List<CoverType> fromValues(List<String> values) {
    return values.map((e) => fromValue(e)).toList();
  }

  static List<SelectChoice<String>> get choices => CoverType.values
      .map((e) => SelectChoice(value: e.name, label: e.label))
      .toList();
}

enum Exposure {
  south,
  north,
  east,
  west;

  // Getters
  String get label => 'site_sheet.exposure.$name'.tr();

  // Static
  static Exposure fromValue(String value) {
    return Exposure.values.firstWhere((e) => e.name == value);
  }

  static List<Exposure> fromValues(List<String> values) {
    return values.map((e) => fromValue(e)).toList();
  }

  static List<SelectChoice<String>> get choices => Exposure.values
      .map((e) => SelectChoice(value: e.name, label: e.label))
      .toList();
}

enum GutterType {
  pvc,
  zinc,
  havraise,
  alu,
  other;

  // Getters
  String get label => 'site_sheet.gutter_type.$name'.tr();

  // Static
  static GutterType fromValue(String value) {
    return GutterType.values.firstWhere((e) => e.name == value);
  }

  static List<GutterType> fromValues(List<String> values) {
    return values.map((e) => fromValue(e)).toList();
  }

  static List<SelectChoice<String>> get choices => GutterType.values
      .map((e) => SelectChoice(value: e.name, label: e.label))
      .toList();
}

enum DownspoutType {
  square,
  round;

  // Getters
  String get label => 'site_sheet.downspout_type.$name'.tr();

  // Static
  static DownspoutType fromValue(String value) {
    return DownspoutType.values.firstWhere((e) => e.name == value);
  }

  static List<SelectChoice<DownspoutType>> get choices => DownspoutType.values
      .map((e) => SelectChoice(value: e, label: e.label))
      .toList();
}

enum FacadeExistingSupportType {
  coating,
  paint,
  stone,
  eti,
  brick;

  // Getters
  String get label => 'site_sheet.facade_existing_support_type.$name'.tr();

  // Static
  static FacadeExistingSupportType fromValue(String value) {
    return FacadeExistingSupportType.values.firstWhere((e) => e.name == value);
  }

  static List<FacadeExistingSupportType> fromValues(List<String> values) {
    return values.map((e) => fromValue(e)).toList();
  }

  static List<SelectChoice<String>> get choices =>
      FacadeExistingSupportType.values
          .map((e) => SelectChoice(value: e.name, label: e.label))
          .toList();
}

enum FacadePointing {
  cement,
  facade,
  brick;

  // Getters
  String get label => 'site_sheet.facade_pointing.$name'.tr();

  // Static
  static FacadePointing fromValue(String value) {
    return FacadePointing.values.firstWhere((e) => e.name == value);
  }

  static List<FacadePointing> fromValues(List<String> values) {
    return values.map((e) => fromValue(e)).toList();
  }

  static List<SelectChoice<String>> get choices => FacadePointing.values
      .map((e) => SelectChoice(value: e.name, label: e.label))
      .toList();
}

enum FacadeTypeOfWork {
  facadeRenovationWithElementProtection,
  coating;

  // Getters
  String get label => 'site_sheet.facade_type_of_work.$name'.tr();

  // Static
  static FacadeTypeOfWork fromValue(String value) {
    return FacadeTypeOfWork.values.firstWhere((e) => e.name == value);
  }

  static List<SelectChoice<FacadeTypeOfWork>> get choices =>
      FacadeTypeOfWork.values
          .map((e) => SelectChoice(value: e, label: e.label))
          .toList();
}

enum WaterRepellentType {
  colored,
  colorless;

  // Getters
  String get label => 'site_sheet.water_repellent_type.$name'.tr();

  // Static
  static WaterRepellentType fromValue(String value) {
    return WaterRepellentType.values.firstWhere((e) => e.name == value);
  }

  static List<SelectChoice<WaterRepellentType>> get choices =>
      WaterRepellentType.values
          .map((e) => SelectChoice(value: e, label: e.label))
          .toList();
}

enum SurroundingWindowsType {
  alu,
  metal,
  coating;

  // Getters
  String get label => 'site_sheet.surrounding_windows_type.$name'.tr();

  // Static
  static SurroundingWindowsType fromValue(String value) {
    return SurroundingWindowsType.values.firstWhere((e) => e.name == value);
  }

  static List<SurroundingWindowsType> fromValues(List<String> values) {
    return values.map((e) => fromValue(e)).toList();
  }

  static List<SelectChoice<String>> get choices => SurroundingWindowsType.values
      .map((e) => SelectChoice(value: e.name, label: e.label))
      .toList();
}

enum WoodTreatmentType {
  preventive,
  curative;

  // Getters
  String get label => 'site_sheet.wood_treatment_type.$name'.tr();

  // Static
  static WoodTreatmentType fromValue(String value) {
    return WoodTreatmentType.values.firstWhere((e) => e.name == value);
  }

  static List<SelectChoice<WoodTreatmentType>> get choices =>
      WoodTreatmentType.values
          .map((e) => SelectChoice(value: e, label: e.label))
          .toList();
}

enum InsulationAccessType {
  stairs,
  hatch;

  // Getters
  String get label => 'site_sheet.insulation_access_type.$name'.tr();

  // Static
  static InsulationAccessType fromValue(String value) {
    return InsulationAccessType.values.firstWhere((e) => e.name == value);
  }

  static List<SelectChoice<InsulationAccessType>> get choices =>
      InsulationAccessType.values
          .map((e) => SelectChoice(value: e, label: e.label))
          .toList();
}

enum Insulator {
  r6,
  r7,
  technisopro,
  mineralWool,
  stoneWoolPlate,
  polystyrenePlate;

  // Getters
  String get label => 'site_sheet.insulator.$name'.tr();

  // Static
  static Insulator fromValue(String value) {
    return Insulator.values.firstWhere((e) => e.name == value);
  }

  static List<Insulator> fromValues(List<String> values) {
    return values.map((e) => fromValue(e)).toList();
  }

  static List<SelectChoice<String>> get choices => Insulator.values
      .map((e) => SelectChoice(value: e.name, label: e.label))
      .toList();
}

enum InsulationTypeOfInstallation {
  blowing,
  uncovering,
  underlayment,
  eti;

  // Getters
  String get label => 'site_sheet.insulation_type_of_installation.$name'.tr();

  // Static
  static InsulationTypeOfInstallation fromValue(String value) {
    return InsulationTypeOfInstallation.values
        .firstWhere((e) => e.name == value);
  }

  static List<SelectChoice<InsulationTypeOfInstallation>> get choices =>
      InsulationTypeOfInstallation.values
          .map((e) => SelectChoice(value: e, label: e.label))
          .toList();
}

enum ExistingInsulationType {
  uninsulated,
  polystyrene,
  glassWool,
  thinInsulator,
  blowInInsulation;

  // Getters
  String get label => 'site_sheet.existing_insulation_type.$name'.tr();

  // Static
  static ExistingInsulationType fromValue(String value) {
    return ExistingInsulationType.values.firstWhere((e) => e.name == value);
  }

  static List<SelectChoice<ExistingInsulationType>> get choices =>
      ExistingInsulationType.values
          .map((e) => SelectChoice(value: e, label: e.label))
          .toList();
}

enum AtticFloorType {
  bricks,
  concrete,
  joists;

  // Getters
  String get label => 'site_sheet.attic_floor_type.$name'.tr();

  // Static
  static AtticFloorType fromValue(String value) {
    return AtticFloorType.values.firstWhere((e) => e.name == value);
  }

  static List<SelectChoice<AtticFloorType>> get choices => AtticFloorType.values
      .map((e) => SelectChoice(value: e, label: e.label))
      .toList();
}

enum RoofStructureType {
  metal,
  truss,
  traditional;

  // Getters
  String get label => 'site_sheet.roof_structure_type.$name'.tr();

  // Static
  static RoofStructureType fromValue(String value) {
    return RoofStructureType.values.firstWhere((e) => e.name == value);
  }

  static List<SelectChoice<RoofStructureType>> get choices =>
      RoofStructureType.values
          .map((e) => SelectChoice(value: e, label: e.label))
          .toList();
}

enum WaterSupplyType {
  indoor,
  outdoor,
  garage;

  // Getters
  String get label => 'site_sheet.water_supply_type.$name'.tr();

  // Static
  static WaterSupplyType fromValue(String value) {
    return WaterSupplyType.values.firstWhere((e) => e.name == value);
  }

  static List<SelectChoice<WaterSupplyType>> get choices =>
      WaterSupplyType.values
          .map((e) => SelectChoice(value: e, label: e.label))
          .toList();
}

enum WaterSupplyOutdoorType {
  front,
  back;

  // Getters
  String get label => 'site_sheet.water_supply_outdoor_type.$name'.tr();

  // Static
  static WaterSupplyOutdoorType fromValue(String value) {
    return WaterSupplyOutdoorType.values.firstWhere((e) => e.name == value);
  }

  static List<SelectChoice<WaterSupplyOutdoorType>> get choices =>
      WaterSupplyOutdoorType.values
          .map((e) => SelectChoice(value: e, label: e.label))
          .toList();
}

enum WaterPressionType {
  normal,
  low,
  needPump;

  // Getters
  String get label => 'site_sheet.water_pression_type.$name'.tr();

  // Static
  static WaterPressionType fromValue(String value) {
    return WaterPressionType.values.firstWhere((e) => e.name == value);
  }

  static List<SelectChoice<WaterPressionType>> get choices =>
      WaterPressionType.values
          .map((e) => SelectChoice(value: e, label: e.label))
          .toList();
}

enum ElectricityType {
  indoor,
  outdoor;

  // Getters
  String get label => 'site_sheet.electricity_type.$name'.tr();

  // Static
  static ElectricityType fromValue(String value) {
    return ElectricityType.values.firstWhere((e) => e.name == value);
  }

  static List<SelectChoice<ElectricityType>> get choices =>
      ElectricityType.values
          .map((e) => SelectChoice(value: e, label: e.label))
          .toList();
}

enum HeatingSystem {
  fuel,
  electric;

  // Getters
  String get label => 'site_sheet.heating_system.$name'.tr();

  // Static
  static HeatingSystem fromValue(String value) {
    return HeatingSystem.values.firstWhere((e) => e.name == value);
  }

  static List<SelectChoice<HeatingSystem>> get choices => HeatingSystem.values
      .map((e) => SelectChoice(value: e, label: e.label))
      .toList();
}

enum Zone {
  h1,
  h2,
  h3;

  // Getters
  String get label => 'site_sheet.zone.$name'.tr();

  // Static
  static Zone fromValue(String value) {
    return Zone.values.firstWhere((e) => e.name == value);
  }

  static List<SelectChoice<Zone>> get choices =>
      Zone.values.map((e) => SelectChoice(value: e, label: e.label)).toList();
}
