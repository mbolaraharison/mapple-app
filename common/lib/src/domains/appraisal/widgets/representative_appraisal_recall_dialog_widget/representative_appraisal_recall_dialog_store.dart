import 'dart:async';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'representative_appraisal_recall_dialog_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class RepresentativeAppraisalRecallDialogStoreInterface {
  RepresentativeAppraisalRecallDialogStoreInterface._(
    this.selectedAppraisals,
  );
  ObservableList<RepresentativeAppraisal> selectedAppraisals;

  Future<List<RepresentativeAppraisal>>
      getNotCompletedByRepresentativeByRepresentativeId(
          Representative representative);
  void selectAppraisal(RepresentativeAppraisal appraisal);
  Future<void> sendRecalls();
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class RepresentativeAppraisalRecallDialogStore = _RepresentativeAppraisalRecallDialogStoreBase
    with _$RepresentativeAppraisalRecallDialogStore;

abstract class _RepresentativeAppraisalRecallDialogStoreBase
    with Store
    implements RepresentativeAppraisalRecallDialogStoreInterface {
  // Services:------------------------------------------------------------------
  late final RepresentativeAppraisalServiceInterface
      _representativeAppraisalService =
      getIt<RepresentativeAppraisalServiceInterface>();
  late final EmailServiceInterface _emailService =
      getIt<EmailServiceInterface>();

  // Variables:-----------------------------------------------------------------
  @override
  @observable
  ObservableList<RepresentativeAppraisal> selectedAppraisals =
      ObservableList<RepresentativeAppraisal>();

  // Actions:-------------------------------------------------------------------
  @override
  Future<List<RepresentativeAppraisal>>
      getNotCompletedByRepresentativeByRepresentativeId(
          Representative representative) {
    return _representativeAppraisalService
        .getNotCompletedByRepresentativeByRepresentativeId(representative.id);
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
  @action
  Future<void> sendRecalls() async {
    await _emailService.sendRepresentativeAppraisalRecall(selectedAppraisals);
  }
}
