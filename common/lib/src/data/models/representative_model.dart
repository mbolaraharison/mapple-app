import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:maple_common/maple_common.dart';

class Representative extends AbstractBaseModel
    implements Insertable<Representative>, SelectForSignatureBaseModel {
  Representative({
    required super.id,
    required this.sageId,
    required this.agencyId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.profileCode,
    required this.profileLabel,
    required this.isActive,
    this.canAccessCRM = false,
    required this.canAccessFair,
    required this.isDirectSale,
    this.appVersion,
    this.startDate,
    this.probationaryPeriodValidation = false,
    this.corporateVehicle = false,
    this.twoMonthsWith3540BookedMeetings = false,
    this.firstIntroductionBeforeMentor = false,
    this.twoMonthsWith15OpportunityRequests = false,
    this.aloneOnFirstSale = false,
    this.firstSaleAtFair = false,
    this.aloneOn4FundingSales = false,
    this.twoMonthsWith20KTurnover = false,
    this.aloneOnFirstAdditionalSale = false,
    this.aloneOn30KOrMoreTurnoverInOneMonth = false,
    this.soldTwoProductsInOneSale = false,
    super.createdAt,
    super.updatedAt,
  });

  // Static variables:----------------------------------------------------------
  static const String currentAgencyIdKey = "currentAgencyId";
  static const String currentFairIdKey = "currentFairId";

  // Variables:-----------------------------------------------------------------
  final String sageId;
  final String agencyId;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final int profileCode;
  final String profileLabel;
  final bool isActive;
  final bool canAccessCRM;
  final bool canAccessFair;
  bool isDirectSale;
  @Deprecated('Use userSetting.appVersion instead')
  String? appVersion;
  DateTime? startDate;
  bool probationaryPeriodValidation;
  bool corporateVehicle;
  bool twoMonthsWith3540BookedMeetings;
  bool firstIntroductionBeforeMentor;
  bool twoMonthsWith15OpportunityRequests;
  bool aloneOnFirstSale;
  bool firstSaleAtFair;
  bool aloneOn4FundingSales;
  bool twoMonthsWith20KTurnover;
  bool aloneOnFirstAdditionalSale;
  bool aloneOn30KOrMoreTurnoverInOneMonth;
  bool soldTwoProductsInOneSale;

  Agency? agency;

  // Getters:-------------------------------------------------------------------
  String get fullName =>
      "${firstName.toCapitalizedWords()} ${lastName.toCapitalizedWords()}";

  @override
  String get shortFullName {
    List<String> firstNames = this.firstName.split(" ");
    String firstName = firstNames.isNotEmpty ? firstNames[0] : "";
    List<String> lastNames = this.lastName.split(" ");
    String lastName = lastNames.isNotEmpty ? lastNames[0] : "";
    return "$firstName $lastName";
  }

  String get formattedPhone {
    String formattedPhone = phone;
    if (formattedPhone.trim() == '') {
      return '';
    }
    // check if phone does not start with +33
    if (formattedPhone.startsWith('+33')) {
      return formattedPhone.replaceFirst('+33', '0');
    }
    // check if phone does not start with 0
    if (!formattedPhone.startsWith('0')) {
      return '0$formattedPhone';
    }
    return formattedPhone;
  }

  @override
  String get initials {
    return getIt<StringUtilsInterface>().getInitialsFromName(shortFullName);
  }

  bool get isDirector => [
        Role.agencyDirector.value,
        Role.regionalDirector.value
      ].contains(profileCode);

  bool get isSalesRep =>
      profileCode == Role.juniorSalesRep.value ||
      profileCode == Role.confirmedSalesRep.value;

  bool get hasAccessToRepresentativeAppraisalModule => isDirector || isSalesRep;

  Role get role => Role.fromValue(profileCode);

  String get roleLabel => role.label;

  bool get hasFairAccess => !isDirectSale && canAccessFair;

  bool get isEmailEmpty => email.trim() == '';

  bool get isEmailValid {
    String trimmedEmail = email.trim();
    // check if email is valid
    return getIt<EmailValidatorInterface>().validate(trimmedEmail);
  }

  bool get isPhoneEmpty => phone.trim() == '';

  bool get isPhoneValid {
    String trimmedPhone = formattedPhone.trim();
    // check if phone is valid
    return getIt<PhoneValidatorInterface>()
        .validate(trimmedPhone, mobile: true);
  }

  bool get isEmailValidForSignature {
    return !isEmailEmpty && isEmailValid;
  }

  bool get isPhoneValidForSignature {
    return !isPhoneEmpty && isPhoneValid;
  }

  List<Map<String, dynamic>> get commonBadges {
    List<Map<String, dynamic>> badges = [];
    badges.add({
      'icon': MapleCommonAssets.baseProbationaryPeriod,
      'isActive': probationaryPeriodValidation,
      'description':
          'appraisal.training_protocol.common.probationary_period_validation'
              .tr(),
    });
    badges.add({
      'icon': MapleCommonAssets.baseCorporateVehicle,
      'isActive': corporateVehicle,
      'description':
          'appraisal.training_protocol.common.corporate_vehicle'.tr(),
    });
    return badges;
  }

  List<Map<String, dynamic>> get firstBaseBadges {
    List<Map<String, dynamic>> badges = [];
    badges.add({
      'icon': MapleCommonAssets.baseRdv,
      'isActive': twoMonthsWith3540BookedMeetings,
      'description':
          'appraisal.training_protocol.first_base.two_months_with_35_40_booked_meetings'
              .tr(),
    });
    badges.add({
      'icon': MapleCommonAssets.basePerformance,
      'isActive': firstIntroductionBeforeMentor,
      'description':
          'appraisal.training_protocol.first_base.first_introduction_before_mentor'
              .tr(),
    });
    badges.add({
      'icon': MapleCommonAssets.baseX15,
      'isActive': twoMonthsWith15OpportunityRequests,
      'description':
          'appraisal.training_protocol.first_base.two_months_with_15_opportunity_requests'
              .tr(),
    });
    badges.add({
      'icon': MapleCommonAssets.baseVad,
      'isActive': aloneOnFirstSale,
      'description':
          'appraisal.training_protocol.first_base.alone_on_first_sale'.tr(),
    });
    return badges;
  }

  List<Map<String, dynamic>> get secondBaseBadges {
    List<Map<String, dynamic>> badges = [];
    badges.add({
      'icon': MapleCommonAssets.baseFAndS,
      'isActive': firstSaleAtFair,
      'description':
          'appraisal.training_protocol.second_base.first_sale_at_fair'.tr(),
    });
    badges.add({
      'icon': MapleCommonAssets.baseX4,
      'isActive': aloneOn4FundingSales,
      'description':
          'appraisal.training_protocol.second_base.alone_on_4_funding_sales'
              .tr(),
    });
    badges.add({
      'icon': MapleCommonAssets.base20k,
      'isActive': twoMonthsWith20KTurnover,
      'description':
          'appraisal.training_protocol.second_base.two_months_with_20K_turnover'
              .tr(),
    });
    badges.add({
      'icon': MapleCommonAssets.basePlus1,
      'isActive': aloneOnFirstAdditionalSale,
      'description':
          'appraisal.training_protocol.second_base.alone_on_first_additional_sale'
              .tr(),
    });
    return badges;
  }

  List<Map<String, dynamic>> get thirdBaseBadges {
    List<Map<String, dynamic>> badges = [];
    badges.add({
      'icon': MapleCommonAssets.base30k,
      'isActive': aloneOn30KOrMoreTurnoverInOneMonth,
      'description':
          'appraisal.training_protocol.third_base.alone_on_30K_or_more_turnover_in_one_month'
              .tr(),
    });
    badges.add({
      'icon': MapleCommonAssets.baseX2,
      'isActive': soldTwoProductsInOneSale,
      'description':
          'appraisal.training_protocol.third_base.sold_two_products_in_one_sale'
              .tr(),
    });
    return badges;
  }

  @override
  bool get isValidForSignature {
    return isEmailValidForSignature && isPhoneValidForSignature;
  }

  @override
  List<String> get signingAbilityStatusInfosList {
    List<String> infos = [];
    if (isEmailEmpty) {
      infos.add('rep.error_infos.email_empty'.tr());
    }
    if (!isEmailEmpty && !isEmailValid) {
      infos.add('rep.error_infos.email_invalid'.tr());
    }
    if (isPhoneEmpty) {
      infos.add('rep.error_infos.phone_empty'.tr());
    }
    if (!isPhoneEmpty && !isPhoneValid) {
      infos.add('rep.error_infos.phone_invalid'.tr());
    }
    return infos;
  }

  @override
  String get signingAbilityStatusInfos {
    return signingAbilityStatusInfosList.join('\n');
  }

  // Methods:-------------------------------------------------------------------
  Future<void> loadAgency() async {
    agency = await getIt<AgencyServiceInterface>().getById(agencyId);
  }

  @override
  Future<void> loadData() async {
    await loadAgency();
  }

  // Base methods:--------------------------------------------------------------
  factory Representative.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Representative(
      id: snapshot.id,
      sageId: data?['sageId'] as String,
      agencyId: data?['agencyId'] as String,
      firstName: data?['firstName'] as String,
      lastName: data?['lastName'] as String,
      email: data?['email'] as String,
      phone: data?['phone'] as String,
      profileCode: int.parse(data?['profileCode'].toString() ?? '0'),
      profileLabel: data?['profileLabel'] as String,
      isActive: data?['isActive'] as bool,
      canAccessCRM: data?['canAccessCRM'] as bool,
      canAccessFair: data?['canAccessFair'] as bool,
      isDirectSale: data?['isDirectSale'] as bool,
      appVersion: data?['appVersion'] as String?,
      startDate: data?['startDate']?.toDate() as DateTime?,
      probationaryPeriodValidation:
          data?['probationaryPeriodValidation'] as bool? ?? false,
      corporateVehicle: data?['corporateVehicle'] as bool? ?? false,
      twoMonthsWith3540BookedMeetings:
          data?['twoMonthsWith3540BookedMeetings'] as bool? ?? false,
      firstIntroductionBeforeMentor:
          data?['firstIntroductionBeforeMentor'] as bool? ?? false,
      twoMonthsWith15OpportunityRequests:
          data?['twoMonthsWith15OpportunityRequests'] as bool? ?? false,
      aloneOnFirstSale: data?['aloneOnFirstSale'] as bool? ?? false,
      firstSaleAtFair: data?['firstSaleAtFair'] as bool? ?? false,
      aloneOn4FundingSales: data?['aloneOn4FundingSales'] as bool? ?? false,
      twoMonthsWith20KTurnover:
          data?['twoMonthsWith20KTurnover'] as bool? ?? false,
      aloneOnFirstAdditionalSale:
          data?['aloneOnFirstAdditionalSale'] as bool? ?? false,
      aloneOn30KOrMoreTurnoverInOneMonth:
          data?['aloneOn30KOrMoreTurnoverInOneMonth'] as bool? ?? false,
      soldTwoProductsInOneSale:
          data?['soldTwoProductsInOneSale'] as bool? ?? false,
      createdAt: data?['createdAt']?.toDate() as DateTime?,
      updatedAt: data?['updatedAt']?.toDate() as DateTime?,
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    final data = {
      'sageId': sageId,
      'agencyId': agencyId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'profileLabel': profileLabel,
      'isActive': isActive,
      'canAccessCRM': canAccessCRM,
      'canAccessFair': canAccessFair,
      'isDirectSale': isDirectSale,
      'appVersion': appVersion,
      'startDate': startDate,
      'probationaryPeriodValidation': probationaryPeriodValidation,
      'corporateVehicle': corporateVehicle,
      'twoMonthsWith3540BookedMeetings': twoMonthsWith3540BookedMeetings,
      'firstIntroductionBeforeMentor': firstIntroductionBeforeMentor,
      'twoMonthsWith15OpportunityRequests': twoMonthsWith15OpportunityRequests,
      'aloneOnFirstSale': aloneOnFirstSale,
      'firstSaleAtFair': firstSaleAtFair,
      'aloneOn4FundingSales': aloneOn4FundingSales,
      'twoMonthsWith20KTurnover': twoMonthsWith20KTurnover,
      'aloneOnFirstAdditionalSale': aloneOnFirstAdditionalSale,
      'aloneOn30KOrMoreTurnoverInOneMonth': aloneOn30KOrMoreTurnoverInOneMonth,
      'soldTwoProductsInOneSale': soldTwoProductsInOneSale,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };

    if (profileCode != Role.unknown.value) {
      data['profileCode'] = profileCode;
    }

    return data;
  }

  @override
  Representative copyWith({
    String? id,
    String? sageId,
    String? agencyId,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    int? profileCode,
    String? profileLabel,
    bool? isActive,
    bool? canAccessCRM,
    bool? canAccessFair,
    bool? isDirectSale,
    String? appVersion,
    DateTime? startDate,
    bool? probationaryPeriodValidation,
    bool? corporateVehicle,
    bool? twoMonthsWith3540BookedMeetings,
    bool? firstIntroductionBeforeMentor,
    bool? twoMonthsWith15OpportunityRequests,
    bool? aloneOnFirstSale,
    bool? firstSaleAtFair,
    bool? aloneOn4FundingSales,
    bool? twoMonthsWith20KTurnover,
    bool? aloneOnFirstAdditionalSale,
    bool? aloneOn30KOrMoreTurnoverInOneMonth,
    bool? soldTwoProductsInOneSale,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Representative(
      id: id ?? this.id,
      sageId: sageId ?? this.sageId,
      agencyId: agencyId ?? this.agencyId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileCode: profileCode ?? this.profileCode,
      profileLabel: profileLabel ?? this.profileLabel,
      isActive: isActive ?? this.isActive,
      canAccessCRM: canAccessCRM ?? this.canAccessCRM,
      canAccessFair: canAccessFair ?? this.canAccessFair,
      isDirectSale: isDirectSale ?? this.isDirectSale,
      appVersion: appVersion ?? this.appVersion,
      startDate: startDate ?? this.startDate,
      probationaryPeriodValidation:
          probationaryPeriodValidation ?? this.probationaryPeriodValidation,
      corporateVehicle: corporateVehicle ?? this.corporateVehicle,
      twoMonthsWith3540BookedMeetings: twoMonthsWith3540BookedMeetings ??
          this.twoMonthsWith3540BookedMeetings,
      firstIntroductionBeforeMentor:
          firstIntroductionBeforeMentor ?? this.firstIntroductionBeforeMentor,
      twoMonthsWith15OpportunityRequests: twoMonthsWith15OpportunityRequests ??
          this.twoMonthsWith15OpportunityRequests,
      aloneOnFirstSale: aloneOnFirstSale ?? this.aloneOnFirstSale,
      firstSaleAtFair: firstSaleAtFair ?? this.firstSaleAtFair,
      aloneOn4FundingSales: aloneOn4FundingSales ?? this.aloneOn4FundingSales,
      twoMonthsWith20KTurnover:
          twoMonthsWith20KTurnover ?? this.twoMonthsWith20KTurnover,
      aloneOnFirstAdditionalSale:
          aloneOnFirstAdditionalSale ?? this.aloneOnFirstAdditionalSale,
      aloneOn30KOrMoreTurnoverInOneMonth: aloneOn30KOrMoreTurnoverInOneMonth ??
          this.aloneOn30KOrMoreTurnoverInOneMonth,
      soldTwoProductsInOneSale:
          soldTwoProductsInOneSale ?? this.soldTwoProductsInOneSale,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return {
      'id': Variable<String>(id),
      'sage_id': Variable<String>(sageId),
      'agency_id': Variable<String>(agencyId),
      'first_name': Variable<String>(firstName),
      'last_name': Variable<String>(lastName),
      'email': Variable<String>(email),
      'phone': Variable<String>(phone),
      'profile_code': Variable<int>(profileCode),
      'profile_label': Variable<String>(profileLabel),
      'is_active': Variable<bool>(isActive),
      'can_access_c_r_m': Variable<bool>(canAccessCRM),
      'can_access_fair': Variable<bool>(canAccessFair),
      'is_direct_sale': Variable<bool>(isDirectSale),
      'app_version': Variable<String>(appVersion),
      'start_date': Variable<DateTime>(startDate),
      'probationary_period_validation':
          Variable<bool>(probationaryPeriodValidation),
      'corporate_vehicle': Variable<bool>(corporateVehicle),
      'two_months_with3540_booked_meetings':
          Variable<bool>(twoMonthsWith3540BookedMeetings),
      'first_introduction_before_mentor':
          Variable<bool>(firstIntroductionBeforeMentor),
      'two_months_with15_opportunity_requests':
          Variable<bool>(twoMonthsWith15OpportunityRequests),
      'alone_on_first_sale': Variable<bool>(aloneOnFirstSale),
      'first_sale_at_fair': Variable<bool>(firstSaleAtFair),
      'alone_on4_funding_sales': Variable<bool>(aloneOn4FundingSales),
      'two_months_with20_k_turnover': Variable<bool>(twoMonthsWith20KTurnover),
      'alone_on_first_additional_sale':
          Variable<bool>(aloneOnFirstAdditionalSale),
      'alone_on30_k_or_more_turnover_in_one_month':
          Variable<bool>(aloneOn30KOrMoreTurnoverInOneMonth),
      'sold_two_products_in_one_sale': Variable<bool>(soldTwoProductsInOneSale),
      'created_at': Variable<DateTime>(createdAt),
      'updated_at': Variable<DateTime>(updatedAt),
    };
  }

  Signer<SignerModel> getSignerModel(
      {int? index, required bool signed, required String recipientId}) {
    SignHereTabModel signHereTabModel = SignHereTabModel(
        anchorString: 'Technicien conseil ${index != null ? index + 1 : 1}',
        anchorUnits: 'pixels',
        anchorXOffset: '110',
        anchorYOffset: '35',
        status: 'active');
    TabsModel tabs = TabsModel(signHereTabs: [signHereTabModel]);
    RecipientSmsAuthenticationModel smsAuthentication =
        RecipientSmsAuthenticationModel(
            senderProvidedNumbers: [formattedPhone]);
    SignerModel signer = SignerModel(
      clientUserId: 'Technicien conseil ${index != null ? index + 1 : 1}',
      email: email,
      firstName: firstName,
      lastName: lastName,
      name: shortFullName,
      recipientId: recipientId,
      routingOrder: '1',
      smsAuthentication: smsAuthentication,
      status: 'created',
      tabs: tabs,
      idCheckConfigurationName: '',
      requireIdLookup: false,
    );
    return Signer<SignerModel>(
      signer: signer,
      initials: initials,
      signed: signed,
      model: this,
    );
  }

  @override
  bool identicalTo(AbstractBaseModel other) {
    if (identical(this, other)) return true;

    return other is Representative &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.sageId == sageId &&
        other.agencyId == agencyId &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.phone == phone &&
        other.profileCode == profileCode &&
        other.profileLabel == profileLabel &&
        other.isActive == isActive &&
        other.canAccessCRM == canAccessCRM &&
        other.canAccessFair == canAccessFair &&
        other.isDirectSale == isDirectSale &&
        other.appVersion == appVersion &&
        other.startDate == startDate &&
        other.probationaryPeriodValidation == probationaryPeriodValidation &&
        other.corporateVehicle == corporateVehicle &&
        other.twoMonthsWith3540BookedMeetings ==
            twoMonthsWith3540BookedMeetings &&
        other.firstIntroductionBeforeMentor == firstIntroductionBeforeMentor &&
        other.twoMonthsWith15OpportunityRequests ==
            twoMonthsWith15OpportunityRequests &&
        other.aloneOnFirstSale == aloneOnFirstSale &&
        other.firstSaleAtFair == firstSaleAtFair &&
        other.aloneOn4FundingSales == aloneOn4FundingSales &&
        other.twoMonthsWith20KTurnover == twoMonthsWith20KTurnover &&
        other.aloneOnFirstAdditionalSale == aloneOnFirstAdditionalSale &&
        other.aloneOn30KOrMoreTurnoverInOneMonth ==
            aloneOn30KOrMoreTurnoverInOneMonth &&
        other.soldTwoProductsInOneSale == soldTwoProductsInOneSale &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
}
