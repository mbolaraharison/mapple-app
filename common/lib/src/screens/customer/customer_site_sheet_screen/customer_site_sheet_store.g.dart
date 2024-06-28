// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_site_sheet_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CustomerSiteSheetStore on _CustomerSiteSheetStoreBase, Store {
  Computed<Map<CustomerSiteSheetScreenTab, bool>>? _$completedTabsComputed;

  @override
  Map<CustomerSiteSheetScreenTab, bool> get completedTabs =>
      (_$completedTabsComputed ??=
              Computed<Map<CustomerSiteSheetScreenTab, bool>>(
                  () => super.completedTabs,
                  name: '_CustomerSiteSheetStoreBase.completedTabs'))
          .value;
  Computed<bool>? _$isCompletedComputed;

  @override
  bool get isCompleted =>
      (_$isCompletedComputed ??= Computed<bool>(() => super.isCompleted,
              name: '_CustomerSiteSheetStoreBase.isCompleted'))
          .value;

  late final _$siteSheetAtom =
      Atom(name: '_CustomerSiteSheetStoreBase.siteSheet', context: context);

  @override
  SiteSheet? get siteSheet {
    _$siteSheetAtom.reportRead();
    return super.siteSheet;
  }

  @override
  set siteSheet(SiteSheet? value) {
    _$siteSheetAtom.reportWrite(value, super.siteSheet, () {
      super.siteSheet = value;
    });
  }

  late final _$currentTabAtom =
      Atom(name: '_CustomerSiteSheetStoreBase.currentTab', context: context);

  @override
  CustomerSiteSheetScreenTab get currentTab {
    _$currentTabAtom.reportRead();
    return super.currentTab;
  }

  @override
  set currentTab(CustomerSiteSheetScreenTab value) {
    _$currentTabAtom.reportWrite(value, super.currentTab, () {
      super.currentTab = value;
    });
  }

  late final _$drawingAtom =
      Atom(name: '_CustomerSiteSheetStoreBase.drawing', context: context);

  @override
  Uint8List? get drawing {
    _$drawingAtom.reportRead();
    return super.drawing;
  }

  @override
  set drawing(Uint8List? value) {
    _$drawingAtom.reportWrite(value, super.drawing, () {
      super.drawing = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_CustomerSiteSheetStoreBase.init', context: context);

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$setDrawingAsyncAction =
      AsyncAction('_CustomerSiteSheetStoreBase.setDrawing', context: context);

  @override
  Future<void> setDrawing(Uint8List? image) {
    return _$setDrawingAsyncAction.run(() => super.setDrawing(image));
  }

  late final _$clearDrawingAsyncAction =
      AsyncAction('_CustomerSiteSheetStoreBase.clearDrawing', context: context);

  @override
  Future<void> clearDrawing() {
    return _$clearDrawingAsyncAction.run(() => super.clearDrawing());
  }

  late final _$_CustomerSiteSheetStoreBaseActionController =
      ActionController(name: '_CustomerSiteSheetStoreBase', context: context);

  @override
  void setCurrentTab(CustomerSiteSheetScreenTab tab) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setCurrentTab');
    try {
      return super.setCurrentTab(tab);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHouseTypes(List<String> values) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setHouseTypes');
    try {
      return super.setHouseTypes(values);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNumberOfSections(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setNumberOfSections');
    try {
      return super.setNumberOfSections(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHasReturnInL(bool value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setHasReturnInL');
    try {
      return super.setHasReturnInL(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTotalRoofArea(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setTotalRoofArea');
    try {
      return super.setTotalRoofArea(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAgeOfRoof(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setAgeOfRoof');
    try {
      return super.setAgeOfRoof(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStateOfRoof(StateOfRoof? value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setStateOfRoof');
    try {
      return super.setStateOfRoof(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setVegetation(Vegetation? value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setVegetation');
    try {
      return super.setVegetation(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRoofPitch(RoofPitch? value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setRoofPitch');
    try {
      return super.setRoofPitch(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCheckingRecovery(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setCheckingRecovery');
    try {
      return super.setCheckingRecovery(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setExistingGutters(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setExistingGutters');
    try {
      return super.setExistingGutters(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setExistingGuttersColors(String value) {
    final _$actionInfo =
        _$_CustomerSiteSheetStoreBaseActionController.startAction(
            name: '_CustomerSiteSheetStoreBase.setExistingGuttersColors');
    try {
      return super.setExistingGuttersColors(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGableHeight(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setGableHeight');
    try {
      return super.setGableHeight(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHeightUnderGutter(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setHeightUnderGutter');
    try {
      return super.setHeightUnderGutter(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGotVeranda(bool? value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setGotVeranda');
    try {
      return super.setGotVeranda(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGotPhotovoltaic(bool? value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setGotPhotovoltaic');
    try {
      return super.setGotPhotovoltaic(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNumberOfChimneys(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setNumberOfChimneys');
    try {
      return super.setNumberOfChimneys(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNeedToPaintChimneys(bool? value) {
    final _$actionInfo =
        _$_CustomerSiteSheetStoreBaseActionController.startAction(
            name: '_CustomerSiteSheetStoreBase.setNeedToPaintChimneys');
    try {
      return super.setNeedToPaintChimneys(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setChimneysToPaintColor(String value) {
    final _$actionInfo =
        _$_CustomerSiteSheetStoreBaseActionController.startAction(
            name: '_CustomerSiteSheetStoreBase.setChimneysToPaintColor');
    try {
      return super.setChimneysToPaintColor(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNumberOfDormers(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setNumberOfDormers');
    try {
      return super.setNumberOfDormers(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNumberOfVelux(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setNumberOfVelux');
    try {
      return super.setNumberOfVelux(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTypeOfRidge(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setTypeOfRidge');
    try {
      return super.setTypeOfRidge(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStateOfRidge(StateOfRidge? value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setStateOfRidge');
    try {
      return super.setStateOfRidge(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNeedForCementWork(bool? value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setNeedForCementWork');
    try {
      return super.setNeedForCementWork(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setVeluxToBeWaterproofed(bool? value) {
    final _$actionInfo =
        _$_CustomerSiteSheetStoreBaseActionController.startAction(
            name: '_CustomerSiteSheetStoreBase.setVeluxToBeWaterproofed');
    try {
      return super.setVeluxToBeWaterproofed(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRigdeToBeWaterproofed(bool? value) {
    final _$actionInfo =
        _$_CustomerSiteSheetStoreBaseActionController.startAction(
            name: '_CustomerSiteSheetStoreBase.setRigdeToBeWaterproofed');
    try {
      return super.setRigdeToBeWaterproofed(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCladdingToBeWaterproofed(bool? value) {
    final _$actionInfo =
        _$_CustomerSiteSheetStoreBaseActionController.startAction(
            name: '_CustomerSiteSheetStoreBase.setCladdingToBeWaterproofed');
    try {
      return super.setCladdingToBeWaterproofed(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEdgesToBeWaterproofed(bool? value) {
    final _$actionInfo =
        _$_CustomerSiteSheetStoreBaseActionController.startAction(
            name: '_CustomerSiteSheetStoreBase.setEdgesToBeWaterproofed');
    try {
      return super.setEdgesToBeWaterproofed(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWaterRepellentColor(String value) {
    final _$actionInfo =
        _$_CustomerSiteSheetStoreBaseActionController.startAction(
            name: '_CustomerSiteSheetStoreBase.setWaterRepellentColor');
    try {
      return super.setWaterRepellentColor(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setModelsAndDimensions(String value) {
    final _$actionInfo =
        _$_CustomerSiteSheetStoreBaseActionController.startAction(
            name: '_CustomerSiteSheetStoreBase.setModelsAndDimensions');
    try {
      return super.setModelsAndDimensions(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCoverTypes(List<String> values) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setCoverTypes');
    try {
      return super.setCoverTypes(values);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNumberOfSlatesOrTilesInAdvance(String value) {
    final _$actionInfo =
        _$_CustomerSiteSheetStoreBaseActionController.startAction(
            name:
                '_CustomerSiteSheetStoreBase.setNumberOfSlatesOrTilesInAdvance');
    try {
      return super.setNumberOfSlatesOrTilesInAdvance(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setExposures(List<String> values) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setExposures');
    try {
      return super.setExposures(values);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGutterTypes(List<String> values) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setGutterTypes');
    try {
      return super.setGutterTypes(values);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOtherMaterial(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setOtherMaterial');
    try {
      return super.setOtherMaterial(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLengthInLinearMeters(String value) {
    final _$actionInfo =
        _$_CustomerSiteSheetStoreBaseActionController.startAction(
            name: '_CustomerSiteSheetStoreBase.setLengthInLinearMeters');
    try {
      return super.setLengthInLinearMeters(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDownspoutLength(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setDownspoutLength');
    try {
      return super.setDownspoutLength(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGuttersColor(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setGuttersColor');
    try {
      return super.setGuttersColor(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDownspoutsColor(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setDownspoutsColor');
    try {
      return super.setDownspoutsColor(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDownspoutType(DownspoutType? value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setDownspoutType');
    try {
      return super.setDownspoutType(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLeftAngleQuantity(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setLeftAngleQuantity');
    try {
      return super.setLeftAngleQuantity(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRightAngleQuantity(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setRightAngleQuantity');
    try {
      return super.setRightAngleQuantity(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNumberOfGutterBottoms(String value) {
    final _$actionInfo =
        _$_CustomerSiteSheetStoreBaseActionController.startAction(
            name: '_CustomerSiteSheetStoreBase.setNumberOfGutterBottoms');
    try {
      return super.setNumberOfGutterBottoms(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNumberOfGutterBirths(String value) {
    final _$actionInfo =
        _$_CustomerSiteSheetStoreBaseActionController.startAction(
            name: '_CustomerSiteSheetStoreBase.setNumberOfGutterBirths');
    try {
      return super.setNumberOfGutterBirths(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNumberOfGutterBends(String value) {
    final _$actionInfo =
        _$_CustomerSiteSheetStoreBaseActionController.startAction(
            name: '_CustomerSiteSheetStoreBase.setNumberOfGutterBends');
    try {
      return super.setNumberOfGutterBends(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNumberOfGutterSleevesOrDolphin(String value) {
    final _$actionInfo =
        _$_CustomerSiteSheetStoreBaseActionController.startAction(
            name:
                '_CustomerSiteSheetStoreBase.setNumberOfGutterSleevesOrDolphin');
    try {
      return super.setNumberOfGutterSleevesOrDolphin(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWithWaterRecuperator(bool? value) {
    final _$actionInfo =
        _$_CustomerSiteSheetStoreBaseActionController.startAction(
            name: '_CustomerSiteSheetStoreBase.setWithWaterRecuperator');
    try {
      return super.setWithWaterRecuperator(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWithLeafGuard(bool? value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setWithLeafGuard');
    try {
      return super.setWithLeafGuard(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFasciaBoardLength(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setFasciaBoardLength');
    try {
      return super.setFasciaBoardLength(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFasciaBoardAdvanceInCm(String value) {
    final _$actionInfo =
        _$_CustomerSiteSheetStoreBaseActionController.startAction(
            name: '_CustomerSiteSheetStoreBase.setFasciaBoardAdvanceInCm');
    try {
      return super.setFasciaBoardAdvanceInCm(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFasciaBoardColor(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setFasciaBoardColor');
    try {
      return super.setFasciaBoardColor(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFasciaBoardReturn(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setFasciaBoardReturn');
    try {
      return super.setFasciaBoardReturn(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFacadeArea(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setFacadeArea');
    try {
      return super.setFacadeArea(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFacadeAge(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setFacadeAge');
    try {
      return super.setFacadeAge(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTypeOfExistingSupport(String value) {
    final _$actionInfo =
        _$_CustomerSiteSheetStoreBaseActionController.startAction(
            name: '_CustomerSiteSheetStoreBase.setTypeOfExistingSupport');
    try {
      return super.setTypeOfExistingSupport(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFacadeExistingSupportTypes(List<String> values) {
    final _$actionInfo =
        _$_CustomerSiteSheetStoreBaseActionController.startAction(
            name: '_CustomerSiteSheetStoreBase.setFacadeExistingSupportTypes');
    try {
      return super.setFacadeExistingSupportTypes(values);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFacadePointings(List<String> values) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setFacadePointings');
    try {
      return super.setFacadePointings(values);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsDampSupport(bool value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setIsDampSupport');
    try {
      return super.setIsDampSupport(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsBlownCoating(bool? value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setIsBlownCoating');
    try {
      return super.setIsBlownCoating(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFacadeTypeOfWork(FacadeTypeOfWork? value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setFacadeTypeOfWork');
    try {
      return super.setFacadeTypeOfWork(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWaterRepellentType(WaterRepellentType? value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setWaterRepellentType');
    try {
      return super.setWaterRepellentType(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNumberOfWindows(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setNumberOfWindows');
    try {
      return super.setNumberOfWindows(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCracks(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setCracks');
    try {
      return super.setCracks(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMicroCracks(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setMicroCracks');
    try {
      return super.setMicroCracks(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFacadeColor(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setFacadeColor');
    try {
      return super.setFacadeColor(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBaseColor(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setBaseColor');
    try {
      return super.setBaseColor(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWindowSurroundingColor(String value) {
    final _$actionInfo =
        _$_CustomerSiteSheetStoreBaseActionController.startAction(
            name: '_CustomerSiteSheetStoreBase.setWindowSurroundingColor');
    try {
      return super.setWindowSurroundingColor(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setExternalVentilationGrilles(String value) {
    final _$actionInfo =
        _$_CustomerSiteSheetStoreBaseActionController.startAction(
            name: '_CustomerSiteSheetStoreBase.setExternalVentilationGrilles');
    try {
      return super.setExternalVentilationGrilles(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSurroundingWindowsTypes(List<String> values) {
    final _$actionInfo =
        _$_CustomerSiteSheetStoreBaseActionController.startAction(
            name: '_CustomerSiteSheetStoreBase.setSurroundingWindowsTypes');
    try {
      return super.setSurroundingWindowsTypes(values);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWoodTreatmentType(WoodTreatmentType? value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setWoodTreatmentType');
    try {
      return super.setWoodTreatmentType(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWoodTreatmentArea(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setWoodTreatmentArea');
    try {
      return super.setWoodTreatmentArea(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setInsulationAccessType(InsulationAccessType? value) {
    final _$actionInfo =
        _$_CustomerSiteSheetStoreBaseActionController.startAction(
            name: '_CustomerSiteSheetStoreBase.setInsulationAccessType');
    try {
      return super.setInsulationAccessType(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setInsulators(List<String> values) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setInsulators');
    try {
      return super.setInsulators(values);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setInsulationArea(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setInsulationArea');
    try {
      return super.setInsulationArea(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMineralWoolType(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setMineralWoolType');
    try {
      return super.setMineralWoolType(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setInsulationTypeOfInstallation(InsulationTypeOfInstallation? value) {
    final _$actionInfo =
        _$_CustomerSiteSheetStoreBaseActionController.startAction(
            name:
                '_CustomerSiteSheetStoreBase.setInsulationTypeOfInstallation');
    try {
      return super.setInsulationTypeOfInstallation(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setExistingInsulationType(ExistingInsulationType? value) {
    final _$actionInfo =
        _$_CustomerSiteSheetStoreBaseActionController.startAction(
            name: '_CustomerSiteSheetStoreBase.setExistingInsulationType');
    try {
      return super.setExistingInsulationType(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setExistingInsulationAge(String value) {
    final _$actionInfo =
        _$_CustomerSiteSheetStoreBaseActionController.startAction(
            name: '_CustomerSiteSheetStoreBase.setExistingInsulationAge');
    try {
      return super.setExistingInsulationAge(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRemovalOfExistingInsulation(bool? value) {
    final _$actionInfo =
        _$_CustomerSiteSheetStoreBaseActionController.startAction(
            name: '_CustomerSiteSheetStoreBase.setRemovalOfExistingInsulation');
    try {
      return super.setRemovalOfExistingInsulation(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAtticFloorType(AtticFloorType? value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setAtticFloorType');
    try {
      return super.setAtticFloorType(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRoofStructureType(RoofStructureType? value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setRoofStructureType');
    try {
      return super.setRoofStructureType(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setVentilationSystem(bool? value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setVentilationSystem');
    try {
      return super.setVentilationSystem(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setVentilationSystemAge(String value) {
    final _$actionInfo =
        _$_CustomerSiteSheetStoreBaseActionController.startAction(
            name: '_CustomerSiteSheetStoreBase.setVentilationSystemAge');
    try {
      return super.setVentilationSystemAge(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWaterRecuperator(bool? value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setWaterRecuperator');
    try {
      return super.setWaterRecuperator(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWaterSupplyType(WaterSupplyType? value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setWaterSupplyType');
    try {
      return super.setWaterSupplyType(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWaterSupplyOutdoorType(WaterSupplyOutdoorType? value) {
    final _$actionInfo =
        _$_CustomerSiteSheetStoreBaseActionController.startAction(
            name: '_CustomerSiteSheetStoreBase.setWaterSupplyOutdoorType');
    try {
      return super.setWaterSupplyOutdoorType(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWaterPressionType(WaterPressionType? value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setWaterPressionType');
    try {
      return super.setWaterPressionType(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setElectricityType(ElectricityType? value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setElectricityType');
    try {
      return super.setElectricityType(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPeriodsOfUnavailability(String value) {
    final _$actionInfo =
        _$_CustomerSiteSheetStoreBaseActionController.startAction(
            name: '_CustomerSiteSheetStoreBase.setPeriodsOfUnavailability');
    try {
      return super.setPeriodsOfUnavailability(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHeatingSystem(HeatingSystem? value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setHeatingSystem');
    try {
      return super.setHeatingSystem(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setZone(Zone? value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setZone');
    try {
      return super.setZone(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOthersObservations(String value) {
    final _$actionInfo = _$_CustomerSiteSheetStoreBaseActionController
        .startAction(name: '_CustomerSiteSheetStoreBase.setOthersObservations');
    try {
      return super.setOthersObservations(value);
    } finally {
      _$_CustomerSiteSheetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
siteSheet: ${siteSheet},
currentTab: ${currentTab},
drawing: ${drawing},
completedTabs: ${completedTabs},
isCompleted: ${isCompleted}
    ''';
  }
}
