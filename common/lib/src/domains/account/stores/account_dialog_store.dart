import 'dart:async';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'account_dialog_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class AccountDialogStoreInterface {
  Representative? representative;

  UserSetting? userSetting;

  Agency? agency;

  Fair? fair;

  String fairId = '';

  bool get canSubmit;

  void submit();

  void setFairId(String value);

  void dispose();
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class AccountDialogStore = _AccountDialogStoreBase with _$AccountDialogStore;

abstract class _AccountDialogStoreBase
    with Store
    implements AccountDialogStoreInterface {
  _AccountDialogStoreBase() {
    _init();
  }

  // Services:------------------------------------------------------------------
  final RepresentativeServiceInterface _representativeService =
      getIt<RepresentativeServiceInterface>();
  final UserSettingServiceInterface _userSettingService =
      getIt<UserSettingServiceInterface>();
  final AgencyServiceInterface _agencyService = getIt<AgencyServiceInterface>();
  final FairServiceInterface _fairService = getIt<FairServiceInterface>();

  // Variables:-----------------------------------------------------------------
  @override
  @observable
  Representative? representative;

  @override
  @observable
  UserSetting? userSetting;

  @override
  @observable
  Agency? agency;

  @override
  @observable
  Fair? fair;

  @override
  @observable
  String fairId = '';

  // Subscriptions:-------------------------------------------------------------
  StreamSubscription<Representative?>? _representativesSubscription;
  StreamSubscription<UserSetting?>? _userSettingsSubscription;
  StreamSubscription<Agency?>? _agencySubscription;
  StreamSubscription<Fair?>? _fairSubscription;

  // Computed:------------------------------------------------------------------
  @override
  @computed
  bool get canSubmit {
    return representative != null &&
            (representative?.isDirectSale == false && fairId.isNotEmpty) ||
        (representative != null && representative?.isDirectSale == true);
  }

  // Actions:-------------------------------------------------------------------
  @action
  Future<void> _init() async {
    representative = await _representativeService.getCurrent();
    _representativesSubscription?.cancel();
    _representativesSubscription = _representativeService
        .getCurrentAsStream()
        .listen((Representative? rep) async {
      representative = rep;

      userSetting = await _userSettingService.getCurrent();
      _userSettingsSubscription?.cancel();
      _userSettingsSubscription = _userSettingService
          .getCurrentAsStream()
          .listen((UserSetting? setting) {
        userSetting = setting;
      });
    });

    agency = await _agencyService.getCurrent();
    _agencySubscription?.cancel();
    _agencySubscription =
        _agencyService.getCurrentAsStream().listen((Agency? ag) {
      agency = ag;
    });

    fair = await _fairService.getCurrent();
    fairId = fair?.id ?? '';
    _fairSubscription?.cancel();
    _fairSubscription = _fairService.getCurrentAsStream().listen((Fair? f) {
      fair = f;
      fairId = f?.id ?? '';
    });
  }

  @override
  @action
  void setFairId(String value) {
    fairId = value;
  }

  @override
  @action
  void submit() {
    if (canSubmit) {
      _fairService.setCurrentById(fairId);
    }
  }

  // Disposers:-----------------------------------------------------------------
  @override
  @action
  void dispose() {
    _representativesSubscription?.cancel();
    _userSettingsSubscription?.cancel();
    _agencySubscription?.cancel();
    _fairSubscription?.cancel();
  }
}
