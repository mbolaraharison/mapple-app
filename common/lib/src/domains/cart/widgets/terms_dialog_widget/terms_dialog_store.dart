import 'dart:io';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'terms_dialog_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class TermsDialogStoreInterface {
  TermsDialogStoreInterface._(
    this.acceptanteDematerialization,
    this.acceptanteTerms,
    this.hasSignature,
    this.hasBeenSubmitted,
  );

  // Variables
  bool acceptanteDematerialization;
  bool acceptanteTerms;
  File? image;
  bool hasSignature;
  Agency? currentAgency;
  bool hasBeenSubmitted;

  // Computed
  bool get formIsValid;
  bool get isValid;

  // Methods
  void setHasBeenSubmitted(bool value);
  void toggleAcceptanteDematerialization();
  void toggleAcceptanteTerms();
  void setHasSignature(bool value);
  void setImage(File? value);
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class TermsDialogStore = _TermsDialogStoreBase with _$TermsDialogStore;

abstract class _TermsDialogStoreBase
    with Store
    implements TermsDialogStoreInterface {
  // Constructor:---------------------------------------------------------------
  _TermsDialogStoreBase() {
    _agencyService.getCurrentAsStream().listen((event) {
      currentAgency = event;
    });
  }

  // Services:------------------------------------------------------------------
  final AgencyServiceInterface _agencyService = getIt<AgencyServiceInterface>();

  // Store variables:-----------------------------------------------------------
  @override
  @observable
  bool acceptanteDematerialization = false;

  @override
  @observable
  bool acceptanteTerms = false;

  @override
  @observable
  File? image;

  @override
  @observable
  bool hasSignature = false;

  @override
  @observable
  Agency? currentAgency;

  @override
  @observable
  bool hasBeenSubmitted = false;

  // Computed:------------------------------------------------------------------
  @override
  @computed
  bool get formIsValid => acceptanteDematerialization && acceptanteTerms;

  @override
  @computed
  bool get isValid => image != null;

  // Actions:-------------------------------------------------------------------
  @override
  @action
  void setHasBeenSubmitted(bool value) => hasBeenSubmitted = value;

  @override
  @action
  void toggleAcceptanteDematerialization() {
    acceptanteDematerialization = !acceptanteDematerialization;
  }

  @override
  @action
  void toggleAcceptanteTerms() {
    acceptanteTerms = !acceptanteTerms;
  }

  @override
  @action
  void setHasSignature(bool value) => hasSignature = value;

  @override
  @action
  void setImage(File? value) => image = value;
}
