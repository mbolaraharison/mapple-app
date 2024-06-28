import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';

class Contact extends AbstractBaseModel
    implements Insertable<Contact>, SelectForSignatureBaseModel {
  Contact({
    required super.id,
    required this.customerId,
    required this.agencyId,
    required this.civility,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.mobilePhone,
    required this.isDefault,
    required this.sageId,
    super.createdAt,
    super.updatedAt,
  }) {
    searchableEmail = email.toSearchable().trim();
    searchablePhone = formattedPhone.toSearchable().replaceAll(' ', '');
    searchablePhoneWithCode =
        formattedPhoneWithCode.toSearchable().replaceAll(' ', '');
    searchableMobilePhone =
        formattedMobilePhone.toSearchable().replaceAll(' ', '');
    searchableMobilePhoneWithCode =
        formattedMobilePhoneWithCode.toSearchable().replaceAll(' ', '');
  }

  // Variables:-----------------------------------------------------------------
  final String customerId;
  final String agencyId;
  Civility civility;
  String email;
  String lastName;
  String firstName;
  String phone;
  String mobilePhone;
  bool isDefault;
  String sageId;

  Customer? customer;
  Agency? agency;

  // Search fields
  late String searchableEmail;
  late String searchablePhone;
  late String searchablePhoneWithCode;
  late String searchableMobilePhone;
  late String searchableMobilePhoneWithCode;

  // Getters:--------------------------------------------------------------------
  String get fullName =>
      '${firstName.toCapitalizedWords()} ${lastName.toCapitalizedWords()}'
          .trim();

  String get fullNameWithCivility =>
      '${civility.abbreviation} $fullName'.trim();

  @override
  String get shortFullName {
    List<String> firstNames = this.firstName.split(" ");
    String firstName = firstNames.isNotEmpty ? firstNames[0] : "";
    List<String> lastNames = this.lastName.split(" ");
    String lastName = lastNames.isNotEmpty ? lastNames[0] : "";
    String shortFullName = "";
    if (firstName.isNotEmpty) {
      shortFullName += firstName.toCapitalizedWords();
    }
    if (lastName.isNotEmpty) {
      if (shortFullName.isNotEmpty) {
        shortFullName += " ";
      }
      shortFullName += lastName.toCapitalizedWords();
    }
    return shortFullName;
  }

  bool get isEmailEmpty => email.trim() == '';

  bool get isEmailValid {
    String trimmedEmail = email.trim();
    // check if email is valid
    return getIt<EmailValidatorInterface>().validate(trimmedEmail);
  }

  bool get isPhoneEmpty => mobilePhone.trim() == '';

  bool get isPhoneValid {
    String trimmedPhone = formattedMobilePhone.trim();
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

  @override
  bool get isValidForSignature {
    return isEmailValidForSignature && isPhoneValidForSignature;
  }

  @override
  List<String> get signingAbilityStatusInfosList {
    List<String> infos = [];
    if (isEmailEmpty) {
      infos.add('customer.error_infos.email_empty'.tr());
    }
    if (!isEmailEmpty && !isEmailValid) {
      infos.add('customer.error_infos.email_invalid'.tr());
    }
    if (isPhoneEmpty) {
      infos.add('customer.error_infos.phone_empty'.tr());
    }
    if (!isPhoneEmpty && !isPhoneValid) {
      infos.add('customer.error_infos.phone_invalid'.tr());
    }
    return infos;
  }

  @override
  String get signingAbilityStatusInfos {
    return signingAbilityStatusInfosList.join('\n');
  }

  @override
  String get initials {
    return getIt<StringUtilsInterface>().getInitialsFromName(shortFullName);
  }

  String get civilityKey => 'civility_abbreviation_${civility.name}';

  String get formattedMobilePhone {
    return getIt<PhoneUtilsInterface>().format(mobilePhone);
  }

  String get formattedMobilePhoneWithCode {
    return getIt<PhoneUtilsInterface>().formatWithCode(mobilePhone);
  }

  String get formattedPhone {
    return getIt<PhoneUtilsInterface>().format(phone);
  }

  String get formattedPhoneWithCode {
    return getIt<PhoneUtilsInterface>().formatWithCode(phone);
  }

  // Methods:-------------------------------------------------------------------
  Future<void> loadAgency() async {
    agency = await getIt<AgencyServiceInterface>().getById(agencyId);
  }

  Future<void> loadCustomer(
      {bool eager = false, List<Type> flow = const []}) async {
    // check flow
    flow = List.from(flow);
    if (!flow.contains(Contact)) {
      flow.add(Contact);
    } else {
      return;
    }
    customer = await getIt<CustomerServiceInterface>()
        .getById(customerId, eager: eager, flow: flow);
  }

  @override
  Future<void> loadData(
      {bool eager = false, List<Type> flow = const []}) async {
    await loadCustomer(eager: eager, flow: flow);
    await loadAgency();
  }

  // Base methods:--------------------------------------------------------------
  factory Contact.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Contact(
      id: snapshot.id,
      customerId: data?['customerId'] as String,
      agencyId: data?['agencyId'] as String,
      civility: Civility.fromValue(data?['civility'] as int),
      email: data?['email'] as String,
      lastName: data?['lastName'] as String,
      firstName: data?['firstName'] as String,
      phone: data?['phone'] as String,
      mobilePhone: data?['mobilePhone'] as String,
      isDefault: data?['isDefault'] as bool,
      sageId: data?['sageId'] ?? '',
      createdAt: data?['createdAt']?.toDate() as DateTime?,
      updatedAt: data?['updatedAt']?.toDate() as DateTime?,
    );
  }

  @override
  Map<String, dynamic> toFirestore() => {
        'customerId': customerId,
        'agencyId': agencyId,
        'civility': civility.value,
        'email': email,
        'lastName': lastName,
        'firstName': firstName,
        'phone': phone,
        'mobilePhone': mobilePhone,
        'isDefault': isDefault,
        'sageId': sageId,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  @override
  Contact copyWith({
    String? id,
    String? customerId,
    String? agencyId,
    Civility? civility,
    String? email,
    String? lastName,
    String? firstName,
    String? phone,
    String? mobilePhone,
    bool? isDefault,
    String? sageId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Contact(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      agencyId: agencyId ?? this.agencyId,
      civility: civility ?? this.civility,
      email: email ?? this.email,
      lastName: lastName ?? this.lastName,
      firstName: firstName ?? this.firstName,
      phone: phone ?? this.phone,
      mobilePhone: mobilePhone ?? this.mobilePhone,
      isDefault: isDefault ?? this.isDefault,
      sageId: sageId ?? this.sageId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return {
      'id': Variable<String>(id),
      'customer_id': Variable<String>(customerId),
      'agency_id': Variable<String>(agencyId),
      'civility': Variable<String>(civility.name),
      'email': Variable<String>(email),
      'last_name': Variable<String>(lastName),
      'first_name': Variable<String>(firstName),
      'phone': Variable<String>(phone),
      'mobile_phone': Variable<String>(mobilePhone),
      'is_default': Variable<bool>(isDefault),
      'sage_id': Variable<String>(sageId),
      'searchable_email': Variable<String>(searchableEmail),
      'searchable_phone': Variable<String>(searchablePhone),
      'searchable_phone_with_code': Variable<String>(searchablePhoneWithCode),
      'searchable_mobile_phone': Variable<String>(searchableMobilePhone),
      'searchable_mobile_phone_with_code':
          Variable<String>(searchableMobilePhoneWithCode),
      'created_at': Variable<DateTime>(createdAt),
      'updated_at': Variable<DateTime>(updatedAt),
    };
  }

  Signer<SignerModel> getSignerModel(
      {int? index,
      bool withMultipleSigners = false,
      required bool signed,
      required String recipientId}) {
    int computedIndex = index ?? 0;
    SignHereTabModel signHereTabModel = SignHereTabModel(
        anchorString: withMultipleSigners == true
            ? 'Cocontractant.e ${computedIndex + 1}'
            : 'Contractant.e',
        anchorUnits: 'pixels',
        anchorXOffset: '0',
        anchorYOffset: '35',
        status: 'active');
    TabsModel tabs = TabsModel(signHereTabs: [signHereTabModel]);
    RecipientSmsAuthenticationModel smsAuthentication =
        RecipientSmsAuthenticationModel(
      senderProvidedNumbers: [formattedMobilePhoneWithCode],
    );
    SignerModel signer = SignerModel(
      clientUserId: withMultipleSigners == true
          ? 'Cocontractant.e ${computedIndex + 1}'
          : 'Contractant.e',
      email: email,
      firstName: firstName,
      lastName: lastName,
      name: fullName,
      recipientId: recipientId,
      routingOrder: '1',
      smsAuthentication: smsAuthentication,
      status: 'created',
      tabs: tabs,
      idCheckConfigurationName: 'SMS Auth \$',
      requireIdLookup: true,
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

    return other is Contact &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.sageId == sageId &&
        other.customerId == customerId &&
        other.agencyId == agencyId &&
        other.civility == civility &&
        other.email == email &&
        other.lastName == lastName &&
        other.firstName == firstName &&
        other.phone == phone &&
        other.mobilePhone == mobilePhone &&
        other.isDefault == isDefault &&
        other.sageId == sageId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
}
