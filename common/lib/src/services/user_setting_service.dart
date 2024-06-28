import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class UserSettingServiceInterface {
  Future<void> create(UserSetting item, {bool applyToFirestore = true});

  Future<void> update(UserSetting item, {bool applyToFirestore = true});

  Future<UserSetting?> getCurrent();

  Future<UserSetting?> getCurrentFromFirestore();

  Stream<UserSetting?> getCurrentAsStream();

  Future<void> startSyncByCurrentUser();

  Future<void> stopSync();

  Future<void> deleteAll({bool applyToFirestore = true});

  Future<void> setShowEmailInOrderForm(UserSetting item, bool value);

  Future<void> setShowPhoneInOrderForm(UserSetting item, bool value);
}

// Implementation:--------------------------------------------------------------
class UserSettingService extends AbstractModelService<UserSetting,
    $UserSettingsTable, AgencyDatabase> implements UserSettingServiceInterface {
  UserSettingService()
      : super(getIt<UserSettingDriftDao>(), getIt<UserSettingFirestoreDao>());

  // Dependencies:--------------------------------------------------------------
  final AuthStoreInterface _authStore = getIt<AuthStoreInterface>();

  @override
  Future<UserSetting?> getCurrent() async {
    return await (localDao as UserSettingDriftDao)
        .getByUserId(_authStore.currentUser?.uid ?? '');
  }

  @override
  Stream<UserSetting?> getCurrentAsStream() {
    return (localDao as UserSettingDriftDao)
        .getByUserIdAsStream(_authStore.currentUser?.uid ?? '');
  }

  @override
  Future<UserSetting?> getCurrentFromFirestore() async {
    return await (remoteDao as UserSettingFirestoreDao)
        .getByUserId(_authStore.currentUser?.uid ?? '');
  }

  @override
  Future<void> setShowEmailInOrderForm(UserSetting item, bool value) async {
    if (!value || item.isEmailValidForBrand == true) {
      item.showEmailInOrderForm = value;
      await super.update(item);
    } else {
      Fluttertoast.showToast(
          msg: 'rep.error_infos.email_invalid_for_brand'.tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Future<void> setShowPhoneInOrderForm(UserSetting item, bool value) async {
    item.showPhoneInOrderForm = value;
    await super.update(item);
  }
}
