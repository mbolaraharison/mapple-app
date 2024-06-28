import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';
import 'package:timezone/timezone.dart' as tz;

part 'add_representative_appraisal_dialog_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class AddRepresentativeAppraisalDialogStoreInterface {
  AddRepresentativeAppraisalDialogStoreInterface._(
    this.type,
    this.limitDate,
  );
  RepresentativeAppraisalType type;

  DateTime? limitDate;

  void setType(RepresentativeAppraisalType value);

  void setLimitDate(DateTime value);

  bool get formIsValid;

  String get formattedLimitDate;

  Future<void> createRepresentativeAppraisal(Representative representative);
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class AddRepresentativeAppraisalDialogStore = _AddRepresentativeAppraisalDialogStoreBase
    with _$AddRepresentativeAppraisalDialogStore;

abstract class _AddRepresentativeAppraisalDialogStoreBase
    with Store
    implements AddRepresentativeAppraisalDialogStoreInterface {
  // Services:------------------------------------------------------------------
  late final RepresentativeAppraisalServiceInterface
      _representativeAppraisalService =
      getIt<RepresentativeAppraisalServiceInterface>();
  late final UuidUtilsInterface _uuidUtils = getIt<UuidUtilsInterface>();

  // Variables:-----------------------------------------------------------------
  @override
  @observable
  RepresentativeAppraisalType type = RepresentativeAppraisalType.ANNUAL;

  @override
  @observable
  DateTime? limitDate;

  // Computeds:-----------------------------------------------------------------
  @override
  @computed
  bool get formIsValid {
    return limitDate != null;
  }

  @override
  @computed
  String get formattedLimitDate =>
      limitDate != null ? DateFormat('dd/MM/yyyy').format(limitDate!) : '';

  // Actions:-------------------------------------------------------------------
  @override
  @action
  void setType(RepresentativeAppraisalType value) {
    type = value;
  }

  @override
  @action
  void setLimitDate(DateTime value) {
    final locationParis = tz.getLocation('Europe/Paris');
    limitDate = tz.TZDateTime.from(value, locationParis);
  }

  @override
  @action
  Future<void> createRepresentativeAppraisal(
      Representative representative) async {
    RepresentativeAppraisal representativeAppraisal = RepresentativeAppraisal(
      id: _uuidUtils.generate(),
      representativeId: representative.id,
      completingDirectorId: null,
      agencyId: representative.agencyId,
      completedByDirectorAt: null,
      completedByRepresentativeAt: null,
      type: type,
      limitDate: limitDate!,
    );
    await _representativeAppraisalService.create(representativeAppraisal);
  }
}
