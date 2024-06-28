import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';
import 'package:timezone/timezone.dart' as tz;

part 'save_discount_code_dialog_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class SaveDiscountCodeDialogStoreInterface {
  SaveDiscountCodeDialogStoreInterface._(
    this.discountPercentage,
    this.code,
    this.hasNotExpiration,
    this.startDate,
    this.endDate,
  );

  DiscountCode? discountCode;

  String discountPercentage;

  String code;

  bool hasNotExpiration;

  DateTime startDate;

  DateTime endDate;

  bool get isDiscountPercentageInvalid;

  bool get isCodeInvalid;

  bool get isEndDateInvalid;

  bool get formIsValid;

  bool get isEditing;

  void setDiscountCode(DiscountCode value);

  void setDiscountPercentage(String value);

  void setCode(String value);

  void setHasNotExpiration(bool value);

  void setStartDate(DateTime value);

  void setEndDate(DateTime value);

  Future<void> generateCode();

  Future<void> saveDiscountCode();

  Future<void> deleteDiscountCode();

  void dispose();
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class SaveDiscountCodeDialogStore = _SaveDiscountCodeDialogStoreBase
    with _$SaveDiscountCodeDialogStore;

abstract class _SaveDiscountCodeDialogStoreBase
    with Store
    implements SaveDiscountCodeDialogStoreInterface {
  // Constructor:---------------------------------------------------------------
  _SaveDiscountCodeDialogStoreBase() {
    _initStreams();
  }
  // Services:------------------------------------------------------------------
  late final RepresentativeServiceInterface _representativeService =
      getIt<RepresentativeServiceInterface>();

  late final UuidUtilsInterface _uuidUtils = getIt<UuidUtilsInterface>();
  late final DiscountCodeServiceInterface _discountCodesService =
      getIt<DiscountCodeServiceInterface>();

  // Variables:-----------------------------------------------------------------
  @override
  @observable
  DiscountCode? discountCode;

  @override
  @observable
  String discountPercentage = '';

  @override
  @observable
  String code = '';

  @override
  @observable
  bool hasNotExpiration = false;

  @override
  @observable
  DateTime startDate = DateTime.now();

  @override
  @observable
  DateTime endDate = DateTime.now().add(const Duration(days: 30));

  // Other variables:-----------------------------------------------------------
  StreamSubscription<Representative?>? _currentRepresentativeSubscription;

  @observable
  Representative? _currentRepresentative;

  // Computeds:-----------------------------------------------------------------
  @override
  @computed
  bool get isDiscountPercentageInvalid {
    if (discountPercentage.isEmpty) {
      return false;
    }

    final int discountPercentageInt = int.parse(discountPercentage);

    if (discountPercentageInt < 1 || discountPercentageInt > 100) {
      return true;
    }

    return false;
  }

  @override
  @computed
  bool get isCodeInvalid {
    if (code.isEmpty) {
      return false;
    }

    return !DiscountCode.codeRegExp.hasMatch(code);
  }

  @override
  @computed
  bool get isEndDateInvalid {
    return !hasNotExpiration && endDate.isBefore(startDate);
  }

  @override
  @computed
  bool get formIsValid {
    return discountPercentage.isNotEmpty &&
        !isDiscountPercentageInvalid &&
        code.isNotEmpty &&
        !isCodeInvalid &&
        !isEndDateInvalid;
  }

  @override
  @computed
  bool get isEditing => discountCode != null;

  // Actions:-------------------------------------------------------------------
  @override
  @action
  void setDiscountCode(DiscountCode value) {
    discountCode = value;
    discountPercentage = value.discount.toInt().toString();
    code = value.code;
    hasNotExpiration = !value.hasExpiration;
    startDate = value.startDate ?? DateTime.now();
    endDate = value.endDate ?? DateTime.now().add(const Duration(days: 30));
  }

  @override
  @action
  void setDiscountPercentage(String value) {
    discountPercentage = value;
  }

  @override
  @action
  void setCode(String value) {
    code = value;
  }

  @override
  @action
  void setHasNotExpiration(bool value) {
    hasNotExpiration = value;
  }

  @override
  @action
  void setStartDate(DateTime value) {
    final locationParis = tz.getLocation('Europe/Paris');
    startDate = tz.TZDateTime.from(value, locationParis);
  }

  @override
  @action
  void setEndDate(DateTime value) {
    final locationParis = tz.getLocation('Europe/Paris');
    endDate = tz.TZDateTime.from(value, locationParis);
  }

  @override
  @action
  Future<void> generateCode() async {
    final String agencyId = _currentRepresentative!.agencyId;
    code = await _discountCodesService.generateCode(agencyId);
  }

  @override
  @action
  Future<void> saveDiscountCode() async {
    final double discount = double.parse(discountPercentage);
    final String agencyId = _currentRepresentative!.agencyId;
    final String userId = _currentRepresentative!.id;

    final bool isAvailable = await _discountCodesService.isCodeAvailable(
      code: code,
      agencyId: agencyId,
      discountCode: discountCode,
    );

    if (!isAvailable) {
      throw ValidationException(
        'discount_codes.errors.code_already_exists'.tr(),
      );
    }

    if (isEditing) {
      startDate = tz.TZDateTime.from(startDate, tz.getLocation('Europe/Paris'));
      endDate = tz.TZDateTime.from(endDate, tz.getLocation('Europe/Paris'));
      final updatedDiscountCode = discountCode!.copyWith(
        code: code,
        discount: discount,
        startDate: () => hasNotExpiration ? null : startDate,
        endDate: () => hasNotExpiration ? null : endDate,
      );

      await _discountCodesService.update(updatedDiscountCode);
    } else {
      final discountCode = DiscountCode(
        id: _uuidUtils.generate(),
        code: code,
        type: DiscountCodeType.percentage,
        discount: discount,
        startDate: hasNotExpiration ? null : startDate,
        endDate: hasNotExpiration ? null : endDate,
        agencyId: agencyId,
        userId: userId,
      );

      await _discountCodesService.create(discountCode);
    }
  }

  @override
  @action
  Future<void> deleteDiscountCode() async {
    await _discountCodesService.delete(discountCode!);
  }

  // Other methods:-------------------------------------------------------------
  void _initStreams() {
    _currentRepresentativeSubscription?.cancel();
    _currentRepresentativeSubscription =
        _representativeService.getCurrentAsStream().listen((event) {
      _currentRepresentative = event;
    });
  }

  // Dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    _currentRepresentativeSubscription?.cancel();
  }
}
