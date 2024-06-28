import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';
import 'package:package_info_plus/package_info_plus.dart';

class UserSetting extends AbstractBaseModel implements Insertable<UserSetting> {
  UserSetting({
    required super.id,
    required this.userId,
    this.showEmailInOrderForm = false,
    this.showPhoneInOrderForm = false,
    this.appVersion,
    super.createdAt,
    super.updatedAt,
  });

  // Variables:-----------------------------------------------------------------
  final String userId;
  bool showEmailInOrderForm;
  bool showPhoneInOrderForm;
  String? appVersion;

  // Methods:-------------------------------------------------------------------
  Future<void> updateAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    if (appVersion != version) {
      appVersion = version;
      await getIt<UserSettingFirestoreDao>().update(this);
    }
  }

  // Getters:-------------------------------------------------------------------
  bool get isEmailValidForBrand {
    String email = getIt<AuthStoreInterface>().currentUser?.email ?? '';
    return getIt<EmailValidatorInterface>().validateForBrand(email);
  }

  // Base methods:--------------------------------------------------------------
  @override
  void loadData() {}

  factory UserSetting.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserSetting(
      id: snapshot.id,
      userId: data?['userId'] as String,
      showEmailInOrderForm: data?['showEmailInOrderForm'] as bool,
      showPhoneInOrderForm: data?['showPhoneInOrderForm'] as bool,
      appVersion: data?['appVersion'] as String?,
      createdAt: data?['createdAt']?.toDate() as DateTime?,
      updatedAt: data?['updatedAt']?.toDate() as DateTime?,
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'showEmailInOrderForm': showEmailInOrderForm,
      'showPhoneInOrderForm': showPhoneInOrderForm,
      'appVersion': appVersion,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  UserSetting copyWith({
    String? id,
    String? userId,
    bool? showEmailInOrderForm,
    bool? showPhoneInOrderForm,
    String? appVersion,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserSetting(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      showEmailInOrderForm: showEmailInOrderForm ?? this.showEmailInOrderForm,
      showPhoneInOrderForm: showPhoneInOrderForm ?? this.showPhoneInOrderForm,
      appVersion: appVersion ?? this.appVersion,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return {
      'id': Variable<String>(id),
      'user_id': Variable<String>(userId),
      'show_email_in_order_form': Variable<bool>(showEmailInOrderForm),
      'show_phone_in_order_form': Variable<bool>(showPhoneInOrderForm),
      'app_version': Variable<String>(appVersion),
      'created_at': Variable<DateTime>(createdAt),
      'updated_at': Variable<DateTime>(updatedAt),
    };
  }

  @override
  bool identicalTo(AbstractBaseModel other) {
    if (identical(this, other)) return true;

    return other is UserSetting &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.userId == userId &&
        other.showEmailInOrderForm == showEmailInOrderForm &&
        other.showPhoneInOrderForm == showPhoneInOrderForm &&
        other.appVersion == appVersion &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
}
