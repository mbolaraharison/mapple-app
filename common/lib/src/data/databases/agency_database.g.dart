// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency_database.dart';

// ignore_for_file: type=lint
class $AgenciesTable extends Agencies with TableInfo<$AgenciesTable, Agency> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AgenciesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => getIt<UuidUtilsInterface>().generate());
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _sageIdMeta = const VerificationMeta('sageId');
  @override
  late final GeneratedColumn<String> sageId = GeneratedColumn<String>(
      'sage_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _address1Meta =
      const VerificationMeta('address1');
  @override
  late final GeneratedColumn<String> address1 = GeneratedColumn<String>(
      'address1', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _address2Meta =
      const VerificationMeta('address2');
  @override
  late final GeneratedColumn<String> address2 = GeneratedColumn<String>(
      'address2', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
      'city', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nafMeta = const VerificationMeta('naf');
  @override
  late final GeneratedColumn<String> naf = GeneratedColumn<String>(
      'naf', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _postalCodeMeta =
      const VerificationMeta('postalCode');
  @override
  late final GeneratedColumn<String> postalCode = GeneratedColumn<String>(
      'postal_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _siretMeta = const VerificationMeta('siret');
  @override
  late final GeneratedColumn<String> siret = GeneratedColumn<String>(
      'siret', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _docusignAccountIdMeta =
      const VerificationMeta('docusignAccountId');
  @override
  late final GeneratedColumn<String> docusignAccountId =
      GeneratedColumn<String>('docusign_account_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _orderFormNextIncrementMeta =
      const VerificationMeta('orderFormNextIncrement');
  @override
  late final GeneratedColumn<int> orderFormNextIncrement = GeneratedColumn<int>(
      'order_form_next_increment', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _canAccessRepresentativeAppraisalModuleMeta =
      const VerificationMeta('canAccessRepresentativeAppraisalModule');
  @override
  late final GeneratedColumn<bool> canAccessRepresentativeAppraisalModule =
      GeneratedColumn<bool>(
          'can_access_representative_appraisal_module', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("can_access_representative_appraisal_module" IN (0, 1))'),
          defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        sageId,
        address1,
        address2,
        city,
        email,
        naf,
        phone,
        postalCode,
        siret,
        label,
        docusignAccountId,
        orderFormNextIncrement,
        canAccessRepresentativeAppraisalModule
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'agencies';
  @override
  VerificationContext validateIntegrity(Insertable<Agency> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('sage_id')) {
      context.handle(_sageIdMeta,
          sageId.isAcceptableOrUnknown(data['sage_id']!, _sageIdMeta));
    } else if (isInserting) {
      context.missing(_sageIdMeta);
    }
    if (data.containsKey('address1')) {
      context.handle(_address1Meta,
          address1.isAcceptableOrUnknown(data['address1']!, _address1Meta));
    } else if (isInserting) {
      context.missing(_address1Meta);
    }
    if (data.containsKey('address2')) {
      context.handle(_address2Meta,
          address2.isAcceptableOrUnknown(data['address2']!, _address2Meta));
    } else if (isInserting) {
      context.missing(_address2Meta);
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('naf')) {
      context.handle(
          _nafMeta, naf.isAcceptableOrUnknown(data['naf']!, _nafMeta));
    } else if (isInserting) {
      context.missing(_nafMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('postal_code')) {
      context.handle(
          _postalCodeMeta,
          postalCode.isAcceptableOrUnknown(
              data['postal_code']!, _postalCodeMeta));
    } else if (isInserting) {
      context.missing(_postalCodeMeta);
    }
    if (data.containsKey('siret')) {
      context.handle(
          _siretMeta, siret.isAcceptableOrUnknown(data['siret']!, _siretMeta));
    } else if (isInserting) {
      context.missing(_siretMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('docusign_account_id')) {
      context.handle(
          _docusignAccountIdMeta,
          docusignAccountId.isAcceptableOrUnknown(
              data['docusign_account_id']!, _docusignAccountIdMeta));
    }
    if (data.containsKey('order_form_next_increment')) {
      context.handle(
          _orderFormNextIncrementMeta,
          orderFormNextIncrement.isAcceptableOrUnknown(
              data['order_form_next_increment']!, _orderFormNextIncrementMeta));
    } else if (isInserting) {
      context.missing(_orderFormNextIncrementMeta);
    }
    if (data.containsKey('can_access_representative_appraisal_module')) {
      context.handle(
          _canAccessRepresentativeAppraisalModuleMeta,
          canAccessRepresentativeAppraisalModule.isAcceptableOrUnknown(
              data['can_access_representative_appraisal_module']!,
              _canAccessRepresentativeAppraisalModuleMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Agency map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Agency(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      sageId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sage_id'])!,
      address1: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address1'])!,
      address2: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address2'])!,
      city: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}city'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      naf: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}naf'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone'])!,
      postalCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}postal_code'])!,
      siret: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}siret'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      docusignAccountId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}docusign_account_id']),
      orderFormNextIncrement: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}order_form_next_increment'])!,
      canAccessRepresentativeAppraisalModule: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data[
              '${effectivePrefix}can_access_representative_appraisal_module'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $AgenciesTable createAlias(String alias) {
    return $AgenciesTable(attachedDatabase, alias);
  }
}

class AgenciesCompanion extends UpdateCompanion<Agency> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String> sageId;
  final Value<String> address1;
  final Value<String> address2;
  final Value<String> city;
  final Value<String> email;
  final Value<String> naf;
  final Value<String> phone;
  final Value<String> postalCode;
  final Value<String> siret;
  final Value<String> label;
  final Value<String?> docusignAccountId;
  final Value<int> orderFormNextIncrement;
  final Value<bool> canAccessRepresentativeAppraisalModule;
  final Value<int> rowid;
  const AgenciesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.sageId = const Value.absent(),
    this.address1 = const Value.absent(),
    this.address2 = const Value.absent(),
    this.city = const Value.absent(),
    this.email = const Value.absent(),
    this.naf = const Value.absent(),
    this.phone = const Value.absent(),
    this.postalCode = const Value.absent(),
    this.siret = const Value.absent(),
    this.label = const Value.absent(),
    this.docusignAccountId = const Value.absent(),
    this.orderFormNextIncrement = const Value.absent(),
    this.canAccessRepresentativeAppraisalModule = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AgenciesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String sageId,
    required String address1,
    required String address2,
    required String city,
    required String email,
    required String naf,
    required String phone,
    required String postalCode,
    required String siret,
    required String label,
    this.docusignAccountId = const Value.absent(),
    required int orderFormNextIncrement,
    this.canAccessRepresentativeAppraisalModule = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : sageId = Value(sageId),
        address1 = Value(address1),
        address2 = Value(address2),
        city = Value(city),
        email = Value(email),
        naf = Value(naf),
        phone = Value(phone),
        postalCode = Value(postalCode),
        siret = Value(siret),
        label = Value(label),
        orderFormNextIncrement = Value(orderFormNextIncrement);
  static Insertable<Agency> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? sageId,
    Expression<String>? address1,
    Expression<String>? address2,
    Expression<String>? city,
    Expression<String>? email,
    Expression<String>? naf,
    Expression<String>? phone,
    Expression<String>? postalCode,
    Expression<String>? siret,
    Expression<String>? label,
    Expression<String>? docusignAccountId,
    Expression<int>? orderFormNextIncrement,
    Expression<bool>? canAccessRepresentativeAppraisalModule,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (sageId != null) 'sage_id': sageId,
      if (address1 != null) 'address1': address1,
      if (address2 != null) 'address2': address2,
      if (city != null) 'city': city,
      if (email != null) 'email': email,
      if (naf != null) 'naf': naf,
      if (phone != null) 'phone': phone,
      if (postalCode != null) 'postal_code': postalCode,
      if (siret != null) 'siret': siret,
      if (label != null) 'label': label,
      if (docusignAccountId != null) 'docusign_account_id': docusignAccountId,
      if (orderFormNextIncrement != null)
        'order_form_next_increment': orderFormNextIncrement,
      if (canAccessRepresentativeAppraisalModule != null)
        'can_access_representative_appraisal_module':
            canAccessRepresentativeAppraisalModule,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AgenciesCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<String>? sageId,
      Value<String>? address1,
      Value<String>? address2,
      Value<String>? city,
      Value<String>? email,
      Value<String>? naf,
      Value<String>? phone,
      Value<String>? postalCode,
      Value<String>? siret,
      Value<String>? label,
      Value<String?>? docusignAccountId,
      Value<int>? orderFormNextIncrement,
      Value<bool>? canAccessRepresentativeAppraisalModule,
      Value<int>? rowid}) {
    return AgenciesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sageId: sageId ?? this.sageId,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      city: city ?? this.city,
      email: email ?? this.email,
      naf: naf ?? this.naf,
      phone: phone ?? this.phone,
      postalCode: postalCode ?? this.postalCode,
      siret: siret ?? this.siret,
      label: label ?? this.label,
      docusignAccountId: docusignAccountId ?? this.docusignAccountId,
      orderFormNextIncrement:
          orderFormNextIncrement ?? this.orderFormNextIncrement,
      canAccessRepresentativeAppraisalModule:
          canAccessRepresentativeAppraisalModule ??
              this.canAccessRepresentativeAppraisalModule,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (sageId.present) {
      map['sage_id'] = Variable<String>(sageId.value);
    }
    if (address1.present) {
      map['address1'] = Variable<String>(address1.value);
    }
    if (address2.present) {
      map['address2'] = Variable<String>(address2.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (naf.present) {
      map['naf'] = Variable<String>(naf.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (postalCode.present) {
      map['postal_code'] = Variable<String>(postalCode.value);
    }
    if (siret.present) {
      map['siret'] = Variable<String>(siret.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (docusignAccountId.present) {
      map['docusign_account_id'] = Variable<String>(docusignAccountId.value);
    }
    if (orderFormNextIncrement.present) {
      map['order_form_next_increment'] =
          Variable<int>(orderFormNextIncrement.value);
    }
    if (canAccessRepresentativeAppraisalModule.present) {
      map['can_access_representative_appraisal_module'] =
          Variable<bool>(canAccessRepresentativeAppraisalModule.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AgenciesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('sageId: $sageId, ')
          ..write('address1: $address1, ')
          ..write('address2: $address2, ')
          ..write('city: $city, ')
          ..write('email: $email, ')
          ..write('naf: $naf, ')
          ..write('phone: $phone, ')
          ..write('postalCode: $postalCode, ')
          ..write('siret: $siret, ')
          ..write('label: $label, ')
          ..write('docusignAccountId: $docusignAccountId, ')
          ..write('orderFormNextIncrement: $orderFormNextIncrement, ')
          ..write(
              'canAccessRepresentativeAppraisalModule: $canAccessRepresentativeAppraisalModule, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RepresentativesTable extends Representatives
    with TableInfo<$RepresentativesTable, Representative> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RepresentativesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => getIt<UuidUtilsInterface>().generate());
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _sageIdMeta = const VerificationMeta('sageId');
  @override
  late final GeneratedColumn<String> sageId = GeneratedColumn<String>(
      'sage_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _agencyIdMeta =
      const VerificationMeta('agencyId');
  @override
  late final GeneratedColumn<String> agencyId = GeneratedColumn<String>(
      'agency_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES agencies (id)'));
  static const VerificationMeta _firstNameMeta =
      const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
      'first_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastNameMeta =
      const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
      'last_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _profileCodeMeta =
      const VerificationMeta('profileCode');
  @override
  late final GeneratedColumn<int> profileCode = GeneratedColumn<int>(
      'profile_code', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _profileLabelMeta =
      const VerificationMeta('profileLabel');
  @override
  late final GeneratedColumn<String> profileLabel = GeneratedColumn<String>(
      'profile_label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'));
  static const VerificationMeta _canAccessCRMMeta =
      const VerificationMeta('canAccessCRM');
  @override
  late final GeneratedColumn<bool> canAccessCRM = GeneratedColumn<bool>(
      'can_access_c_r_m', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("can_access_c_r_m" IN (0, 1))'));
  static const VerificationMeta _canAccessFairMeta =
      const VerificationMeta('canAccessFair');
  @override
  late final GeneratedColumn<bool> canAccessFair = GeneratedColumn<bool>(
      'can_access_fair', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("can_access_fair" IN (0, 1))'));
  static const VerificationMeta _isDirectSaleMeta =
      const VerificationMeta('isDirectSale');
  @override
  late final GeneratedColumn<bool> isDirectSale = GeneratedColumn<bool>(
      'is_direct_sale', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_direct_sale" IN (0, 1))'));
  static const VerificationMeta _appVersionMeta =
      const VerificationMeta('appVersion');
  @override
  late final GeneratedColumn<String> appVersion = GeneratedColumn<String>(
      'app_version', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _probationaryPeriodValidationMeta =
      const VerificationMeta('probationaryPeriodValidation');
  @override
  late final GeneratedColumn<bool> probationaryPeriodValidation =
      GeneratedColumn<bool>(
          'probationary_period_validation', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("probationary_period_validation" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _corporateVehicleMeta =
      const VerificationMeta('corporateVehicle');
  @override
  late final GeneratedColumn<bool> corporateVehicle = GeneratedColumn<bool>(
      'corporate_vehicle', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("corporate_vehicle" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _twoMonthsWith3540BookedMeetingsMeta =
      const VerificationMeta('twoMonthsWith3540BookedMeetings');
  @override
  late final GeneratedColumn<bool> twoMonthsWith3540BookedMeetings =
      GeneratedColumn<bool>(
          'two_months_with3540_booked_meetings', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("two_months_with3540_booked_meetings" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _firstIntroductionBeforeMentorMeta =
      const VerificationMeta('firstIntroductionBeforeMentor');
  @override
  late final GeneratedColumn<bool> firstIntroductionBeforeMentor =
      GeneratedColumn<bool>(
          'first_introduction_before_mentor', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("first_introduction_before_mentor" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _twoMonthsWith15OpportunityRequestsMeta =
      const VerificationMeta('twoMonthsWith15OpportunityRequests');
  @override
  late final GeneratedColumn<bool> twoMonthsWith15OpportunityRequests =
      GeneratedColumn<bool>(
          'two_months_with15_opportunity_requests', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("two_months_with15_opportunity_requests" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _aloneOnFirstSaleMeta =
      const VerificationMeta('aloneOnFirstSale');
  @override
  late final GeneratedColumn<bool> aloneOnFirstSale = GeneratedColumn<bool>(
      'alone_on_first_sale', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("alone_on_first_sale" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _firstSaleAtFairMeta =
      const VerificationMeta('firstSaleAtFair');
  @override
  late final GeneratedColumn<bool> firstSaleAtFair = GeneratedColumn<bool>(
      'first_sale_at_fair', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("first_sale_at_fair" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _aloneOn4FundingSalesMeta =
      const VerificationMeta('aloneOn4FundingSales');
  @override
  late final GeneratedColumn<bool> aloneOn4FundingSales = GeneratedColumn<bool>(
      'alone_on4_funding_sales', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("alone_on4_funding_sales" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _twoMonthsWith20KTurnoverMeta =
      const VerificationMeta('twoMonthsWith20KTurnover');
  @override
  late final GeneratedColumn<bool> twoMonthsWith20KTurnover =
      GeneratedColumn<bool>(
          'two_months_with20_k_turnover', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("two_months_with20_k_turnover" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _aloneOnFirstAdditionalSaleMeta =
      const VerificationMeta('aloneOnFirstAdditionalSale');
  @override
  late final GeneratedColumn<bool> aloneOnFirstAdditionalSale =
      GeneratedColumn<bool>(
          'alone_on_first_additional_sale', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("alone_on_first_additional_sale" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _aloneOn30KOrMoreTurnoverInOneMonthMeta =
      const VerificationMeta('aloneOn30KOrMoreTurnoverInOneMonth');
  @override
  late final GeneratedColumn<bool> aloneOn30KOrMoreTurnoverInOneMonth =
      GeneratedColumn<bool>(
          'alone_on30_k_or_more_turnover_in_one_month', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("alone_on30_k_or_more_turnover_in_one_month" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _soldTwoProductsInOneSaleMeta =
      const VerificationMeta('soldTwoProductsInOneSale');
  @override
  late final GeneratedColumn<bool> soldTwoProductsInOneSale =
      GeneratedColumn<bool>(
          'sold_two_products_in_one_sale', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("sold_two_products_in_one_sale" IN (0, 1))'),
          defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        sageId,
        agencyId,
        firstName,
        lastName,
        email,
        phone,
        profileCode,
        profileLabel,
        isActive,
        canAccessCRM,
        canAccessFair,
        isDirectSale,
        appVersion,
        startDate,
        probationaryPeriodValidation,
        corporateVehicle,
        twoMonthsWith3540BookedMeetings,
        firstIntroductionBeforeMentor,
        twoMonthsWith15OpportunityRequests,
        aloneOnFirstSale,
        firstSaleAtFair,
        aloneOn4FundingSales,
        twoMonthsWith20KTurnover,
        aloneOnFirstAdditionalSale,
        aloneOn30KOrMoreTurnoverInOneMonth,
        soldTwoProductsInOneSale
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'representatives';
  @override
  VerificationContext validateIntegrity(Insertable<Representative> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('sage_id')) {
      context.handle(_sageIdMeta,
          sageId.isAcceptableOrUnknown(data['sage_id']!, _sageIdMeta));
    } else if (isInserting) {
      context.missing(_sageIdMeta);
    }
    if (data.containsKey('agency_id')) {
      context.handle(_agencyIdMeta,
          agencyId.isAcceptableOrUnknown(data['agency_id']!, _agencyIdMeta));
    } else if (isInserting) {
      context.missing(_agencyIdMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('profile_code')) {
      context.handle(
          _profileCodeMeta,
          profileCode.isAcceptableOrUnknown(
              data['profile_code']!, _profileCodeMeta));
    } else if (isInserting) {
      context.missing(_profileCodeMeta);
    }
    if (data.containsKey('profile_label')) {
      context.handle(
          _profileLabelMeta,
          profileLabel.isAcceptableOrUnknown(
              data['profile_label']!, _profileLabelMeta));
    } else if (isInserting) {
      context.missing(_profileLabelMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    } else if (isInserting) {
      context.missing(_isActiveMeta);
    }
    if (data.containsKey('can_access_c_r_m')) {
      context.handle(
          _canAccessCRMMeta,
          canAccessCRM.isAcceptableOrUnknown(
              data['can_access_c_r_m']!, _canAccessCRMMeta));
    } else if (isInserting) {
      context.missing(_canAccessCRMMeta);
    }
    if (data.containsKey('can_access_fair')) {
      context.handle(
          _canAccessFairMeta,
          canAccessFair.isAcceptableOrUnknown(
              data['can_access_fair']!, _canAccessFairMeta));
    } else if (isInserting) {
      context.missing(_canAccessFairMeta);
    }
    if (data.containsKey('is_direct_sale')) {
      context.handle(
          _isDirectSaleMeta,
          isDirectSale.isAcceptableOrUnknown(
              data['is_direct_sale']!, _isDirectSaleMeta));
    } else if (isInserting) {
      context.missing(_isDirectSaleMeta);
    }
    if (data.containsKey('app_version')) {
      context.handle(
          _appVersionMeta,
          appVersion.isAcceptableOrUnknown(
              data['app_version']!, _appVersionMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    }
    if (data.containsKey('probationary_period_validation')) {
      context.handle(
          _probationaryPeriodValidationMeta,
          probationaryPeriodValidation.isAcceptableOrUnknown(
              data['probationary_period_validation']!,
              _probationaryPeriodValidationMeta));
    }
    if (data.containsKey('corporate_vehicle')) {
      context.handle(
          _corporateVehicleMeta,
          corporateVehicle.isAcceptableOrUnknown(
              data['corporate_vehicle']!, _corporateVehicleMeta));
    }
    if (data.containsKey('two_months_with3540_booked_meetings')) {
      context.handle(
          _twoMonthsWith3540BookedMeetingsMeta,
          twoMonthsWith3540BookedMeetings.isAcceptableOrUnknown(
              data['two_months_with3540_booked_meetings']!,
              _twoMonthsWith3540BookedMeetingsMeta));
    }
    if (data.containsKey('first_introduction_before_mentor')) {
      context.handle(
          _firstIntroductionBeforeMentorMeta,
          firstIntroductionBeforeMentor.isAcceptableOrUnknown(
              data['first_introduction_before_mentor']!,
              _firstIntroductionBeforeMentorMeta));
    }
    if (data.containsKey('two_months_with15_opportunity_requests')) {
      context.handle(
          _twoMonthsWith15OpportunityRequestsMeta,
          twoMonthsWith15OpportunityRequests.isAcceptableOrUnknown(
              data['two_months_with15_opportunity_requests']!,
              _twoMonthsWith15OpportunityRequestsMeta));
    }
    if (data.containsKey('alone_on_first_sale')) {
      context.handle(
          _aloneOnFirstSaleMeta,
          aloneOnFirstSale.isAcceptableOrUnknown(
              data['alone_on_first_sale']!, _aloneOnFirstSaleMeta));
    }
    if (data.containsKey('first_sale_at_fair')) {
      context.handle(
          _firstSaleAtFairMeta,
          firstSaleAtFair.isAcceptableOrUnknown(
              data['first_sale_at_fair']!, _firstSaleAtFairMeta));
    }
    if (data.containsKey('alone_on4_funding_sales')) {
      context.handle(
          _aloneOn4FundingSalesMeta,
          aloneOn4FundingSales.isAcceptableOrUnknown(
              data['alone_on4_funding_sales']!, _aloneOn4FundingSalesMeta));
    }
    if (data.containsKey('two_months_with20_k_turnover')) {
      context.handle(
          _twoMonthsWith20KTurnoverMeta,
          twoMonthsWith20KTurnover.isAcceptableOrUnknown(
              data['two_months_with20_k_turnover']!,
              _twoMonthsWith20KTurnoverMeta));
    }
    if (data.containsKey('alone_on_first_additional_sale')) {
      context.handle(
          _aloneOnFirstAdditionalSaleMeta,
          aloneOnFirstAdditionalSale.isAcceptableOrUnknown(
              data['alone_on_first_additional_sale']!,
              _aloneOnFirstAdditionalSaleMeta));
    }
    if (data.containsKey('alone_on30_k_or_more_turnover_in_one_month')) {
      context.handle(
          _aloneOn30KOrMoreTurnoverInOneMonthMeta,
          aloneOn30KOrMoreTurnoverInOneMonth.isAcceptableOrUnknown(
              data['alone_on30_k_or_more_turnover_in_one_month']!,
              _aloneOn30KOrMoreTurnoverInOneMonthMeta));
    }
    if (data.containsKey('sold_two_products_in_one_sale')) {
      context.handle(
          _soldTwoProductsInOneSaleMeta,
          soldTwoProductsInOneSale.isAcceptableOrUnknown(
              data['sold_two_products_in_one_sale']!,
              _soldTwoProductsInOneSaleMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Representative map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Representative(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      sageId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sage_id'])!,
      agencyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}agency_id'])!,
      firstName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_name'])!,
      lastName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_name'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone'])!,
      profileCode: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}profile_code'])!,
      profileLabel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_label'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      canAccessCRM: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}can_access_c_r_m'])!,
      canAccessFair: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}can_access_fair'])!,
      isDirectSale: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_direct_sale'])!,
      appVersion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}app_version']),
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date']),
      probationaryPeriodValidation: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}probationary_period_validation'])!,
      corporateVehicle: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}corporate_vehicle'])!,
      twoMonthsWith3540BookedMeetings: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}two_months_with3540_booked_meetings'])!,
      firstIntroductionBeforeMentor: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}first_introduction_before_mentor'])!,
      twoMonthsWith15OpportunityRequests: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}two_months_with15_opportunity_requests'])!,
      aloneOnFirstSale: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}alone_on_first_sale'])!,
      firstSaleAtFair: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}first_sale_at_fair'])!,
      aloneOn4FundingSales: attachedDatabase.typeMapping.read(DriftSqlType.bool,
          data['${effectivePrefix}alone_on4_funding_sales'])!,
      twoMonthsWith20KTurnover: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}two_months_with20_k_turnover'])!,
      aloneOnFirstAdditionalSale: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}alone_on_first_additional_sale'])!,
      aloneOn30KOrMoreTurnoverInOneMonth: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data[
              '${effectivePrefix}alone_on30_k_or_more_turnover_in_one_month'])!,
      soldTwoProductsInOneSale: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}sold_two_products_in_one_sale'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $RepresentativesTable createAlias(String alias) {
    return $RepresentativesTable(attachedDatabase, alias);
  }
}

class RepresentativesCompanion extends UpdateCompanion<Representative> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String> sageId;
  final Value<String> agencyId;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> email;
  final Value<String> phone;
  final Value<int> profileCode;
  final Value<String> profileLabel;
  final Value<bool> isActive;
  final Value<bool> canAccessCRM;
  final Value<bool> canAccessFair;
  final Value<bool> isDirectSale;
  final Value<String?> appVersion;
  final Value<DateTime?> startDate;
  final Value<bool> probationaryPeriodValidation;
  final Value<bool> corporateVehicle;
  final Value<bool> twoMonthsWith3540BookedMeetings;
  final Value<bool> firstIntroductionBeforeMentor;
  final Value<bool> twoMonthsWith15OpportunityRequests;
  final Value<bool> aloneOnFirstSale;
  final Value<bool> firstSaleAtFair;
  final Value<bool> aloneOn4FundingSales;
  final Value<bool> twoMonthsWith20KTurnover;
  final Value<bool> aloneOnFirstAdditionalSale;
  final Value<bool> aloneOn30KOrMoreTurnoverInOneMonth;
  final Value<bool> soldTwoProductsInOneSale;
  final Value<int> rowid;
  const RepresentativesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.sageId = const Value.absent(),
    this.agencyId = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.profileCode = const Value.absent(),
    this.profileLabel = const Value.absent(),
    this.isActive = const Value.absent(),
    this.canAccessCRM = const Value.absent(),
    this.canAccessFair = const Value.absent(),
    this.isDirectSale = const Value.absent(),
    this.appVersion = const Value.absent(),
    this.startDate = const Value.absent(),
    this.probationaryPeriodValidation = const Value.absent(),
    this.corporateVehicle = const Value.absent(),
    this.twoMonthsWith3540BookedMeetings = const Value.absent(),
    this.firstIntroductionBeforeMentor = const Value.absent(),
    this.twoMonthsWith15OpportunityRequests = const Value.absent(),
    this.aloneOnFirstSale = const Value.absent(),
    this.firstSaleAtFair = const Value.absent(),
    this.aloneOn4FundingSales = const Value.absent(),
    this.twoMonthsWith20KTurnover = const Value.absent(),
    this.aloneOnFirstAdditionalSale = const Value.absent(),
    this.aloneOn30KOrMoreTurnoverInOneMonth = const Value.absent(),
    this.soldTwoProductsInOneSale = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RepresentativesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String sageId,
    required String agencyId,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required int profileCode,
    required String profileLabel,
    required bool isActive,
    required bool canAccessCRM,
    required bool canAccessFair,
    required bool isDirectSale,
    this.appVersion = const Value.absent(),
    this.startDate = const Value.absent(),
    this.probationaryPeriodValidation = const Value.absent(),
    this.corporateVehicle = const Value.absent(),
    this.twoMonthsWith3540BookedMeetings = const Value.absent(),
    this.firstIntroductionBeforeMentor = const Value.absent(),
    this.twoMonthsWith15OpportunityRequests = const Value.absent(),
    this.aloneOnFirstSale = const Value.absent(),
    this.firstSaleAtFair = const Value.absent(),
    this.aloneOn4FundingSales = const Value.absent(),
    this.twoMonthsWith20KTurnover = const Value.absent(),
    this.aloneOnFirstAdditionalSale = const Value.absent(),
    this.aloneOn30KOrMoreTurnoverInOneMonth = const Value.absent(),
    this.soldTwoProductsInOneSale = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : sageId = Value(sageId),
        agencyId = Value(agencyId),
        firstName = Value(firstName),
        lastName = Value(lastName),
        email = Value(email),
        phone = Value(phone),
        profileCode = Value(profileCode),
        profileLabel = Value(profileLabel),
        isActive = Value(isActive),
        canAccessCRM = Value(canAccessCRM),
        canAccessFair = Value(canAccessFair),
        isDirectSale = Value(isDirectSale);
  static Insertable<Representative> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? sageId,
    Expression<String>? agencyId,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<int>? profileCode,
    Expression<String>? profileLabel,
    Expression<bool>? isActive,
    Expression<bool>? canAccessCRM,
    Expression<bool>? canAccessFair,
    Expression<bool>? isDirectSale,
    Expression<String>? appVersion,
    Expression<DateTime>? startDate,
    Expression<bool>? probationaryPeriodValidation,
    Expression<bool>? corporateVehicle,
    Expression<bool>? twoMonthsWith3540BookedMeetings,
    Expression<bool>? firstIntroductionBeforeMentor,
    Expression<bool>? twoMonthsWith15OpportunityRequests,
    Expression<bool>? aloneOnFirstSale,
    Expression<bool>? firstSaleAtFair,
    Expression<bool>? aloneOn4FundingSales,
    Expression<bool>? twoMonthsWith20KTurnover,
    Expression<bool>? aloneOnFirstAdditionalSale,
    Expression<bool>? aloneOn30KOrMoreTurnoverInOneMonth,
    Expression<bool>? soldTwoProductsInOneSale,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (sageId != null) 'sage_id': sageId,
      if (agencyId != null) 'agency_id': agencyId,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (profileCode != null) 'profile_code': profileCode,
      if (profileLabel != null) 'profile_label': profileLabel,
      if (isActive != null) 'is_active': isActive,
      if (canAccessCRM != null) 'can_access_c_r_m': canAccessCRM,
      if (canAccessFair != null) 'can_access_fair': canAccessFair,
      if (isDirectSale != null) 'is_direct_sale': isDirectSale,
      if (appVersion != null) 'app_version': appVersion,
      if (startDate != null) 'start_date': startDate,
      if (probationaryPeriodValidation != null)
        'probationary_period_validation': probationaryPeriodValidation,
      if (corporateVehicle != null) 'corporate_vehicle': corporateVehicle,
      if (twoMonthsWith3540BookedMeetings != null)
        'two_months_with3540_booked_meetings': twoMonthsWith3540BookedMeetings,
      if (firstIntroductionBeforeMentor != null)
        'first_introduction_before_mentor': firstIntroductionBeforeMentor,
      if (twoMonthsWith15OpportunityRequests != null)
        'two_months_with15_opportunity_requests':
            twoMonthsWith15OpportunityRequests,
      if (aloneOnFirstSale != null) 'alone_on_first_sale': aloneOnFirstSale,
      if (firstSaleAtFair != null) 'first_sale_at_fair': firstSaleAtFair,
      if (aloneOn4FundingSales != null)
        'alone_on4_funding_sales': aloneOn4FundingSales,
      if (twoMonthsWith20KTurnover != null)
        'two_months_with20_k_turnover': twoMonthsWith20KTurnover,
      if (aloneOnFirstAdditionalSale != null)
        'alone_on_first_additional_sale': aloneOnFirstAdditionalSale,
      if (aloneOn30KOrMoreTurnoverInOneMonth != null)
        'alone_on30_k_or_more_turnover_in_one_month':
            aloneOn30KOrMoreTurnoverInOneMonth,
      if (soldTwoProductsInOneSale != null)
        'sold_two_products_in_one_sale': soldTwoProductsInOneSale,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RepresentativesCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<String>? sageId,
      Value<String>? agencyId,
      Value<String>? firstName,
      Value<String>? lastName,
      Value<String>? email,
      Value<String>? phone,
      Value<int>? profileCode,
      Value<String>? profileLabel,
      Value<bool>? isActive,
      Value<bool>? canAccessCRM,
      Value<bool>? canAccessFair,
      Value<bool>? isDirectSale,
      Value<String?>? appVersion,
      Value<DateTime?>? startDate,
      Value<bool>? probationaryPeriodValidation,
      Value<bool>? corporateVehicle,
      Value<bool>? twoMonthsWith3540BookedMeetings,
      Value<bool>? firstIntroductionBeforeMentor,
      Value<bool>? twoMonthsWith15OpportunityRequests,
      Value<bool>? aloneOnFirstSale,
      Value<bool>? firstSaleAtFair,
      Value<bool>? aloneOn4FundingSales,
      Value<bool>? twoMonthsWith20KTurnover,
      Value<bool>? aloneOnFirstAdditionalSale,
      Value<bool>? aloneOn30KOrMoreTurnoverInOneMonth,
      Value<bool>? soldTwoProductsInOneSale,
      Value<int>? rowid}) {
    return RepresentativesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (sageId.present) {
      map['sage_id'] = Variable<String>(sageId.value);
    }
    if (agencyId.present) {
      map['agency_id'] = Variable<String>(agencyId.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (profileCode.present) {
      map['profile_code'] = Variable<int>(profileCode.value);
    }
    if (profileLabel.present) {
      map['profile_label'] = Variable<String>(profileLabel.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (canAccessCRM.present) {
      map['can_access_c_r_m'] = Variable<bool>(canAccessCRM.value);
    }
    if (canAccessFair.present) {
      map['can_access_fair'] = Variable<bool>(canAccessFair.value);
    }
    if (isDirectSale.present) {
      map['is_direct_sale'] = Variable<bool>(isDirectSale.value);
    }
    if (appVersion.present) {
      map['app_version'] = Variable<String>(appVersion.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (probationaryPeriodValidation.present) {
      map['probationary_period_validation'] =
          Variable<bool>(probationaryPeriodValidation.value);
    }
    if (corporateVehicle.present) {
      map['corporate_vehicle'] = Variable<bool>(corporateVehicle.value);
    }
    if (twoMonthsWith3540BookedMeetings.present) {
      map['two_months_with3540_booked_meetings'] =
          Variable<bool>(twoMonthsWith3540BookedMeetings.value);
    }
    if (firstIntroductionBeforeMentor.present) {
      map['first_introduction_before_mentor'] =
          Variable<bool>(firstIntroductionBeforeMentor.value);
    }
    if (twoMonthsWith15OpportunityRequests.present) {
      map['two_months_with15_opportunity_requests'] =
          Variable<bool>(twoMonthsWith15OpportunityRequests.value);
    }
    if (aloneOnFirstSale.present) {
      map['alone_on_first_sale'] = Variable<bool>(aloneOnFirstSale.value);
    }
    if (firstSaleAtFair.present) {
      map['first_sale_at_fair'] = Variable<bool>(firstSaleAtFair.value);
    }
    if (aloneOn4FundingSales.present) {
      map['alone_on4_funding_sales'] =
          Variable<bool>(aloneOn4FundingSales.value);
    }
    if (twoMonthsWith20KTurnover.present) {
      map['two_months_with20_k_turnover'] =
          Variable<bool>(twoMonthsWith20KTurnover.value);
    }
    if (aloneOnFirstAdditionalSale.present) {
      map['alone_on_first_additional_sale'] =
          Variable<bool>(aloneOnFirstAdditionalSale.value);
    }
    if (aloneOn30KOrMoreTurnoverInOneMonth.present) {
      map['alone_on30_k_or_more_turnover_in_one_month'] =
          Variable<bool>(aloneOn30KOrMoreTurnoverInOneMonth.value);
    }
    if (soldTwoProductsInOneSale.present) {
      map['sold_two_products_in_one_sale'] =
          Variable<bool>(soldTwoProductsInOneSale.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RepresentativesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('sageId: $sageId, ')
          ..write('agencyId: $agencyId, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('profileCode: $profileCode, ')
          ..write('profileLabel: $profileLabel, ')
          ..write('isActive: $isActive, ')
          ..write('canAccessCRM: $canAccessCRM, ')
          ..write('canAccessFair: $canAccessFair, ')
          ..write('isDirectSale: $isDirectSale, ')
          ..write('appVersion: $appVersion, ')
          ..write('startDate: $startDate, ')
          ..write(
              'probationaryPeriodValidation: $probationaryPeriodValidation, ')
          ..write('corporateVehicle: $corporateVehicle, ')
          ..write(
              'twoMonthsWith3540BookedMeetings: $twoMonthsWith3540BookedMeetings, ')
          ..write(
              'firstIntroductionBeforeMentor: $firstIntroductionBeforeMentor, ')
          ..write(
              'twoMonthsWith15OpportunityRequests: $twoMonthsWith15OpportunityRequests, ')
          ..write('aloneOnFirstSale: $aloneOnFirstSale, ')
          ..write('firstSaleAtFair: $firstSaleAtFair, ')
          ..write('aloneOn4FundingSales: $aloneOn4FundingSales, ')
          ..write('twoMonthsWith20KTurnover: $twoMonthsWith20KTurnover, ')
          ..write('aloneOnFirstAdditionalSale: $aloneOnFirstAdditionalSale, ')
          ..write(
              'aloneOn30KOrMoreTurnoverInOneMonth: $aloneOn30KOrMoreTurnoverInOneMonth, ')
          ..write('soldTwoProductsInOneSale: $soldTwoProductsInOneSale, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => getIt<UuidUtilsInterface>().generate());
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _agencyIdMeta =
      const VerificationMeta('agencyId');
  @override
  late final GeneratedColumn<String> agencyId = GeneratedColumn<String>(
      'agency_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES agencies (id)'));
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isIndividualMeta =
      const VerificationMeta('isIndividual');
  @override
  late final GeneratedColumn<bool> isIndividual = GeneratedColumn<bool>(
      'is_individual', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_individual" IN (0, 1))'));
  static const VerificationMeta _customerSinceMeta =
      const VerificationMeta('customerSince');
  @override
  late final GeneratedColumn<DateTime> customerSince =
      GeneratedColumn<DateTime>('customer_since', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _signingMethodMeta =
      const VerificationMeta('signingMethod');
  @override
  late final GeneratedColumnWithTypeConverter<SigningMethod?, String>
      signingMethod = GeneratedColumn<String>(
              'signing_method', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<SigningMethod?>(
              $CustomersTable.$convertersigningMethodn);
  static const VerificationMeta _originMeta = const VerificationMeta('origin');
  @override
  late final GeneratedColumnWithTypeConverter<Origin?, String> origin =
      GeneratedColumn<String>('origin', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<Origin?>($CustomersTable.$converteroriginn);
  static const VerificationMeta _originDetailsMeta =
      const VerificationMeta('originDetails');
  @override
  late final GeneratedColumnWithTypeConverter<OriginDetails?, String>
      originDetails = GeneratedColumn<String>(
              'origin_details', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<OriginDetails?>(
              $CustomersTable.$converteroriginDetailsn);
  static const VerificationMeta _taxSystemMeta =
      const VerificationMeta('taxSystem');
  @override
  late final GeneratedColumnWithTypeConverter<TaxSystem, String> taxSystem =
      GeneratedColumn<String>('tax_system', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<TaxSystem>($CustomersTable.$convertertaxSystem);
  static const VerificationMeta _paymentTermsMeta =
      const VerificationMeta('paymentTerms');
  @override
  late final GeneratedColumnWithTypeConverter<PaymentTerms, String>
      paymentTerms = GeneratedColumn<String>(
              'payment_terms', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<PaymentTerms>($CustomersTable.$converterpaymentTerms);
  static const VerificationMeta _representative1IdMeta =
      const VerificationMeta('representative1Id');
  @override
  late final GeneratedColumn<String> representative1Id =
      GeneratedColumn<String>('representative1_id', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'REFERENCES representatives (id)'));
  static const VerificationMeta _representative2IdMeta =
      const VerificationMeta('representative2Id');
  @override
  late final GeneratedColumn<String> representative2Id =
      GeneratedColumn<String>('representative2_id', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'REFERENCES representatives (id)'));
  static const VerificationMeta _addressCodeMeta =
      const VerificationMeta('addressCode');
  @override
  late final GeneratedColumn<String> addressCode = GeneratedColumn<String>(
      'address_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addressLabelMeta =
      const VerificationMeta('addressLabel');
  @override
  late final GeneratedColumn<String> addressLabel = GeneratedColumn<String>(
      'address_label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addressAddress1Meta =
      const VerificationMeta('addressAddress1');
  @override
  late final GeneratedColumn<String> addressAddress1 = GeneratedColumn<String>(
      'address_address1', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addressAddress2Meta =
      const VerificationMeta('addressAddress2');
  @override
  late final GeneratedColumn<String> addressAddress2 = GeneratedColumn<String>(
      'address_address2', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addressPostalCodeMeta =
      const VerificationMeta('addressPostalCode');
  @override
  late final GeneratedColumn<String> addressPostalCode =
      GeneratedColumn<String>('address_postal_code', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addressCityMeta =
      const VerificationMeta('addressCity');
  @override
  late final GeneratedColumn<String> addressCity = GeneratedColumn<String>(
      'address_city', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addressCountryMeta =
      const VerificationMeta('addressCountry');
  @override
  late final GeneratedColumn<String> addressCountry = GeneratedColumn<String>(
      'address_country', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addressIsDefaultMeta =
      const VerificationMeta('addressIsDefault');
  @override
  late final GeneratedColumn<bool> addressIsDefault = GeneratedColumn<bool>(
      'address_is_default', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("address_is_default" IN (0, 1))'));
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, String> syncStatus =
      GeneratedColumn<String>('sync_status', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<SyncStatus>($CustomersTable.$convertersyncStatus);
  static const VerificationMeta _quoteFormNextIncrementMeta =
      const VerificationMeta('quoteFormNextIncrement');
  @override
  late final GeneratedColumn<int> quoteFormNextIncrement = GeneratedColumn<int>(
      'quote_form_next_increment', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _locationMeta =
      const VerificationMeta('location');
  @override
  late final GeneratedColumnWithTypeConverter<GeoPoint?, String> location =
      GeneratedColumn<String>('location', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<GeoPoint?>($CustomersTable.$converterlocationn);
  static const VerificationMeta _locationAlreadyFetchedMeta =
      const VerificationMeta('locationAlreadyFetched');
  @override
  late final GeneratedColumn<bool> locationAlreadyFetched =
      GeneratedColumn<bool>('location_already_fetched', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("location_already_fetched" IN (0, 1))'));
  static const VerificationMeta _searchableNameMeta =
      const VerificationMeta('searchableName');
  @override
  late final GeneratedColumn<String> searchableName = GeneratedColumn<String>(
      'searchable_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _searchableAddressMeta =
      const VerificationMeta('searchableAddress');
  @override
  late final GeneratedColumn<String> searchableAddress =
      GeneratedColumn<String>('searchable_address', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        agencyId,
        category,
        isActive,
        name,
        isIndividual,
        customerSince,
        signingMethod,
        origin,
        originDetails,
        taxSystem,
        paymentTerms,
        representative1Id,
        representative2Id,
        addressCode,
        addressLabel,
        addressAddress1,
        addressAddress2,
        addressPostalCode,
        addressCity,
        addressCountry,
        addressIsDefault,
        syncStatus,
        quoteFormNextIncrement,
        location,
        locationAlreadyFetched,
        searchableName,
        searchableAddress
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(Insertable<Customer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('agency_id')) {
      context.handle(_agencyIdMeta,
          agencyId.isAcceptableOrUnknown(data['agency_id']!, _agencyIdMeta));
    } else if (isInserting) {
      context.missing(_agencyIdMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    } else if (isInserting) {
      context.missing(_isActiveMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_individual')) {
      context.handle(
          _isIndividualMeta,
          isIndividual.isAcceptableOrUnknown(
              data['is_individual']!, _isIndividualMeta));
    } else if (isInserting) {
      context.missing(_isIndividualMeta);
    }
    if (data.containsKey('customer_since')) {
      context.handle(
          _customerSinceMeta,
          customerSince.isAcceptableOrUnknown(
              data['customer_since']!, _customerSinceMeta));
    } else if (isInserting) {
      context.missing(_customerSinceMeta);
    }
    context.handle(_signingMethodMeta, const VerificationResult.success());
    context.handle(_originMeta, const VerificationResult.success());
    context.handle(_originDetailsMeta, const VerificationResult.success());
    context.handle(_taxSystemMeta, const VerificationResult.success());
    context.handle(_paymentTermsMeta, const VerificationResult.success());
    if (data.containsKey('representative1_id')) {
      context.handle(
          _representative1IdMeta,
          representative1Id.isAcceptableOrUnknown(
              data['representative1_id']!, _representative1IdMeta));
    }
    if (data.containsKey('representative2_id')) {
      context.handle(
          _representative2IdMeta,
          representative2Id.isAcceptableOrUnknown(
              data['representative2_id']!, _representative2IdMeta));
    }
    if (data.containsKey('address_code')) {
      context.handle(
          _addressCodeMeta,
          addressCode.isAcceptableOrUnknown(
              data['address_code']!, _addressCodeMeta));
    } else if (isInserting) {
      context.missing(_addressCodeMeta);
    }
    if (data.containsKey('address_label')) {
      context.handle(
          _addressLabelMeta,
          addressLabel.isAcceptableOrUnknown(
              data['address_label']!, _addressLabelMeta));
    } else if (isInserting) {
      context.missing(_addressLabelMeta);
    }
    if (data.containsKey('address_address1')) {
      context.handle(
          _addressAddress1Meta,
          addressAddress1.isAcceptableOrUnknown(
              data['address_address1']!, _addressAddress1Meta));
    } else if (isInserting) {
      context.missing(_addressAddress1Meta);
    }
    if (data.containsKey('address_address2')) {
      context.handle(
          _addressAddress2Meta,
          addressAddress2.isAcceptableOrUnknown(
              data['address_address2']!, _addressAddress2Meta));
    } else if (isInserting) {
      context.missing(_addressAddress2Meta);
    }
    if (data.containsKey('address_postal_code')) {
      context.handle(
          _addressPostalCodeMeta,
          addressPostalCode.isAcceptableOrUnknown(
              data['address_postal_code']!, _addressPostalCodeMeta));
    } else if (isInserting) {
      context.missing(_addressPostalCodeMeta);
    }
    if (data.containsKey('address_city')) {
      context.handle(
          _addressCityMeta,
          addressCity.isAcceptableOrUnknown(
              data['address_city']!, _addressCityMeta));
    } else if (isInserting) {
      context.missing(_addressCityMeta);
    }
    if (data.containsKey('address_country')) {
      context.handle(
          _addressCountryMeta,
          addressCountry.isAcceptableOrUnknown(
              data['address_country']!, _addressCountryMeta));
    } else if (isInserting) {
      context.missing(_addressCountryMeta);
    }
    if (data.containsKey('address_is_default')) {
      context.handle(
          _addressIsDefaultMeta,
          addressIsDefault.isAcceptableOrUnknown(
              data['address_is_default']!, _addressIsDefaultMeta));
    } else if (isInserting) {
      context.missing(_addressIsDefaultMeta);
    }
    context.handle(_syncStatusMeta, const VerificationResult.success());
    if (data.containsKey('quote_form_next_increment')) {
      context.handle(
          _quoteFormNextIncrementMeta,
          quoteFormNextIncrement.isAcceptableOrUnknown(
              data['quote_form_next_increment']!, _quoteFormNextIncrementMeta));
    } else if (isInserting) {
      context.missing(_quoteFormNextIncrementMeta);
    }
    context.handle(_locationMeta, const VerificationResult.success());
    if (data.containsKey('location_already_fetched')) {
      context.handle(
          _locationAlreadyFetchedMeta,
          locationAlreadyFetched.isAcceptableOrUnknown(
              data['location_already_fetched']!, _locationAlreadyFetchedMeta));
    } else if (isInserting) {
      context.missing(_locationAlreadyFetchedMeta);
    }
    if (data.containsKey('searchable_name')) {
      context.handle(
          _searchableNameMeta,
          searchableName.isAcceptableOrUnknown(
              data['searchable_name']!, _searchableNameMeta));
    } else if (isInserting) {
      context.missing(_searchableNameMeta);
    }
    if (data.containsKey('searchable_address')) {
      context.handle(
          _searchableAddressMeta,
          searchableAddress.isAcceptableOrUnknown(
              data['searchable_address']!, _searchableAddressMeta));
    } else if (isInserting) {
      context.missing(_searchableAddressMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      agencyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}agency_id'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      isIndividual: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_individual'])!,
      customerSince: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}customer_since'])!,
      signingMethod: $CustomersTable.$convertersigningMethodn.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}signing_method'])),
      origin: $CustomersTable.$converteroriginn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}origin'])),
      originDetails: $CustomersTable.$converteroriginDetailsn.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}origin_details'])),
      taxSystem: $CustomersTable.$convertertaxSystem.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tax_system'])!),
      paymentTerms: $CustomersTable.$converterpaymentTerms.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}payment_terms'])!),
      representative1Id: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}representative1_id']),
      representative2Id: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}representative2_id']),
      addressCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address_code'])!,
      addressLabel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address_label'])!,
      addressAddress1: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}address_address1'])!,
      addressAddress2: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}address_address2'])!,
      addressPostalCode: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}address_postal_code'])!,
      addressCity: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address_city'])!,
      addressCountry: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}address_country'])!,
      addressIsDefault: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}address_is_default'])!,
      syncStatus: $CustomersTable.$convertersyncStatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!),
      quoteFormNextIncrement: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}quote_form_next_increment'])!,
      location: $CustomersTable.$converterlocationn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location'])),
      locationAlreadyFetched: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}location_already_fetched'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SigningMethod, String, String>
      $convertersigningMethod =
      const EnumNameConverter<SigningMethod>(SigningMethod.values);
  static JsonTypeConverter2<SigningMethod?, String?, String?>
      $convertersigningMethodn =
      JsonTypeConverter2.asNullable($convertersigningMethod);
  static JsonTypeConverter2<Origin, String, String> $converterorigin =
      const EnumNameConverter<Origin>(Origin.values);
  static JsonTypeConverter2<Origin?, String?, String?> $converteroriginn =
      JsonTypeConverter2.asNullable($converterorigin);
  static JsonTypeConverter2<OriginDetails, String, String>
      $converteroriginDetails =
      const EnumNameConverter<OriginDetails>(OriginDetails.values);
  static JsonTypeConverter2<OriginDetails?, String?, String?>
      $converteroriginDetailsn =
      JsonTypeConverter2.asNullable($converteroriginDetails);
  static JsonTypeConverter2<TaxSystem, String, String> $convertertaxSystem =
      const EnumNameConverter<TaxSystem>(TaxSystem.values);
  static JsonTypeConverter2<PaymentTerms, String, String>
      $converterpaymentTerms =
      const EnumNameConverter<PaymentTerms>(PaymentTerms.values);
  static JsonTypeConverter2<SyncStatus, String, String> $convertersyncStatus =
      const EnumNameConverter<SyncStatus>(SyncStatus.values);
  static TypeConverter<GeoPoint, String> $converterlocation =
      const GeoPointConverter();
  static TypeConverter<GeoPoint?, String?> $converterlocationn =
      NullAwareTypeConverter.wrap($converterlocation);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String> agencyId;
  final Value<String> category;
  final Value<bool> isActive;
  final Value<String> name;
  final Value<bool> isIndividual;
  final Value<DateTime> customerSince;
  final Value<SigningMethod?> signingMethod;
  final Value<Origin?> origin;
  final Value<OriginDetails?> originDetails;
  final Value<TaxSystem> taxSystem;
  final Value<PaymentTerms> paymentTerms;
  final Value<String?> representative1Id;
  final Value<String?> representative2Id;
  final Value<String> addressCode;
  final Value<String> addressLabel;
  final Value<String> addressAddress1;
  final Value<String> addressAddress2;
  final Value<String> addressPostalCode;
  final Value<String> addressCity;
  final Value<String> addressCountry;
  final Value<bool> addressIsDefault;
  final Value<SyncStatus> syncStatus;
  final Value<int> quoteFormNextIncrement;
  final Value<GeoPoint?> location;
  final Value<bool> locationAlreadyFetched;
  final Value<String> searchableName;
  final Value<String> searchableAddress;
  final Value<int> rowid;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.agencyId = const Value.absent(),
    this.category = const Value.absent(),
    this.isActive = const Value.absent(),
    this.name = const Value.absent(),
    this.isIndividual = const Value.absent(),
    this.customerSince = const Value.absent(),
    this.signingMethod = const Value.absent(),
    this.origin = const Value.absent(),
    this.originDetails = const Value.absent(),
    this.taxSystem = const Value.absent(),
    this.paymentTerms = const Value.absent(),
    this.representative1Id = const Value.absent(),
    this.representative2Id = const Value.absent(),
    this.addressCode = const Value.absent(),
    this.addressLabel = const Value.absent(),
    this.addressAddress1 = const Value.absent(),
    this.addressAddress2 = const Value.absent(),
    this.addressPostalCode = const Value.absent(),
    this.addressCity = const Value.absent(),
    this.addressCountry = const Value.absent(),
    this.addressIsDefault = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.quoteFormNextIncrement = const Value.absent(),
    this.location = const Value.absent(),
    this.locationAlreadyFetched = const Value.absent(),
    this.searchableName = const Value.absent(),
    this.searchableAddress = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String agencyId,
    required String category,
    required bool isActive,
    required String name,
    required bool isIndividual,
    required DateTime customerSince,
    this.signingMethod = const Value.absent(),
    this.origin = const Value.absent(),
    this.originDetails = const Value.absent(),
    required TaxSystem taxSystem,
    required PaymentTerms paymentTerms,
    this.representative1Id = const Value.absent(),
    this.representative2Id = const Value.absent(),
    required String addressCode,
    required String addressLabel,
    required String addressAddress1,
    required String addressAddress2,
    required String addressPostalCode,
    required String addressCity,
    required String addressCountry,
    required bool addressIsDefault,
    required SyncStatus syncStatus,
    required int quoteFormNextIncrement,
    this.location = const Value.absent(),
    required bool locationAlreadyFetched,
    required String searchableName,
    required String searchableAddress,
    this.rowid = const Value.absent(),
  })  : agencyId = Value(agencyId),
        category = Value(category),
        isActive = Value(isActive),
        name = Value(name),
        isIndividual = Value(isIndividual),
        customerSince = Value(customerSince),
        taxSystem = Value(taxSystem),
        paymentTerms = Value(paymentTerms),
        addressCode = Value(addressCode),
        addressLabel = Value(addressLabel),
        addressAddress1 = Value(addressAddress1),
        addressAddress2 = Value(addressAddress2),
        addressPostalCode = Value(addressPostalCode),
        addressCity = Value(addressCity),
        addressCountry = Value(addressCountry),
        addressIsDefault = Value(addressIsDefault),
        syncStatus = Value(syncStatus),
        quoteFormNextIncrement = Value(quoteFormNextIncrement),
        locationAlreadyFetched = Value(locationAlreadyFetched),
        searchableName = Value(searchableName),
        searchableAddress = Value(searchableAddress);
  static Insertable<Customer> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? agencyId,
    Expression<String>? category,
    Expression<bool>? isActive,
    Expression<String>? name,
    Expression<bool>? isIndividual,
    Expression<DateTime>? customerSince,
    Expression<String>? signingMethod,
    Expression<String>? origin,
    Expression<String>? originDetails,
    Expression<String>? taxSystem,
    Expression<String>? paymentTerms,
    Expression<String>? representative1Id,
    Expression<String>? representative2Id,
    Expression<String>? addressCode,
    Expression<String>? addressLabel,
    Expression<String>? addressAddress1,
    Expression<String>? addressAddress2,
    Expression<String>? addressPostalCode,
    Expression<String>? addressCity,
    Expression<String>? addressCountry,
    Expression<bool>? addressIsDefault,
    Expression<String>? syncStatus,
    Expression<int>? quoteFormNextIncrement,
    Expression<String>? location,
    Expression<bool>? locationAlreadyFetched,
    Expression<String>? searchableName,
    Expression<String>? searchableAddress,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (agencyId != null) 'agency_id': agencyId,
      if (category != null) 'category': category,
      if (isActive != null) 'is_active': isActive,
      if (name != null) 'name': name,
      if (isIndividual != null) 'is_individual': isIndividual,
      if (customerSince != null) 'customer_since': customerSince,
      if (signingMethod != null) 'signing_method': signingMethod,
      if (origin != null) 'origin': origin,
      if (originDetails != null) 'origin_details': originDetails,
      if (taxSystem != null) 'tax_system': taxSystem,
      if (paymentTerms != null) 'payment_terms': paymentTerms,
      if (representative1Id != null) 'representative1_id': representative1Id,
      if (representative2Id != null) 'representative2_id': representative2Id,
      if (addressCode != null) 'address_code': addressCode,
      if (addressLabel != null) 'address_label': addressLabel,
      if (addressAddress1 != null) 'address_address1': addressAddress1,
      if (addressAddress2 != null) 'address_address2': addressAddress2,
      if (addressPostalCode != null) 'address_postal_code': addressPostalCode,
      if (addressCity != null) 'address_city': addressCity,
      if (addressCountry != null) 'address_country': addressCountry,
      if (addressIsDefault != null) 'address_is_default': addressIsDefault,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (quoteFormNextIncrement != null)
        'quote_form_next_increment': quoteFormNextIncrement,
      if (location != null) 'location': location,
      if (locationAlreadyFetched != null)
        'location_already_fetched': locationAlreadyFetched,
      if (searchableName != null) 'searchable_name': searchableName,
      if (searchableAddress != null) 'searchable_address': searchableAddress,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomersCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<String>? agencyId,
      Value<String>? category,
      Value<bool>? isActive,
      Value<String>? name,
      Value<bool>? isIndividual,
      Value<DateTime>? customerSince,
      Value<SigningMethod?>? signingMethod,
      Value<Origin?>? origin,
      Value<OriginDetails?>? originDetails,
      Value<TaxSystem>? taxSystem,
      Value<PaymentTerms>? paymentTerms,
      Value<String?>? representative1Id,
      Value<String?>? representative2Id,
      Value<String>? addressCode,
      Value<String>? addressLabel,
      Value<String>? addressAddress1,
      Value<String>? addressAddress2,
      Value<String>? addressPostalCode,
      Value<String>? addressCity,
      Value<String>? addressCountry,
      Value<bool>? addressIsDefault,
      Value<SyncStatus>? syncStatus,
      Value<int>? quoteFormNextIncrement,
      Value<GeoPoint?>? location,
      Value<bool>? locationAlreadyFetched,
      Value<String>? searchableName,
      Value<String>? searchableAddress,
      Value<int>? rowid}) {
    return CustomersCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      agencyId: agencyId ?? this.agencyId,
      category: category ?? this.category,
      isActive: isActive ?? this.isActive,
      name: name ?? this.name,
      isIndividual: isIndividual ?? this.isIndividual,
      customerSince: customerSince ?? this.customerSince,
      signingMethod: signingMethod ?? this.signingMethod,
      origin: origin ?? this.origin,
      originDetails: originDetails ?? this.originDetails,
      taxSystem: taxSystem ?? this.taxSystem,
      paymentTerms: paymentTerms ?? this.paymentTerms,
      representative1Id: representative1Id ?? this.representative1Id,
      representative2Id: representative2Id ?? this.representative2Id,
      addressCode: addressCode ?? this.addressCode,
      addressLabel: addressLabel ?? this.addressLabel,
      addressAddress1: addressAddress1 ?? this.addressAddress1,
      addressAddress2: addressAddress2 ?? this.addressAddress2,
      addressPostalCode: addressPostalCode ?? this.addressPostalCode,
      addressCity: addressCity ?? this.addressCity,
      addressCountry: addressCountry ?? this.addressCountry,
      addressIsDefault: addressIsDefault ?? this.addressIsDefault,
      syncStatus: syncStatus ?? this.syncStatus,
      quoteFormNextIncrement:
          quoteFormNextIncrement ?? this.quoteFormNextIncrement,
      location: location ?? this.location,
      locationAlreadyFetched:
          locationAlreadyFetched ?? this.locationAlreadyFetched,
      searchableName: searchableName ?? this.searchableName,
      searchableAddress: searchableAddress ?? this.searchableAddress,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (agencyId.present) {
      map['agency_id'] = Variable<String>(agencyId.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isIndividual.present) {
      map['is_individual'] = Variable<bool>(isIndividual.value);
    }
    if (customerSince.present) {
      map['customer_since'] = Variable<DateTime>(customerSince.value);
    }
    if (signingMethod.present) {
      map['signing_method'] = Variable<String>(
          $CustomersTable.$convertersigningMethodn.toSql(signingMethod.value));
    }
    if (origin.present) {
      map['origin'] = Variable<String>(
          $CustomersTable.$converteroriginn.toSql(origin.value));
    }
    if (originDetails.present) {
      map['origin_details'] = Variable<String>(
          $CustomersTable.$converteroriginDetailsn.toSql(originDetails.value));
    }
    if (taxSystem.present) {
      map['tax_system'] = Variable<String>(
          $CustomersTable.$convertertaxSystem.toSql(taxSystem.value));
    }
    if (paymentTerms.present) {
      map['payment_terms'] = Variable<String>(
          $CustomersTable.$converterpaymentTerms.toSql(paymentTerms.value));
    }
    if (representative1Id.present) {
      map['representative1_id'] = Variable<String>(representative1Id.value);
    }
    if (representative2Id.present) {
      map['representative2_id'] = Variable<String>(representative2Id.value);
    }
    if (addressCode.present) {
      map['address_code'] = Variable<String>(addressCode.value);
    }
    if (addressLabel.present) {
      map['address_label'] = Variable<String>(addressLabel.value);
    }
    if (addressAddress1.present) {
      map['address_address1'] = Variable<String>(addressAddress1.value);
    }
    if (addressAddress2.present) {
      map['address_address2'] = Variable<String>(addressAddress2.value);
    }
    if (addressPostalCode.present) {
      map['address_postal_code'] = Variable<String>(addressPostalCode.value);
    }
    if (addressCity.present) {
      map['address_city'] = Variable<String>(addressCity.value);
    }
    if (addressCountry.present) {
      map['address_country'] = Variable<String>(addressCountry.value);
    }
    if (addressIsDefault.present) {
      map['address_is_default'] = Variable<bool>(addressIsDefault.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(
          $CustomersTable.$convertersyncStatus.toSql(syncStatus.value));
    }
    if (quoteFormNextIncrement.present) {
      map['quote_form_next_increment'] =
          Variable<int>(quoteFormNextIncrement.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(
          $CustomersTable.$converterlocationn.toSql(location.value));
    }
    if (locationAlreadyFetched.present) {
      map['location_already_fetched'] =
          Variable<bool>(locationAlreadyFetched.value);
    }
    if (searchableName.present) {
      map['searchable_name'] = Variable<String>(searchableName.value);
    }
    if (searchableAddress.present) {
      map['searchable_address'] = Variable<String>(searchableAddress.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('agencyId: $agencyId, ')
          ..write('category: $category, ')
          ..write('isActive: $isActive, ')
          ..write('name: $name, ')
          ..write('isIndividual: $isIndividual, ')
          ..write('customerSince: $customerSince, ')
          ..write('signingMethod: $signingMethod, ')
          ..write('origin: $origin, ')
          ..write('originDetails: $originDetails, ')
          ..write('taxSystem: $taxSystem, ')
          ..write('paymentTerms: $paymentTerms, ')
          ..write('representative1Id: $representative1Id, ')
          ..write('representative2Id: $representative2Id, ')
          ..write('addressCode: $addressCode, ')
          ..write('addressLabel: $addressLabel, ')
          ..write('addressAddress1: $addressAddress1, ')
          ..write('addressAddress2: $addressAddress2, ')
          ..write('addressPostalCode: $addressPostalCode, ')
          ..write('addressCity: $addressCity, ')
          ..write('addressCountry: $addressCountry, ')
          ..write('addressIsDefault: $addressIsDefault, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('quoteFormNextIncrement: $quoteFormNextIncrement, ')
          ..write('location: $location, ')
          ..write('locationAlreadyFetched: $locationAlreadyFetched, ')
          ..write('searchableName: $searchableName, ')
          ..write('searchableAddress: $searchableAddress, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ContactsTable extends Contacts with TableInfo<$ContactsTable, Contact> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => getIt<UuidUtilsInterface>().generate());
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _customerIdMeta =
      const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
      'customer_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES customers (id)'));
  static const VerificationMeta _agencyIdMeta =
      const VerificationMeta('agencyId');
  @override
  late final GeneratedColumn<String> agencyId = GeneratedColumn<String>(
      'agency_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES agencies (id)'));
  static const VerificationMeta _civilityMeta =
      const VerificationMeta('civility');
  @override
  late final GeneratedColumnWithTypeConverter<Civility, String> civility =
      GeneratedColumn<String>('civility', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Civility>($ContactsTable.$convertercivility);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastNameMeta =
      const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
      'last_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _firstNameMeta =
      const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
      'first_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _mobilePhoneMeta =
      const VerificationMeta('mobilePhone');
  @override
  late final GeneratedColumn<String> mobilePhone = GeneratedColumn<String>(
      'mobile_phone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isDefaultMeta =
      const VerificationMeta('isDefault');
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
      'is_default', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_default" IN (0, 1))'));
  static const VerificationMeta _sageIdMeta = const VerificationMeta('sageId');
  @override
  late final GeneratedColumn<String> sageId = GeneratedColumn<String>(
      'sage_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _searchableEmailMeta =
      const VerificationMeta('searchableEmail');
  @override
  late final GeneratedColumn<String> searchableEmail = GeneratedColumn<String>(
      'searchable_email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _searchablePhoneMeta =
      const VerificationMeta('searchablePhone');
  @override
  late final GeneratedColumn<String> searchablePhone = GeneratedColumn<String>(
      'searchable_phone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _searchablePhoneWithCodeMeta =
      const VerificationMeta('searchablePhoneWithCode');
  @override
  late final GeneratedColumn<String> searchablePhoneWithCode =
      GeneratedColumn<String>('searchable_phone_with_code', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _searchableMobilePhoneMeta =
      const VerificationMeta('searchableMobilePhone');
  @override
  late final GeneratedColumn<String> searchableMobilePhone =
      GeneratedColumn<String>('searchable_mobile_phone', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _searchableMobilePhoneWithCodeMeta =
      const VerificationMeta('searchableMobilePhoneWithCode');
  @override
  late final GeneratedColumn<String> searchableMobilePhoneWithCode =
      GeneratedColumn<String>(
          'searchable_mobile_phone_with_code', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        customerId,
        agencyId,
        civility,
        email,
        lastName,
        firstName,
        phone,
        mobilePhone,
        isDefault,
        sageId,
        searchableEmail,
        searchablePhone,
        searchablePhoneWithCode,
        searchableMobilePhone,
        searchableMobilePhoneWithCode
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contacts';
  @override
  VerificationContext validateIntegrity(Insertable<Contact> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id']!, _customerIdMeta));
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('agency_id')) {
      context.handle(_agencyIdMeta,
          agencyId.isAcceptableOrUnknown(data['agency_id']!, _agencyIdMeta));
    } else if (isInserting) {
      context.missing(_agencyIdMeta);
    }
    context.handle(_civilityMeta, const VerificationResult.success());
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('mobile_phone')) {
      context.handle(
          _mobilePhoneMeta,
          mobilePhone.isAcceptableOrUnknown(
              data['mobile_phone']!, _mobilePhoneMeta));
    } else if (isInserting) {
      context.missing(_mobilePhoneMeta);
    }
    if (data.containsKey('is_default')) {
      context.handle(_isDefaultMeta,
          isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta));
    } else if (isInserting) {
      context.missing(_isDefaultMeta);
    }
    if (data.containsKey('sage_id')) {
      context.handle(_sageIdMeta,
          sageId.isAcceptableOrUnknown(data['sage_id']!, _sageIdMeta));
    } else if (isInserting) {
      context.missing(_sageIdMeta);
    }
    if (data.containsKey('searchable_email')) {
      context.handle(
          _searchableEmailMeta,
          searchableEmail.isAcceptableOrUnknown(
              data['searchable_email']!, _searchableEmailMeta));
    } else if (isInserting) {
      context.missing(_searchableEmailMeta);
    }
    if (data.containsKey('searchable_phone')) {
      context.handle(
          _searchablePhoneMeta,
          searchablePhone.isAcceptableOrUnknown(
              data['searchable_phone']!, _searchablePhoneMeta));
    } else if (isInserting) {
      context.missing(_searchablePhoneMeta);
    }
    if (data.containsKey('searchable_phone_with_code')) {
      context.handle(
          _searchablePhoneWithCodeMeta,
          searchablePhoneWithCode.isAcceptableOrUnknown(
              data['searchable_phone_with_code']!,
              _searchablePhoneWithCodeMeta));
    } else if (isInserting) {
      context.missing(_searchablePhoneWithCodeMeta);
    }
    if (data.containsKey('searchable_mobile_phone')) {
      context.handle(
          _searchableMobilePhoneMeta,
          searchableMobilePhone.isAcceptableOrUnknown(
              data['searchable_mobile_phone']!, _searchableMobilePhoneMeta));
    } else if (isInserting) {
      context.missing(_searchableMobilePhoneMeta);
    }
    if (data.containsKey('searchable_mobile_phone_with_code')) {
      context.handle(
          _searchableMobilePhoneWithCodeMeta,
          searchableMobilePhoneWithCode.isAcceptableOrUnknown(
              data['searchable_mobile_phone_with_code']!,
              _searchableMobilePhoneWithCodeMeta));
    } else if (isInserting) {
      context.missing(_searchableMobilePhoneWithCodeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Contact map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Contact(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      customerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_id'])!,
      agencyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}agency_id'])!,
      civility: $ContactsTable.$convertercivility.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}civility'])!),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      firstName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_name'])!,
      lastName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_name'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone'])!,
      mobilePhone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mobile_phone'])!,
      isDefault: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_default'])!,
      sageId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sage_id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $ContactsTable createAlias(String alias) {
    return $ContactsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Civility, String, String> $convertercivility =
      const EnumNameConverter<Civility>(Civility.values);
}

class ContactsCompanion extends UpdateCompanion<Contact> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String> customerId;
  final Value<String> agencyId;
  final Value<Civility> civility;
  final Value<String> email;
  final Value<String> lastName;
  final Value<String> firstName;
  final Value<String> phone;
  final Value<String> mobilePhone;
  final Value<bool> isDefault;
  final Value<String> sageId;
  final Value<String> searchableEmail;
  final Value<String> searchablePhone;
  final Value<String> searchablePhoneWithCode;
  final Value<String> searchableMobilePhone;
  final Value<String> searchableMobilePhoneWithCode;
  final Value<int> rowid;
  const ContactsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.customerId = const Value.absent(),
    this.agencyId = const Value.absent(),
    this.civility = const Value.absent(),
    this.email = const Value.absent(),
    this.lastName = const Value.absent(),
    this.firstName = const Value.absent(),
    this.phone = const Value.absent(),
    this.mobilePhone = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.sageId = const Value.absent(),
    this.searchableEmail = const Value.absent(),
    this.searchablePhone = const Value.absent(),
    this.searchablePhoneWithCode = const Value.absent(),
    this.searchableMobilePhone = const Value.absent(),
    this.searchableMobilePhoneWithCode = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ContactsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String customerId,
    required String agencyId,
    required Civility civility,
    required String email,
    required String lastName,
    required String firstName,
    required String phone,
    required String mobilePhone,
    required bool isDefault,
    required String sageId,
    required String searchableEmail,
    required String searchablePhone,
    required String searchablePhoneWithCode,
    required String searchableMobilePhone,
    required String searchableMobilePhoneWithCode,
    this.rowid = const Value.absent(),
  })  : customerId = Value(customerId),
        agencyId = Value(agencyId),
        civility = Value(civility),
        email = Value(email),
        lastName = Value(lastName),
        firstName = Value(firstName),
        phone = Value(phone),
        mobilePhone = Value(mobilePhone),
        isDefault = Value(isDefault),
        sageId = Value(sageId),
        searchableEmail = Value(searchableEmail),
        searchablePhone = Value(searchablePhone),
        searchablePhoneWithCode = Value(searchablePhoneWithCode),
        searchableMobilePhone = Value(searchableMobilePhone),
        searchableMobilePhoneWithCode = Value(searchableMobilePhoneWithCode);
  static Insertable<Contact> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? customerId,
    Expression<String>? agencyId,
    Expression<String>? civility,
    Expression<String>? email,
    Expression<String>? lastName,
    Expression<String>? firstName,
    Expression<String>? phone,
    Expression<String>? mobilePhone,
    Expression<bool>? isDefault,
    Expression<String>? sageId,
    Expression<String>? searchableEmail,
    Expression<String>? searchablePhone,
    Expression<String>? searchablePhoneWithCode,
    Expression<String>? searchableMobilePhone,
    Expression<String>? searchableMobilePhoneWithCode,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (customerId != null) 'customer_id': customerId,
      if (agencyId != null) 'agency_id': agencyId,
      if (civility != null) 'civility': civility,
      if (email != null) 'email': email,
      if (lastName != null) 'last_name': lastName,
      if (firstName != null) 'first_name': firstName,
      if (phone != null) 'phone': phone,
      if (mobilePhone != null) 'mobile_phone': mobilePhone,
      if (isDefault != null) 'is_default': isDefault,
      if (sageId != null) 'sage_id': sageId,
      if (searchableEmail != null) 'searchable_email': searchableEmail,
      if (searchablePhone != null) 'searchable_phone': searchablePhone,
      if (searchablePhoneWithCode != null)
        'searchable_phone_with_code': searchablePhoneWithCode,
      if (searchableMobilePhone != null)
        'searchable_mobile_phone': searchableMobilePhone,
      if (searchableMobilePhoneWithCode != null)
        'searchable_mobile_phone_with_code': searchableMobilePhoneWithCode,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ContactsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<String>? customerId,
      Value<String>? agencyId,
      Value<Civility>? civility,
      Value<String>? email,
      Value<String>? lastName,
      Value<String>? firstName,
      Value<String>? phone,
      Value<String>? mobilePhone,
      Value<bool>? isDefault,
      Value<String>? sageId,
      Value<String>? searchableEmail,
      Value<String>? searchablePhone,
      Value<String>? searchablePhoneWithCode,
      Value<String>? searchableMobilePhone,
      Value<String>? searchableMobilePhoneWithCode,
      Value<int>? rowid}) {
    return ContactsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
      searchableEmail: searchableEmail ?? this.searchableEmail,
      searchablePhone: searchablePhone ?? this.searchablePhone,
      searchablePhoneWithCode:
          searchablePhoneWithCode ?? this.searchablePhoneWithCode,
      searchableMobilePhone:
          searchableMobilePhone ?? this.searchableMobilePhone,
      searchableMobilePhoneWithCode:
          searchableMobilePhoneWithCode ?? this.searchableMobilePhoneWithCode,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (agencyId.present) {
      map['agency_id'] = Variable<String>(agencyId.value);
    }
    if (civility.present) {
      map['civility'] = Variable<String>(
          $ContactsTable.$convertercivility.toSql(civility.value));
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (mobilePhone.present) {
      map['mobile_phone'] = Variable<String>(mobilePhone.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (sageId.present) {
      map['sage_id'] = Variable<String>(sageId.value);
    }
    if (searchableEmail.present) {
      map['searchable_email'] = Variable<String>(searchableEmail.value);
    }
    if (searchablePhone.present) {
      map['searchable_phone'] = Variable<String>(searchablePhone.value);
    }
    if (searchablePhoneWithCode.present) {
      map['searchable_phone_with_code'] =
          Variable<String>(searchablePhoneWithCode.value);
    }
    if (searchableMobilePhone.present) {
      map['searchable_mobile_phone'] =
          Variable<String>(searchableMobilePhone.value);
    }
    if (searchableMobilePhoneWithCode.present) {
      map['searchable_mobile_phone_with_code'] =
          Variable<String>(searchableMobilePhoneWithCode.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('customerId: $customerId, ')
          ..write('agencyId: $agencyId, ')
          ..write('civility: $civility, ')
          ..write('email: $email, ')
          ..write('lastName: $lastName, ')
          ..write('firstName: $firstName, ')
          ..write('phone: $phone, ')
          ..write('mobilePhone: $mobilePhone, ')
          ..write('isDefault: $isDefault, ')
          ..write('sageId: $sageId, ')
          ..write('searchableEmail: $searchableEmail, ')
          ..write('searchablePhone: $searchablePhone, ')
          ..write('searchablePhoneWithCode: $searchablePhoneWithCode, ')
          ..write('searchableMobilePhone: $searchableMobilePhone, ')
          ..write(
              'searchableMobilePhoneWithCode: $searchableMobilePhoneWithCode, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserSettingsTable extends UserSettings
    with TableInfo<$UserSettingsTable, UserSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => getIt<UuidUtilsInterface>().generate());
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _showEmailInOrderFormMeta =
      const VerificationMeta('showEmailInOrderForm');
  @override
  late final GeneratedColumn<bool> showEmailInOrderForm = GeneratedColumn<bool>(
      'show_email_in_order_form', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("show_email_in_order_form" IN (0, 1))'));
  static const VerificationMeta _showPhoneInOrderFormMeta =
      const VerificationMeta('showPhoneInOrderForm');
  @override
  late final GeneratedColumn<bool> showPhoneInOrderForm = GeneratedColumn<bool>(
      'show_phone_in_order_form', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("show_phone_in_order_form" IN (0, 1))'));
  static const VerificationMeta _appVersionMeta =
      const VerificationMeta('appVersion');
  @override
  late final GeneratedColumn<String> appVersion = GeneratedColumn<String>(
      'app_version', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        userId,
        showEmailInOrderForm,
        showPhoneInOrderForm,
        appVersion
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_settings';
  @override
  VerificationContext validateIntegrity(Insertable<UserSetting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('show_email_in_order_form')) {
      context.handle(
          _showEmailInOrderFormMeta,
          showEmailInOrderForm.isAcceptableOrUnknown(
              data['show_email_in_order_form']!, _showEmailInOrderFormMeta));
    } else if (isInserting) {
      context.missing(_showEmailInOrderFormMeta);
    }
    if (data.containsKey('show_phone_in_order_form')) {
      context.handle(
          _showPhoneInOrderFormMeta,
          showPhoneInOrderForm.isAcceptableOrUnknown(
              data['show_phone_in_order_form']!, _showPhoneInOrderFormMeta));
    } else if (isInserting) {
      context.missing(_showPhoneInOrderFormMeta);
    }
    if (data.containsKey('app_version')) {
      context.handle(
          _appVersionMeta,
          appVersion.isAcceptableOrUnknown(
              data['app_version']!, _appVersionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserSetting(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      showEmailInOrderForm: attachedDatabase.typeMapping.read(DriftSqlType.bool,
          data['${effectivePrefix}show_email_in_order_form'])!,
      showPhoneInOrderForm: attachedDatabase.typeMapping.read(DriftSqlType.bool,
          data['${effectivePrefix}show_phone_in_order_form'])!,
      appVersion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}app_version']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $UserSettingsTable createAlias(String alias) {
    return $UserSettingsTable(attachedDatabase, alias);
  }
}

class UserSettingsCompanion extends UpdateCompanion<UserSetting> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String> userId;
  final Value<bool> showEmailInOrderForm;
  final Value<bool> showPhoneInOrderForm;
  final Value<String?> appVersion;
  final Value<int> rowid;
  const UserSettingsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.userId = const Value.absent(),
    this.showEmailInOrderForm = const Value.absent(),
    this.showPhoneInOrderForm = const Value.absent(),
    this.appVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String userId,
    required bool showEmailInOrderForm,
    required bool showPhoneInOrderForm,
    this.appVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : userId = Value(userId),
        showEmailInOrderForm = Value(showEmailInOrderForm),
        showPhoneInOrderForm = Value(showPhoneInOrderForm);
  static Insertable<UserSetting> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? userId,
    Expression<bool>? showEmailInOrderForm,
    Expression<bool>? showPhoneInOrderForm,
    Expression<String>? appVersion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (userId != null) 'user_id': userId,
      if (showEmailInOrderForm != null)
        'show_email_in_order_form': showEmailInOrderForm,
      if (showPhoneInOrderForm != null)
        'show_phone_in_order_form': showPhoneInOrderForm,
      if (appVersion != null) 'app_version': appVersion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserSettingsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<String>? userId,
      Value<bool>? showEmailInOrderForm,
      Value<bool>? showPhoneInOrderForm,
      Value<String?>? appVersion,
      Value<int>? rowid}) {
    return UserSettingsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      showEmailInOrderForm: showEmailInOrderForm ?? this.showEmailInOrderForm,
      showPhoneInOrderForm: showPhoneInOrderForm ?? this.showPhoneInOrderForm,
      appVersion: appVersion ?? this.appVersion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (showEmailInOrderForm.present) {
      map['show_email_in_order_form'] =
          Variable<bool>(showEmailInOrderForm.value);
    }
    if (showPhoneInOrderForm.present) {
      map['show_phone_in_order_form'] =
          Variable<bool>(showPhoneInOrderForm.value);
    }
    if (appVersion.present) {
      map['app_version'] = Variable<String>(appVersion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserSettingsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('userId: $userId, ')
          ..write('showEmailInOrderForm: $showEmailInOrderForm, ')
          ..write('showPhoneInOrderForm: $showPhoneInOrderForm, ')
          ..write('appVersion: $appVersion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SuppliersTable extends Suppliers
    with TableInfo<$SuppliersTable, Supplier> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SuppliersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => getIt<UuidUtilsInterface>().generate());
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _sageIdMeta = const VerificationMeta('sageId');
  @override
  late final GeneratedColumn<String> sageId = GeneratedColumn<String>(
      'sage_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _siretMeta = const VerificationMeta('siret');
  @override
  late final GeneratedColumn<String> siret = GeneratedColumn<String>(
      'siret', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _postalCodeMeta =
      const VerificationMeta('postalCode');
  @override
  late final GeneratedColumn<String> postalCode = GeneratedColumn<String>(
      'postal_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
      'city', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _rgeCertificateNumberMeta =
      const VerificationMeta('rgeCertificateNumber');
  @override
  late final GeneratedColumn<String> rgeCertificateNumber =
      GeneratedColumn<String>('rge_certificate_number', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _rgeQualificationMeta =
      const VerificationMeta('rgeQualification');
  @override
  late final GeneratedColumn<String> rgeQualification = GeneratedColumn<String>(
      'rge_qualification', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _agencyIdMeta =
      const VerificationMeta('agencyId');
  @override
  late final GeneratedColumn<String> agencyId = GeneratedColumn<String>(
      'agency_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES agencies (id)'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        sageId,
        isActive,
        name,
        siret,
        address,
        postalCode,
        city,
        rgeCertificateNumber,
        startDate,
        endDate,
        rgeQualification,
        agencyId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'suppliers';
  @override
  VerificationContext validateIntegrity(Insertable<Supplier> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('sage_id')) {
      context.handle(_sageIdMeta,
          sageId.isAcceptableOrUnknown(data['sage_id']!, _sageIdMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('siret')) {
      context.handle(
          _siretMeta, siret.isAcceptableOrUnknown(data['siret']!, _siretMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('postal_code')) {
      context.handle(
          _postalCodeMeta,
          postalCode.isAcceptableOrUnknown(
              data['postal_code']!, _postalCodeMeta));
    } else if (isInserting) {
      context.missing(_postalCodeMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('rge_certificate_number')) {
      context.handle(
          _rgeCertificateNumberMeta,
          rgeCertificateNumber.isAcceptableOrUnknown(
              data['rge_certificate_number']!, _rgeCertificateNumberMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('rge_qualification')) {
      context.handle(
          _rgeQualificationMeta,
          rgeQualification.isAcceptableOrUnknown(
              data['rge_qualification']!, _rgeQualificationMeta));
    }
    if (data.containsKey('agency_id')) {
      context.handle(_agencyIdMeta,
          agencyId.isAcceptableOrUnknown(data['agency_id']!, _agencyIdMeta));
    } else if (isInserting) {
      context.missing(_agencyIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Supplier map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Supplier(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      sageId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sage_id']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      siret: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}siret']),
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      postalCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}postal_code'])!,
      city: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}city'])!,
      rgeCertificateNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}rge_certificate_number']),
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date']),
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date']),
      rgeQualification: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}rge_qualification']),
      agencyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}agency_id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $SuppliersTable createAlias(String alias) {
    return $SuppliersTable(attachedDatabase, alias);
  }
}

class SuppliersCompanion extends UpdateCompanion<Supplier> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String?> sageId;
  final Value<bool> isActive;
  final Value<String?> name;
  final Value<String?> siret;
  final Value<String?> address;
  final Value<String> postalCode;
  final Value<String> city;
  final Value<String?> rgeCertificateNumber;
  final Value<DateTime?> startDate;
  final Value<DateTime?> endDate;
  final Value<String?> rgeQualification;
  final Value<String> agencyId;
  final Value<int> rowid;
  const SuppliersCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.sageId = const Value.absent(),
    this.isActive = const Value.absent(),
    this.name = const Value.absent(),
    this.siret = const Value.absent(),
    this.address = const Value.absent(),
    this.postalCode = const Value.absent(),
    this.city = const Value.absent(),
    this.rgeCertificateNumber = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.rgeQualification = const Value.absent(),
    this.agencyId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SuppliersCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.sageId = const Value.absent(),
    this.isActive = const Value.absent(),
    this.name = const Value.absent(),
    this.siret = const Value.absent(),
    this.address = const Value.absent(),
    required String postalCode,
    required String city,
    this.rgeCertificateNumber = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.rgeQualification = const Value.absent(),
    required String agencyId,
    this.rowid = const Value.absent(),
  })  : postalCode = Value(postalCode),
        city = Value(city),
        agencyId = Value(agencyId);
  static Insertable<Supplier> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? sageId,
    Expression<bool>? isActive,
    Expression<String>? name,
    Expression<String>? siret,
    Expression<String>? address,
    Expression<String>? postalCode,
    Expression<String>? city,
    Expression<String>? rgeCertificateNumber,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? rgeQualification,
    Expression<String>? agencyId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (sageId != null) 'sage_id': sageId,
      if (isActive != null) 'is_active': isActive,
      if (name != null) 'name': name,
      if (siret != null) 'siret': siret,
      if (address != null) 'address': address,
      if (postalCode != null) 'postal_code': postalCode,
      if (city != null) 'city': city,
      if (rgeCertificateNumber != null)
        'rge_certificate_number': rgeCertificateNumber,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (rgeQualification != null) 'rge_qualification': rgeQualification,
      if (agencyId != null) 'agency_id': agencyId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SuppliersCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<String?>? sageId,
      Value<bool>? isActive,
      Value<String?>? name,
      Value<String?>? siret,
      Value<String?>? address,
      Value<String>? postalCode,
      Value<String>? city,
      Value<String?>? rgeCertificateNumber,
      Value<DateTime?>? startDate,
      Value<DateTime?>? endDate,
      Value<String?>? rgeQualification,
      Value<String>? agencyId,
      Value<int>? rowid}) {
    return SuppliersCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sageId: sageId ?? this.sageId,
      isActive: isActive ?? this.isActive,
      name: name ?? this.name,
      siret: siret ?? this.siret,
      address: address ?? this.address,
      postalCode: postalCode ?? this.postalCode,
      city: city ?? this.city,
      rgeCertificateNumber: rgeCertificateNumber ?? this.rgeCertificateNumber,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      rgeQualification: rgeQualification ?? this.rgeQualification,
      agencyId: agencyId ?? this.agencyId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (sageId.present) {
      map['sage_id'] = Variable<String>(sageId.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (siret.present) {
      map['siret'] = Variable<String>(siret.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (postalCode.present) {
      map['postal_code'] = Variable<String>(postalCode.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (rgeCertificateNumber.present) {
      map['rge_certificate_number'] =
          Variable<String>(rgeCertificateNumber.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (rgeQualification.present) {
      map['rge_qualification'] = Variable<String>(rgeQualification.value);
    }
    if (agencyId.present) {
      map['agency_id'] = Variable<String>(agencyId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SuppliersCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('sageId: $sageId, ')
          ..write('isActive: $isActive, ')
          ..write('name: $name, ')
          ..write('siret: $siret, ')
          ..write('address: $address, ')
          ..write('postalCode: $postalCode, ')
          ..write('city: $city, ')
          ..write('rgeCertificateNumber: $rgeCertificateNumber, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('rgeQualification: $rgeQualification, ')
          ..write('agencyId: $agencyId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ServiceFamiliesTable extends ServiceFamilies
    with TableInfo<$ServiceFamiliesTable, ServiceFamily> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServiceFamiliesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => getIt<UuidUtilsInterface>().generate());
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _backgroundImageMeta =
      const VerificationMeta('backgroundImage');
  @override
  late final GeneratedColumn<String> backgroundImage = GeneratedColumn<String>(
      'background_image', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isEnergyRelatedMeta =
      const VerificationMeta('isEnergyRelated');
  @override
  late final GeneratedColumn<bool> isEnergyRelated = GeneratedColumn<bool>(
      'is_energy_related', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_energy_related" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        label,
        backgroundImage,
        icon,
        isEnergyRelated,
        position
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'service_families';
  @override
  VerificationContext validateIntegrity(Insertable<ServiceFamily> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('background_image')) {
      context.handle(
          _backgroundImageMeta,
          backgroundImage.isAcceptableOrUnknown(
              data['background_image']!, _backgroundImageMeta));
    } else if (isInserting) {
      context.missing(_backgroundImageMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('is_energy_related')) {
      context.handle(
          _isEnergyRelatedMeta,
          isEnergyRelated.isAcceptableOrUnknown(
              data['is_energy_related']!, _isEnergyRelatedMeta));
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServiceFamily map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServiceFamily(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      backgroundImage: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}background_image'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
      isEnergyRelated: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}is_energy_related'])!,
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $ServiceFamiliesTable createAlias(String alias) {
    return $ServiceFamiliesTable(attachedDatabase, alias);
  }
}

class ServiceFamiliesCompanion extends UpdateCompanion<ServiceFamily> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String> label;
  final Value<String> backgroundImage;
  final Value<String> icon;
  final Value<bool> isEnergyRelated;
  final Value<int> position;
  final Value<int> rowid;
  const ServiceFamiliesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.label = const Value.absent(),
    this.backgroundImage = const Value.absent(),
    this.icon = const Value.absent(),
    this.isEnergyRelated = const Value.absent(),
    this.position = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ServiceFamiliesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String label,
    required String backgroundImage,
    required String icon,
    this.isEnergyRelated = const Value.absent(),
    required int position,
    this.rowid = const Value.absent(),
  })  : label = Value(label),
        backgroundImage = Value(backgroundImage),
        icon = Value(icon),
        position = Value(position);
  static Insertable<ServiceFamily> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? label,
    Expression<String>? backgroundImage,
    Expression<String>? icon,
    Expression<bool>? isEnergyRelated,
    Expression<int>? position,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (label != null) 'label': label,
      if (backgroundImage != null) 'background_image': backgroundImage,
      if (icon != null) 'icon': icon,
      if (isEnergyRelated != null) 'is_energy_related': isEnergyRelated,
      if (position != null) 'position': position,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ServiceFamiliesCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<String>? label,
      Value<String>? backgroundImage,
      Value<String>? icon,
      Value<bool>? isEnergyRelated,
      Value<int>? position,
      Value<int>? rowid}) {
    return ServiceFamiliesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      label: label ?? this.label,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      icon: icon ?? this.icon,
      isEnergyRelated: isEnergyRelated ?? this.isEnergyRelated,
      position: position ?? this.position,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (backgroundImage.present) {
      map['background_image'] = Variable<String>(backgroundImage.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (isEnergyRelated.present) {
      map['is_energy_related'] = Variable<bool>(isEnergyRelated.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServiceFamiliesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('label: $label, ')
          ..write('backgroundImage: $backgroundImage, ')
          ..write('icon: $icon, ')
          ..write('isEnergyRelated: $isEnergyRelated, ')
          ..write('position: $position, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ServiceSubFamiliesTable extends ServiceSubFamilies
    with TableInfo<$ServiceSubFamiliesTable, ServiceSubFamily> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServiceSubFamiliesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => getIt<UuidUtilsInterface>().generate());
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _familyIdMeta =
      const VerificationMeta('familyId');
  @override
  late final GeneratedColumn<String> familyId = GeneratedColumn<String>(
      'family_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES service_families (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, createdAt, updatedAt, label, familyId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'service_sub_families';
  @override
  VerificationContext validateIntegrity(Insertable<ServiceSubFamily> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('family_id')) {
      context.handle(_familyIdMeta,
          familyId.isAcceptableOrUnknown(data['family_id']!, _familyIdMeta));
    } else if (isInserting) {
      context.missing(_familyIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServiceSubFamily map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServiceSubFamily(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      familyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}family_id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $ServiceSubFamiliesTable createAlias(String alias) {
    return $ServiceSubFamiliesTable(attachedDatabase, alias);
  }
}

class ServiceSubFamiliesCompanion extends UpdateCompanion<ServiceSubFamily> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String> label;
  final Value<String> familyId;
  final Value<int> rowid;
  const ServiceSubFamiliesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.label = const Value.absent(),
    this.familyId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ServiceSubFamiliesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String label,
    required String familyId,
    this.rowid = const Value.absent(),
  })  : label = Value(label),
        familyId = Value(familyId);
  static Insertable<ServiceSubFamily> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? label,
    Expression<String>? familyId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (label != null) 'label': label,
      if (familyId != null) 'family_id': familyId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ServiceSubFamiliesCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<String>? label,
      Value<String>? familyId,
      Value<int>? rowid}) {
    return ServiceSubFamiliesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      label: label ?? this.label,
      familyId: familyId ?? this.familyId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (familyId.present) {
      map['family_id'] = Variable<String>(familyId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServiceSubFamiliesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('label: $label, ')
          ..write('familyId: $familyId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FileDataFamiliesTable extends FileDataFamilies
    with TableInfo<$FileDataFamiliesTable, FileDataFamily> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FileDataFamiliesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => getIt<UuidUtilsInterface>().generate());
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _backgroundImageMeta =
      const VerificationMeta('backgroundImage');
  @override
  late final GeneratedColumn<String> backgroundImage = GeneratedColumn<String>(
      'background_image', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, createdAt, updatedAt, label, backgroundImage, icon];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'file_data_families';
  @override
  VerificationContext validateIntegrity(Insertable<FileDataFamily> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('background_image')) {
      context.handle(
          _backgroundImageMeta,
          backgroundImage.isAcceptableOrUnknown(
              data['background_image']!, _backgroundImageMeta));
    } else if (isInserting) {
      context.missing(_backgroundImageMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FileDataFamily map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FileDataFamily(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      backgroundImage: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}background_image'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $FileDataFamiliesTable createAlias(String alias) {
    return $FileDataFamiliesTable(attachedDatabase, alias);
  }
}

class FileDataFamiliesCompanion extends UpdateCompanion<FileDataFamily> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String> label;
  final Value<String> backgroundImage;
  final Value<String> icon;
  final Value<int> rowid;
  const FileDataFamiliesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.label = const Value.absent(),
    this.backgroundImage = const Value.absent(),
    this.icon = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FileDataFamiliesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String label,
    required String backgroundImage,
    required String icon,
    this.rowid = const Value.absent(),
  })  : label = Value(label),
        backgroundImage = Value(backgroundImage),
        icon = Value(icon);
  static Insertable<FileDataFamily> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? label,
    Expression<String>? backgroundImage,
    Expression<String>? icon,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (label != null) 'label': label,
      if (backgroundImage != null) 'background_image': backgroundImage,
      if (icon != null) 'icon': icon,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FileDataFamiliesCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<String>? label,
      Value<String>? backgroundImage,
      Value<String>? icon,
      Value<int>? rowid}) {
    return FileDataFamiliesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      label: label ?? this.label,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      icon: icon ?? this.icon,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (backgroundImage.present) {
      map['background_image'] = Variable<String>(backgroundImage.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FileDataFamiliesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('label: $label, ')
          ..write('backgroundImage: $backgroundImage, ')
          ..write('icon: $icon, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FairsTable extends Fairs with TableInfo<$FairsTable, Fair> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FairsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => getIt<UuidUtilsInterface>().generate());
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _openingDateMeta =
      const VerificationMeta('openingDate');
  @override
  late final GeneratedColumn<DateTime> openingDate = GeneratedColumn<DateTime>(
      'opening_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _closingDateMeta =
      const VerificationMeta('closingDate');
  @override
  late final GeneratedColumn<DateTime> closingDate = GeneratedColumn<DateTime>(
      'closing_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
      'city', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _agencyIdMeta =
      const VerificationMeta('agencyId');
  @override
  late final GeneratedColumn<String> agencyId = GeneratedColumn<String>(
      'agency_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES agencies (id)'));
  static const VerificationMeta _isCurrentMeta =
      const VerificationMeta('isCurrent');
  @override
  late final GeneratedColumn<bool> isCurrent = GeneratedColumn<bool>(
      'is_current', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_current" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        label,
        openingDate,
        closingDate,
        city,
        agencyId,
        isCurrent
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fairs';
  @override
  VerificationContext validateIntegrity(Insertable<Fair> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('opening_date')) {
      context.handle(
          _openingDateMeta,
          openingDate.isAcceptableOrUnknown(
              data['opening_date']!, _openingDateMeta));
    } else if (isInserting) {
      context.missing(_openingDateMeta);
    }
    if (data.containsKey('closing_date')) {
      context.handle(
          _closingDateMeta,
          closingDate.isAcceptableOrUnknown(
              data['closing_date']!, _closingDateMeta));
    } else if (isInserting) {
      context.missing(_closingDateMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('agency_id')) {
      context.handle(_agencyIdMeta,
          agencyId.isAcceptableOrUnknown(data['agency_id']!, _agencyIdMeta));
    } else if (isInserting) {
      context.missing(_agencyIdMeta);
    }
    if (data.containsKey('is_current')) {
      context.handle(_isCurrentMeta,
          isCurrent.isAcceptableOrUnknown(data['is_current']!, _isCurrentMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Fair map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Fair(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      openingDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}opening_date'])!,
      closingDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}closing_date'])!,
      city: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}city'])!,
      agencyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}agency_id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $FairsTable createAlias(String alias) {
    return $FairsTable(attachedDatabase, alias);
  }
}

class FairsCompanion extends UpdateCompanion<Fair> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String> label;
  final Value<DateTime> openingDate;
  final Value<DateTime> closingDate;
  final Value<String> city;
  final Value<String> agencyId;
  final Value<bool> isCurrent;
  final Value<int> rowid;
  const FairsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.label = const Value.absent(),
    this.openingDate = const Value.absent(),
    this.closingDate = const Value.absent(),
    this.city = const Value.absent(),
    this.agencyId = const Value.absent(),
    this.isCurrent = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FairsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String label,
    required DateTime openingDate,
    required DateTime closingDate,
    required String city,
    required String agencyId,
    this.isCurrent = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : label = Value(label),
        openingDate = Value(openingDate),
        closingDate = Value(closingDate),
        city = Value(city),
        agencyId = Value(agencyId);
  static Insertable<Fair> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? label,
    Expression<DateTime>? openingDate,
    Expression<DateTime>? closingDate,
    Expression<String>? city,
    Expression<String>? agencyId,
    Expression<bool>? isCurrent,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (label != null) 'label': label,
      if (openingDate != null) 'opening_date': openingDate,
      if (closingDate != null) 'closing_date': closingDate,
      if (city != null) 'city': city,
      if (agencyId != null) 'agency_id': agencyId,
      if (isCurrent != null) 'is_current': isCurrent,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FairsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<String>? label,
      Value<DateTime>? openingDate,
      Value<DateTime>? closingDate,
      Value<String>? city,
      Value<String>? agencyId,
      Value<bool>? isCurrent,
      Value<int>? rowid}) {
    return FairsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      label: label ?? this.label,
      openingDate: openingDate ?? this.openingDate,
      closingDate: closingDate ?? this.closingDate,
      city: city ?? this.city,
      agencyId: agencyId ?? this.agencyId,
      isCurrent: isCurrent ?? this.isCurrent,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (openingDate.present) {
      map['opening_date'] = Variable<DateTime>(openingDate.value);
    }
    if (closingDate.present) {
      map['closing_date'] = Variable<DateTime>(closingDate.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (agencyId.present) {
      map['agency_id'] = Variable<String>(agencyId.value);
    }
    if (isCurrent.present) {
      map['is_current'] = Variable<bool>(isCurrent.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FairsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('label: $label, ')
          ..write('openingDate: $openingDate, ')
          ..write('closingDate: $closingDate, ')
          ..write('city: $city, ')
          ..write('agencyId: $agencyId, ')
          ..write('isCurrent: $isCurrent, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OrdersTable extends Orders with TableInfo<$OrdersTable, Order> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => getIt<UuidUtilsInterface>().generate());
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _agencyIdMeta =
      const VerificationMeta('agencyId');
  @override
  late final GeneratedColumn<String> agencyId = GeneratedColumn<String>(
      'agency_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES agencies (id)'));
  static const VerificationMeta _customerIdMeta =
      const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
      'customer_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES customers (id)'));
  static const VerificationMeta _fairIdMeta = const VerificationMeta('fairId');
  @override
  late final GeneratedColumn<String> fairId = GeneratedColumn<String>(
      'fair_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES fairs (id)'));
  static const VerificationMeta _representative1IdMeta =
      const VerificationMeta('representative1Id');
  @override
  late final GeneratedColumn<String> representative1Id =
      GeneratedColumn<String>('representative1_id', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'REFERENCES representatives (id)'));
  static const VerificationMeta _representative2IdMeta =
      const VerificationMeta('representative2Id');
  @override
  late final GeneratedColumn<String> representative2Id =
      GeneratedColumn<String>('representative2_id', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'REFERENCES representatives (id)'));
  static const VerificationMeta _representative3IdMeta =
      const VerificationMeta('representative3Id');
  @override
  late final GeneratedColumn<String> representative3Id =
      GeneratedColumn<String>('representative3_id', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'REFERENCES representatives (id)'));
  static const VerificationMeta _address1Meta =
      const VerificationMeta('address1');
  @override
  late final GeneratedColumn<String> address1 = GeneratedColumn<String>(
      'address1', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _address2Meta =
      const VerificationMeta('address2');
  @override
  late final GeneratedColumn<String> address2 = GeneratedColumn<String>(
      'address2', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _addressCodeMeta =
      const VerificationMeta('addressCode');
  @override
  late final GeneratedColumn<String> addressCode = GeneratedColumn<String>(
      'address_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
      'city', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _postalCodeMeta =
      const VerificationMeta('postalCode');
  @override
  late final GeneratedColumn<String> postalCode = GeneratedColumn<String>(
      'postal_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountHTMeta =
      const VerificationMeta('amountHT');
  @override
  late final GeneratedColumn<double> amountHT = GeneratedColumn<double>(
      'amount_h_t', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _amountTTCMeta =
      const VerificationMeta('amountTTC');
  @override
  late final GeneratedColumn<double> amountTTC = GeneratedColumn<double>(
      'amount_t_t_c', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _intermediatePaymentPercentageMeta =
      const VerificationMeta('intermediatePaymentPercentage');
  @override
  late final GeneratedColumn<int> intermediatePaymentPercentage =
      GeneratedColumn<int>('intermediate_payment_percentage', aliasedName, true,
          type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _creditAmountMeta =
      const VerificationMeta('creditAmount');
  @override
  late final GeneratedColumn<double> creditAmount = GeneratedColumn<double>(
      'credit_amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _creditTotalCostMeta =
      const VerificationMeta('creditTotalCost');
  @override
  late final GeneratedColumn<double> creditTotalCost = GeneratedColumn<double>(
      'credit_total_cost', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _depositAmountMeta =
      const VerificationMeta('depositAmount');
  @override
  late final GeneratedColumn<double> depositAmount = GeneratedColumn<double>(
      'deposit_amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _fundingStatusMeta =
      const VerificationMeta('fundingStatus');
  @override
  late final GeneratedColumnWithTypeConverter<FundingStatus?, String>
      fundingStatus = GeneratedColumn<String>(
              'funding_status', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<FundingStatus?>($OrdersTable.$converterfundingStatusn);
  static const VerificationMeta _insuranceTypeMeta =
      const VerificationMeta('insuranceType');
  @override
  late final GeneratedColumnWithTypeConverter<InsuranceType, String>
      insuranceType = GeneratedColumn<String>(
              'insurance_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<InsuranceType>($OrdersTable.$converterinsuranceType);
  static const VerificationMeta _monthlyPaymentAmountMeta =
      const VerificationMeta('monthlyPaymentAmount');
  @override
  late final GeneratedColumn<double> monthlyPaymentAmount =
      GeneratedColumn<double>('monthly_payment_amount', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _monthlyPaymentsCountMeta =
      const VerificationMeta('monthlyPaymentsCount');
  @override
  late final GeneratedColumn<int> monthlyPaymentsCount = GeneratedColumn<int>(
      'monthly_payments_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nominalRateMeta =
      const VerificationMeta('nominalRate');
  @override
  late final GeneratedColumn<double> nominalRate = GeneratedColumn<double>(
      'nominal_rate', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _orderFormIdMeta =
      const VerificationMeta('orderFormId');
  @override
  late final GeneratedColumn<String> orderFormId = GeneratedColumn<String>(
      'order_form_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderTypeMeta =
      const VerificationMeta('orderType');
  @override
  late final GeneratedColumnWithTypeConverter<OrderType, String> orderType =
      GeneratedColumn<String>('order_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<OrderType>($OrdersTable.$converterorderType);
  static const VerificationMeta _originMeta = const VerificationMeta('origin');
  @override
  late final GeneratedColumnWithTypeConverter<Origin?, String> origin =
      GeneratedColumn<String>('origin', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<Origin?>($OrdersTable.$converteroriginn);
  static const VerificationMeta _originDetailsMeta =
      const VerificationMeta('originDetails');
  @override
  late final GeneratedColumnWithTypeConverter<OriginDetails?, String>
      originDetails = GeneratedColumn<String>(
              'origin_details', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<OriginDetails?>($OrdersTable.$converteroriginDetailsn);
  static const VerificationMeta _paymentTermsMeta =
      const VerificationMeta('paymentTerms');
  @override
  late final GeneratedColumnWithTypeConverter<PaymentTerms, String>
      paymentTerms = GeneratedColumn<String>(
              'payment_terms', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<PaymentTerms>($OrdersTable.$converterpaymentTerms);
  static const VerificationMeta _installAtMeta =
      const VerificationMeta('installAt');
  @override
  late final GeneratedColumn<DateTime> installAt = GeneratedColumn<DateTime>(
      'install_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _endProjectAtMeta =
      const VerificationMeta('endProjectAt');
  @override
  late final GeneratedColumn<DateTime> endProjectAt = GeneratedColumn<DateTime>(
      'end_project_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _defermentMeta =
      const VerificationMeta('deferment');
  @override
  late final GeneratedColumnWithTypeConverter<Deferment, String> deferment =
      GeneratedColumn<String>('deferment', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<Deferment>($OrdersTable.$converterdeferment);
  static const VerificationMeta _signingMethodMeta =
      const VerificationMeta('signingMethod');
  @override
  late final GeneratedColumnWithTypeConverter<SigningMethod?, String>
      signingMethod = GeneratedColumn<String>(
              'signing_method', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<SigningMethod?>($OrdersTable.$convertersigningMethodn);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumnWithTypeConverter<OrderStatus, String> status =
      GeneratedColumn<String>('status', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<OrderStatus>($OrdersTable.$converterstatus);
  static const VerificationMeta _cartStatusMeta =
      const VerificationMeta('cartStatus');
  @override
  late final GeneratedColumnWithTypeConverter<CartStatus, String> cartStatus =
      GeneratedColumn<String>('cart_status', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<CartStatus>($OrdersTable.$convertercartStatus);
  static const VerificationMeta _signatureStepMeta =
      const VerificationMeta('signatureStep');
  @override
  late final GeneratedColumn<int> signatureStep = GeneratedColumn<int>(
      'signature_step', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _aprMeta = const VerificationMeta('apr');
  @override
  late final GeneratedColumn<double> apr = GeneratedColumn<double>(
      'apr', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _intermediatePaymentAmountMeta =
      const VerificationMeta('intermediatePaymentAmount');
  @override
  late final GeneratedColumn<double> intermediatePaymentAmount =
      GeneratedColumn<double>('intermediate_payment_amount', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _keepOldStuffMeta =
      const VerificationMeta('keepOldStuff');
  @override
  late final GeneratedColumn<bool> keepOldStuff = GeneratedColumn<bool>(
      'keep_old_stuff', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("keep_old_stuff" IN (0, 1))'));
  static const VerificationMeta _houseAgeMeta =
      const VerificationMeta('houseAge');
  @override
  late final GeneratedColumn<int> houseAge = GeneratedColumn<int>(
      'house_age', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _isProPremiseMeta =
      const VerificationMeta('isProPremise');
  @override
  late final GeneratedColumn<bool> isProPremise = GeneratedColumn<bool>(
      'is_pro_premise', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_pro_premise" IN (0, 1))'));
  static const VerificationMeta _envelopeIdMeta =
      const VerificationMeta('envelopeId');
  @override
  late final GeneratedColumn<String> envelopeId = GeneratedColumn<String>(
      'envelope_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _envelopeAlreadySignedMeta =
      const VerificationMeta('envelopeAlreadySigned');
  @override
  late final GeneratedColumn<bool> envelopeAlreadySigned =
      GeneratedColumn<bool>('envelope_already_signed', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("envelope_already_signed" IN (0, 1))'));
  static const VerificationMeta _envelopeRecipientIdsMeta =
      const VerificationMeta('envelopeRecipientIds');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      envelopeRecipientIds = GeneratedColumn<String>(
              'envelope_recipient_ids', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>(
              $OrdersTable.$converterenvelopeRecipientIds);
  static const VerificationMeta _envelopeSignedRecipientIdsMeta =
      const VerificationMeta('envelopeSignedRecipientIds');
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
      envelopeSignedRecipientIds = GeneratedColumn<String>(
              'envelope_signed_recipient_ids', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>(
              $OrdersTable.$converterenvelopeSignedRecipientIds);
  static const VerificationMeta _envelopeSignedAtMeta =
      const VerificationMeta('envelopeSignedAt');
  @override
  late final GeneratedColumn<DateTime> envelopeSignedAt =
      GeneratedColumn<DateTime>('envelope_signed_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _shouldRecreateEnvelopeMeta =
      const VerificationMeta('shouldRecreateEnvelope');
  @override
  late final GeneratedColumn<bool> shouldRecreateEnvelope =
      GeneratedColumn<bool>('should_recreate_envelope', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("should_recreate_envelope" IN (0, 1))'));
  static const VerificationMeta _locationMeta =
      const VerificationMeta('location');
  @override
  late final GeneratedColumnWithTypeConverter<GeoPoint?, String> location =
      GeneratedColumn<String>('location', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<GeoPoint?>($OrdersTable.$converterlocationn);
  static const VerificationMeta _locationAlreadyFetchedMeta =
      const VerificationMeta('locationAlreadyFetched');
  @override
  late final GeneratedColumn<bool> locationAlreadyFetched =
      GeneratedColumn<bool>('location_already_fetched', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("location_already_fetched" IN (0, 1))'));
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, String> syncStatus =
      GeneratedColumn<String>('sync_status', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<SyncStatus>($OrdersTable.$convertersyncStatus);
  static const VerificationMeta _isCashPaymentMeta =
      const VerificationMeta('isCashPayment');
  @override
  late final GeneratedColumn<bool> isCashPayment = GeneratedColumn<bool>(
      'is_cash_payment', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_cash_payment" IN (0, 1))'));
  static const VerificationMeta _isFinancingPaymentMeta =
      const VerificationMeta('isFinancingPayment');
  @override
  late final GeneratedColumn<bool> isFinancingPayment = GeneratedColumn<bool>(
      'is_financing_payment', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_financing_payment" IN (0, 1))'));
  static const VerificationMeta _cashPaymentMethodMeta =
      const VerificationMeta('cashPaymentMethod');
  @override
  late final GeneratedColumnWithTypeConverter<CashPaymentMethod?, String>
      cashPaymentMethod = GeneratedColumn<String>(
              'cash_payment_method', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<CashPaymentMethod?>(
              $OrdersTable.$convertercashPaymentMethodn);
  static const VerificationMeta _financingPaymentMethodMeta =
      const VerificationMeta('financingPaymentMethod');
  @override
  late final GeneratedColumnWithTypeConverter<FinancingPaymentMethod?, String>
      financingPaymentMethod = GeneratedColumn<String>(
              'financing_payment_method', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<FinancingPaymentMethod?>(
              $OrdersTable.$converterfinancingPaymentMethodn);
  static const VerificationMeta _orderFormFileDataIdMeta =
      const VerificationMeta('orderFormFileDataId');
  @override
  late final GeneratedColumn<String> orderFormFileDataId =
      GeneratedColumn<String>('order_form_file_data_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _termsDocumentFileDataIdMeta =
      const VerificationMeta('termsDocumentFileDataId');
  @override
  late final GeneratedColumn<String> termsDocumentFileDataId =
      GeneratedColumn<String>('terms_document_file_data_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _vatCertificateFileDataIdMeta =
      const VerificationMeta('vatCertificateFileDataId');
  @override
  late final GeneratedColumn<String> vatCertificateFileDataId =
      GeneratedColumn<String>('vat_certificate_file_data_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        agencyId,
        customerId,
        fairId,
        representative1Id,
        representative2Id,
        representative3Id,
        address1,
        address2,
        addressCode,
        city,
        postalCode,
        amountHT,
        amountTTC,
        intermediatePaymentPercentage,
        creditAmount,
        creditTotalCost,
        depositAmount,
        fundingStatus,
        insuranceType,
        monthlyPaymentAmount,
        monthlyPaymentsCount,
        nominalRate,
        orderFormId,
        orderType,
        origin,
        originDetails,
        paymentTerms,
        installAt,
        endProjectAt,
        deferment,
        signingMethod,
        status,
        cartStatus,
        signatureStep,
        apr,
        intermediatePaymentAmount,
        keepOldStuff,
        houseAge,
        isProPremise,
        envelopeId,
        envelopeAlreadySigned,
        envelopeRecipientIds,
        envelopeSignedRecipientIds,
        envelopeSignedAt,
        shouldRecreateEnvelope,
        location,
        locationAlreadyFetched,
        syncStatus,
        isCashPayment,
        isFinancingPayment,
        cashPaymentMethod,
        financingPaymentMethod,
        orderFormFileDataId,
        termsDocumentFileDataId,
        vatCertificateFileDataId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orders';
  @override
  VerificationContext validateIntegrity(Insertable<Order> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('agency_id')) {
      context.handle(_agencyIdMeta,
          agencyId.isAcceptableOrUnknown(data['agency_id']!, _agencyIdMeta));
    } else if (isInserting) {
      context.missing(_agencyIdMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id']!, _customerIdMeta));
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('fair_id')) {
      context.handle(_fairIdMeta,
          fairId.isAcceptableOrUnknown(data['fair_id']!, _fairIdMeta));
    }
    if (data.containsKey('representative1_id')) {
      context.handle(
          _representative1IdMeta,
          representative1Id.isAcceptableOrUnknown(
              data['representative1_id']!, _representative1IdMeta));
    }
    if (data.containsKey('representative2_id')) {
      context.handle(
          _representative2IdMeta,
          representative2Id.isAcceptableOrUnknown(
              data['representative2_id']!, _representative2IdMeta));
    }
    if (data.containsKey('representative3_id')) {
      context.handle(
          _representative3IdMeta,
          representative3Id.isAcceptableOrUnknown(
              data['representative3_id']!, _representative3IdMeta));
    }
    if (data.containsKey('address1')) {
      context.handle(_address1Meta,
          address1.isAcceptableOrUnknown(data['address1']!, _address1Meta));
    } else if (isInserting) {
      context.missing(_address1Meta);
    }
    if (data.containsKey('address2')) {
      context.handle(_address2Meta,
          address2.isAcceptableOrUnknown(data['address2']!, _address2Meta));
    }
    if (data.containsKey('address_code')) {
      context.handle(
          _addressCodeMeta,
          addressCode.isAcceptableOrUnknown(
              data['address_code']!, _addressCodeMeta));
    } else if (isInserting) {
      context.missing(_addressCodeMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('postal_code')) {
      context.handle(
          _postalCodeMeta,
          postalCode.isAcceptableOrUnknown(
              data['postal_code']!, _postalCodeMeta));
    } else if (isInserting) {
      context.missing(_postalCodeMeta);
    }
    if (data.containsKey('amount_h_t')) {
      context.handle(_amountHTMeta,
          amountHT.isAcceptableOrUnknown(data['amount_h_t']!, _amountHTMeta));
    } else if (isInserting) {
      context.missing(_amountHTMeta);
    }
    if (data.containsKey('amount_t_t_c')) {
      context.handle(
          _amountTTCMeta,
          amountTTC.isAcceptableOrUnknown(
              data['amount_t_t_c']!, _amountTTCMeta));
    } else if (isInserting) {
      context.missing(_amountTTCMeta);
    }
    if (data.containsKey('intermediate_payment_percentage')) {
      context.handle(
          _intermediatePaymentPercentageMeta,
          intermediatePaymentPercentage.isAcceptableOrUnknown(
              data['intermediate_payment_percentage']!,
              _intermediatePaymentPercentageMeta));
    }
    if (data.containsKey('credit_amount')) {
      context.handle(
          _creditAmountMeta,
          creditAmount.isAcceptableOrUnknown(
              data['credit_amount']!, _creditAmountMeta));
    } else if (isInserting) {
      context.missing(_creditAmountMeta);
    }
    if (data.containsKey('credit_total_cost')) {
      context.handle(
          _creditTotalCostMeta,
          creditTotalCost.isAcceptableOrUnknown(
              data['credit_total_cost']!, _creditTotalCostMeta));
    } else if (isInserting) {
      context.missing(_creditTotalCostMeta);
    }
    if (data.containsKey('deposit_amount')) {
      context.handle(
          _depositAmountMeta,
          depositAmount.isAcceptableOrUnknown(
              data['deposit_amount']!, _depositAmountMeta));
    } else if (isInserting) {
      context.missing(_depositAmountMeta);
    }
    context.handle(_fundingStatusMeta, const VerificationResult.success());
    context.handle(_insuranceTypeMeta, const VerificationResult.success());
    if (data.containsKey('monthly_payment_amount')) {
      context.handle(
          _monthlyPaymentAmountMeta,
          monthlyPaymentAmount.isAcceptableOrUnknown(
              data['monthly_payment_amount']!, _monthlyPaymentAmountMeta));
    } else if (isInserting) {
      context.missing(_monthlyPaymentAmountMeta);
    }
    if (data.containsKey('monthly_payments_count')) {
      context.handle(
          _monthlyPaymentsCountMeta,
          monthlyPaymentsCount.isAcceptableOrUnknown(
              data['monthly_payments_count']!, _monthlyPaymentsCountMeta));
    } else if (isInserting) {
      context.missing(_monthlyPaymentsCountMeta);
    }
    if (data.containsKey('nominal_rate')) {
      context.handle(
          _nominalRateMeta,
          nominalRate.isAcceptableOrUnknown(
              data['nominal_rate']!, _nominalRateMeta));
    } else if (isInserting) {
      context.missing(_nominalRateMeta);
    }
    if (data.containsKey('order_form_id')) {
      context.handle(
          _orderFormIdMeta,
          orderFormId.isAcceptableOrUnknown(
              data['order_form_id']!, _orderFormIdMeta));
    } else if (isInserting) {
      context.missing(_orderFormIdMeta);
    }
    context.handle(_orderTypeMeta, const VerificationResult.success());
    context.handle(_originMeta, const VerificationResult.success());
    context.handle(_originDetailsMeta, const VerificationResult.success());
    context.handle(_paymentTermsMeta, const VerificationResult.success());
    if (data.containsKey('install_at')) {
      context.handle(_installAtMeta,
          installAt.isAcceptableOrUnknown(data['install_at']!, _installAtMeta));
    }
    if (data.containsKey('end_project_at')) {
      context.handle(
          _endProjectAtMeta,
          endProjectAt.isAcceptableOrUnknown(
              data['end_project_at']!, _endProjectAtMeta));
    }
    context.handle(_defermentMeta, const VerificationResult.success());
    context.handle(_signingMethodMeta, const VerificationResult.success());
    context.handle(_statusMeta, const VerificationResult.success());
    context.handle(_cartStatusMeta, const VerificationResult.success());
    if (data.containsKey('signature_step')) {
      context.handle(
          _signatureStepMeta,
          signatureStep.isAcceptableOrUnknown(
              data['signature_step']!, _signatureStepMeta));
    } else if (isInserting) {
      context.missing(_signatureStepMeta);
    }
    if (data.containsKey('apr')) {
      context.handle(
          _aprMeta, apr.isAcceptableOrUnknown(data['apr']!, _aprMeta));
    } else if (isInserting) {
      context.missing(_aprMeta);
    }
    if (data.containsKey('intermediate_payment_amount')) {
      context.handle(
          _intermediatePaymentAmountMeta,
          intermediatePaymentAmount.isAcceptableOrUnknown(
              data['intermediate_payment_amount']!,
              _intermediatePaymentAmountMeta));
    }
    if (data.containsKey('keep_old_stuff')) {
      context.handle(
          _keepOldStuffMeta,
          keepOldStuff.isAcceptableOrUnknown(
              data['keep_old_stuff']!, _keepOldStuffMeta));
    } else if (isInserting) {
      context.missing(_keepOldStuffMeta);
    }
    if (data.containsKey('house_age')) {
      context.handle(_houseAgeMeta,
          houseAge.isAcceptableOrUnknown(data['house_age']!, _houseAgeMeta));
    }
    if (data.containsKey('is_pro_premise')) {
      context.handle(
          _isProPremiseMeta,
          isProPremise.isAcceptableOrUnknown(
              data['is_pro_premise']!, _isProPremiseMeta));
    } else if (isInserting) {
      context.missing(_isProPremiseMeta);
    }
    if (data.containsKey('envelope_id')) {
      context.handle(
          _envelopeIdMeta,
          envelopeId.isAcceptableOrUnknown(
              data['envelope_id']!, _envelopeIdMeta));
    }
    if (data.containsKey('envelope_already_signed')) {
      context.handle(
          _envelopeAlreadySignedMeta,
          envelopeAlreadySigned.isAcceptableOrUnknown(
              data['envelope_already_signed']!, _envelopeAlreadySignedMeta));
    } else if (isInserting) {
      context.missing(_envelopeAlreadySignedMeta);
    }
    context.handle(
        _envelopeRecipientIdsMeta, const VerificationResult.success());
    context.handle(
        _envelopeSignedRecipientIdsMeta, const VerificationResult.success());
    if (data.containsKey('envelope_signed_at')) {
      context.handle(
          _envelopeSignedAtMeta,
          envelopeSignedAt.isAcceptableOrUnknown(
              data['envelope_signed_at']!, _envelopeSignedAtMeta));
    }
    if (data.containsKey('should_recreate_envelope')) {
      context.handle(
          _shouldRecreateEnvelopeMeta,
          shouldRecreateEnvelope.isAcceptableOrUnknown(
              data['should_recreate_envelope']!, _shouldRecreateEnvelopeMeta));
    } else if (isInserting) {
      context.missing(_shouldRecreateEnvelopeMeta);
    }
    context.handle(_locationMeta, const VerificationResult.success());
    if (data.containsKey('location_already_fetched')) {
      context.handle(
          _locationAlreadyFetchedMeta,
          locationAlreadyFetched.isAcceptableOrUnknown(
              data['location_already_fetched']!, _locationAlreadyFetchedMeta));
    } else if (isInserting) {
      context.missing(_locationAlreadyFetchedMeta);
    }
    context.handle(_syncStatusMeta, const VerificationResult.success());
    if (data.containsKey('is_cash_payment')) {
      context.handle(
          _isCashPaymentMeta,
          isCashPayment.isAcceptableOrUnknown(
              data['is_cash_payment']!, _isCashPaymentMeta));
    }
    if (data.containsKey('is_financing_payment')) {
      context.handle(
          _isFinancingPaymentMeta,
          isFinancingPayment.isAcceptableOrUnknown(
              data['is_financing_payment']!, _isFinancingPaymentMeta));
    }
    context.handle(_cashPaymentMethodMeta, const VerificationResult.success());
    context.handle(
        _financingPaymentMethodMeta, const VerificationResult.success());
    if (data.containsKey('order_form_file_data_id')) {
      context.handle(
          _orderFormFileDataIdMeta,
          orderFormFileDataId.isAcceptableOrUnknown(
              data['order_form_file_data_id']!, _orderFormFileDataIdMeta));
    }
    if (data.containsKey('terms_document_file_data_id')) {
      context.handle(
          _termsDocumentFileDataIdMeta,
          termsDocumentFileDataId.isAcceptableOrUnknown(
              data['terms_document_file_data_id']!,
              _termsDocumentFileDataIdMeta));
    }
    if (data.containsKey('vat_certificate_file_data_id')) {
      context.handle(
          _vatCertificateFileDataIdMeta,
          vatCertificateFileDataId.isAcceptableOrUnknown(
              data['vat_certificate_file_data_id']!,
              _vatCertificateFileDataIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Order map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Order(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      agencyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}agency_id'])!,
      customerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_id'])!,
      fairId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fair_id']),
      representative1Id: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}representative1_id']),
      representative2Id: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}representative2_id']),
      representative3Id: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}representative3_id']),
      address1: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address1'])!,
      address2: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address2']),
      addressCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address_code'])!,
      city: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}city'])!,
      postalCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}postal_code'])!,
      amountHT: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount_h_t'])!,
      amountTTC: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount_t_t_c'])!,
      orderFormId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order_form_id'])!,
      orderType: $OrdersTable.$converterorderType.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order_type'])!),
      origin: $OrdersTable.$converteroriginn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}origin'])),
      originDetails: $OrdersTable.$converteroriginDetailsn.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}origin_details'])),
      installAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}install_at']),
      endProjectAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}end_project_at']),
      deferment: $OrdersTable.$converterdeferment.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}deferment'])!),
      signingMethod: $OrdersTable.$convertersigningMethodn.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}signing_method'])),
      status: $OrdersTable.$converterstatus.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!),
      cartStatus: $OrdersTable.$convertercartStatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cart_status'])!),
      signatureStep: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}signature_step'])!,
      apr: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}apr'])!,
      keepOldStuff: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}keep_old_stuff'])!,
      houseAge: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}house_age']),
      isProPremise: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_pro_premise'])!,
      paymentTerms: $OrdersTable.$converterpaymentTerms.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payment_terms'])!),
      cashPaymentMethod: $OrdersTable.$convertercashPaymentMethodn.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}cash_payment_method'])),
      financingPaymentMethod: $OrdersTable.$converterfinancingPaymentMethodn
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}financing_payment_method'])),
      intermediatePaymentPercentage: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}intermediate_payment_percentage']),
      intermediatePaymentAmount: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}intermediate_payment_amount']),
      creditAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}credit_amount'])!,
      creditTotalCost: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}credit_total_cost'])!,
      depositAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}deposit_amount'])!,
      fundingStatus: $OrdersTable.$converterfundingStatusn.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}funding_status'])),
      insuranceType: $OrdersTable.$converterinsuranceType.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}insurance_type'])!),
      monthlyPaymentAmount: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}monthly_payment_amount'])!,
      monthlyPaymentsCount: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}monthly_payments_count'])!,
      nominalRate: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}nominal_rate'])!,
      isCashPayment: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_cash_payment']),
      isFinancingPayment: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}is_financing_payment']),
      envelopeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}envelope_id']),
      envelopeAlreadySigned: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}envelope_already_signed'])!,
      envelopeRecipientIds: $OrdersTable.$converterenvelopeRecipientIds.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}envelope_recipient_ids'])!),
      envelopeSignedRecipientIds: $OrdersTable
          .$converterenvelopeSignedRecipientIds
          .fromSql(attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}envelope_signed_recipient_ids'])!),
      envelopeSignedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}envelope_signed_at']),
      shouldRecreateEnvelope: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}should_recreate_envelope'])!,
      location: $OrdersTable.$converterlocationn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location'])),
      locationAlreadyFetched: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}location_already_fetched'])!,
      syncStatus: $OrdersTable.$convertersyncStatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!),
      orderFormFileDataId: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}order_form_file_data_id']),
      termsDocumentFileDataId: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}terms_document_file_data_id']),
      vatCertificateFileDataId: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}vat_certificate_file_data_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $OrdersTable createAlias(String alias) {
    return $OrdersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<FundingStatus, String, String>
      $converterfundingStatus =
      const EnumNameConverter<FundingStatus>(FundingStatus.values);
  static JsonTypeConverter2<FundingStatus?, String?, String?>
      $converterfundingStatusn =
      JsonTypeConverter2.asNullable($converterfundingStatus);
  static JsonTypeConverter2<InsuranceType, String, String>
      $converterinsuranceType =
      const EnumNameConverter<InsuranceType>(InsuranceType.values);
  static JsonTypeConverter2<OrderType, String, String> $converterorderType =
      const EnumNameConverter<OrderType>(OrderType.values);
  static JsonTypeConverter2<Origin, String, String> $converterorigin =
      const EnumNameConverter<Origin>(Origin.values);
  static JsonTypeConverter2<Origin?, String?, String?> $converteroriginn =
      JsonTypeConverter2.asNullable($converterorigin);
  static JsonTypeConverter2<OriginDetails, String, String>
      $converteroriginDetails =
      const EnumNameConverter<OriginDetails>(OriginDetails.values);
  static JsonTypeConverter2<OriginDetails?, String?, String?>
      $converteroriginDetailsn =
      JsonTypeConverter2.asNullable($converteroriginDetails);
  static JsonTypeConverter2<PaymentTerms, String, String>
      $converterpaymentTerms =
      const EnumNameConverter<PaymentTerms>(PaymentTerms.values);
  static JsonTypeConverter2<Deferment, String, String> $converterdeferment =
      const EnumNameConverter<Deferment>(Deferment.values);
  static JsonTypeConverter2<SigningMethod, String, String>
      $convertersigningMethod =
      const EnumNameConverter<SigningMethod>(SigningMethod.values);
  static JsonTypeConverter2<SigningMethod?, String?, String?>
      $convertersigningMethodn =
      JsonTypeConverter2.asNullable($convertersigningMethod);
  static JsonTypeConverter2<OrderStatus, String, String> $converterstatus =
      const EnumNameConverter<OrderStatus>(OrderStatus.values);
  static JsonTypeConverter2<CartStatus, String, String> $convertercartStatus =
      const EnumNameConverter<CartStatus>(CartStatus.values);
  static TypeConverter<List<String>, String> $converterenvelopeRecipientIds =
      const ListStringConverter();
  static TypeConverter<List<String>, String>
      $converterenvelopeSignedRecipientIds = const ListStringConverter();
  static TypeConverter<GeoPoint, String> $converterlocation =
      const GeoPointConverter();
  static TypeConverter<GeoPoint?, String?> $converterlocationn =
      NullAwareTypeConverter.wrap($converterlocation);
  static JsonTypeConverter2<SyncStatus, String, String> $convertersyncStatus =
      const EnumNameConverter<SyncStatus>(SyncStatus.values);
  static JsonTypeConverter2<CashPaymentMethod, String, String>
      $convertercashPaymentMethod =
      const EnumNameConverter<CashPaymentMethod>(CashPaymentMethod.values);
  static JsonTypeConverter2<CashPaymentMethod?, String?, String?>
      $convertercashPaymentMethodn =
      JsonTypeConverter2.asNullable($convertercashPaymentMethod);
  static JsonTypeConverter2<FinancingPaymentMethod, String, String>
      $converterfinancingPaymentMethod =
      const EnumNameConverter<FinancingPaymentMethod>(
          FinancingPaymentMethod.values);
  static JsonTypeConverter2<FinancingPaymentMethod?, String?, String?>
      $converterfinancingPaymentMethodn =
      JsonTypeConverter2.asNullable($converterfinancingPaymentMethod);
}

class OrdersCompanion extends UpdateCompanion<Order> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String> agencyId;
  final Value<String> customerId;
  final Value<String?> fairId;
  final Value<String?> representative1Id;
  final Value<String?> representative2Id;
  final Value<String?> representative3Id;
  final Value<String> address1;
  final Value<String?> address2;
  final Value<String> addressCode;
  final Value<String> city;
  final Value<String> postalCode;
  final Value<double> amountHT;
  final Value<double> amountTTC;
  final Value<int?> intermediatePaymentPercentage;
  final Value<double> creditAmount;
  final Value<double> creditTotalCost;
  final Value<double> depositAmount;
  final Value<FundingStatus?> fundingStatus;
  final Value<InsuranceType> insuranceType;
  final Value<double> monthlyPaymentAmount;
  final Value<int> monthlyPaymentsCount;
  final Value<double> nominalRate;
  final Value<String> orderFormId;
  final Value<OrderType> orderType;
  final Value<Origin?> origin;
  final Value<OriginDetails?> originDetails;
  final Value<PaymentTerms> paymentTerms;
  final Value<DateTime?> installAt;
  final Value<DateTime?> endProjectAt;
  final Value<Deferment> deferment;
  final Value<SigningMethod?> signingMethod;
  final Value<OrderStatus> status;
  final Value<CartStatus> cartStatus;
  final Value<int> signatureStep;
  final Value<double> apr;
  final Value<double?> intermediatePaymentAmount;
  final Value<bool> keepOldStuff;
  final Value<int?> houseAge;
  final Value<bool> isProPremise;
  final Value<String?> envelopeId;
  final Value<bool> envelopeAlreadySigned;
  final Value<List<String>> envelopeRecipientIds;
  final Value<List<String>> envelopeSignedRecipientIds;
  final Value<DateTime?> envelopeSignedAt;
  final Value<bool> shouldRecreateEnvelope;
  final Value<GeoPoint?> location;
  final Value<bool> locationAlreadyFetched;
  final Value<SyncStatus> syncStatus;
  final Value<bool?> isCashPayment;
  final Value<bool?> isFinancingPayment;
  final Value<CashPaymentMethod?> cashPaymentMethod;
  final Value<FinancingPaymentMethod?> financingPaymentMethod;
  final Value<String?> orderFormFileDataId;
  final Value<String?> termsDocumentFileDataId;
  final Value<String?> vatCertificateFileDataId;
  final Value<int> rowid;
  const OrdersCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.agencyId = const Value.absent(),
    this.customerId = const Value.absent(),
    this.fairId = const Value.absent(),
    this.representative1Id = const Value.absent(),
    this.representative2Id = const Value.absent(),
    this.representative3Id = const Value.absent(),
    this.address1 = const Value.absent(),
    this.address2 = const Value.absent(),
    this.addressCode = const Value.absent(),
    this.city = const Value.absent(),
    this.postalCode = const Value.absent(),
    this.amountHT = const Value.absent(),
    this.amountTTC = const Value.absent(),
    this.intermediatePaymentPercentage = const Value.absent(),
    this.creditAmount = const Value.absent(),
    this.creditTotalCost = const Value.absent(),
    this.depositAmount = const Value.absent(),
    this.fundingStatus = const Value.absent(),
    this.insuranceType = const Value.absent(),
    this.monthlyPaymentAmount = const Value.absent(),
    this.monthlyPaymentsCount = const Value.absent(),
    this.nominalRate = const Value.absent(),
    this.orderFormId = const Value.absent(),
    this.orderType = const Value.absent(),
    this.origin = const Value.absent(),
    this.originDetails = const Value.absent(),
    this.paymentTerms = const Value.absent(),
    this.installAt = const Value.absent(),
    this.endProjectAt = const Value.absent(),
    this.deferment = const Value.absent(),
    this.signingMethod = const Value.absent(),
    this.status = const Value.absent(),
    this.cartStatus = const Value.absent(),
    this.signatureStep = const Value.absent(),
    this.apr = const Value.absent(),
    this.intermediatePaymentAmount = const Value.absent(),
    this.keepOldStuff = const Value.absent(),
    this.houseAge = const Value.absent(),
    this.isProPremise = const Value.absent(),
    this.envelopeId = const Value.absent(),
    this.envelopeAlreadySigned = const Value.absent(),
    this.envelopeRecipientIds = const Value.absent(),
    this.envelopeSignedRecipientIds = const Value.absent(),
    this.envelopeSignedAt = const Value.absent(),
    this.shouldRecreateEnvelope = const Value.absent(),
    this.location = const Value.absent(),
    this.locationAlreadyFetched = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isCashPayment = const Value.absent(),
    this.isFinancingPayment = const Value.absent(),
    this.cashPaymentMethod = const Value.absent(),
    this.financingPaymentMethod = const Value.absent(),
    this.orderFormFileDataId = const Value.absent(),
    this.termsDocumentFileDataId = const Value.absent(),
    this.vatCertificateFileDataId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrdersCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String agencyId,
    required String customerId,
    this.fairId = const Value.absent(),
    this.representative1Id = const Value.absent(),
    this.representative2Id = const Value.absent(),
    this.representative3Id = const Value.absent(),
    required String address1,
    this.address2 = const Value.absent(),
    required String addressCode,
    required String city,
    required String postalCode,
    required double amountHT,
    required double amountTTC,
    this.intermediatePaymentPercentage = const Value.absent(),
    required double creditAmount,
    required double creditTotalCost,
    required double depositAmount,
    this.fundingStatus = const Value.absent(),
    required InsuranceType insuranceType,
    required double monthlyPaymentAmount,
    required int monthlyPaymentsCount,
    required double nominalRate,
    required String orderFormId,
    required OrderType orderType,
    this.origin = const Value.absent(),
    this.originDetails = const Value.absent(),
    required PaymentTerms paymentTerms,
    this.installAt = const Value.absent(),
    this.endProjectAt = const Value.absent(),
    required Deferment deferment,
    this.signingMethod = const Value.absent(),
    required OrderStatus status,
    required CartStatus cartStatus,
    required int signatureStep,
    required double apr,
    this.intermediatePaymentAmount = const Value.absent(),
    required bool keepOldStuff,
    this.houseAge = const Value.absent(),
    required bool isProPremise,
    this.envelopeId = const Value.absent(),
    required bool envelopeAlreadySigned,
    required List<String> envelopeRecipientIds,
    required List<String> envelopeSignedRecipientIds,
    this.envelopeSignedAt = const Value.absent(),
    required bool shouldRecreateEnvelope,
    this.location = const Value.absent(),
    required bool locationAlreadyFetched,
    required SyncStatus syncStatus,
    this.isCashPayment = const Value.absent(),
    this.isFinancingPayment = const Value.absent(),
    this.cashPaymentMethod = const Value.absent(),
    this.financingPaymentMethod = const Value.absent(),
    this.orderFormFileDataId = const Value.absent(),
    this.termsDocumentFileDataId = const Value.absent(),
    this.vatCertificateFileDataId = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : agencyId = Value(agencyId),
        customerId = Value(customerId),
        address1 = Value(address1),
        addressCode = Value(addressCode),
        city = Value(city),
        postalCode = Value(postalCode),
        amountHT = Value(amountHT),
        amountTTC = Value(amountTTC),
        creditAmount = Value(creditAmount),
        creditTotalCost = Value(creditTotalCost),
        depositAmount = Value(depositAmount),
        insuranceType = Value(insuranceType),
        monthlyPaymentAmount = Value(monthlyPaymentAmount),
        monthlyPaymentsCount = Value(monthlyPaymentsCount),
        nominalRate = Value(nominalRate),
        orderFormId = Value(orderFormId),
        orderType = Value(orderType),
        paymentTerms = Value(paymentTerms),
        deferment = Value(deferment),
        status = Value(status),
        cartStatus = Value(cartStatus),
        signatureStep = Value(signatureStep),
        apr = Value(apr),
        keepOldStuff = Value(keepOldStuff),
        isProPremise = Value(isProPremise),
        envelopeAlreadySigned = Value(envelopeAlreadySigned),
        envelopeRecipientIds = Value(envelopeRecipientIds),
        envelopeSignedRecipientIds = Value(envelopeSignedRecipientIds),
        shouldRecreateEnvelope = Value(shouldRecreateEnvelope),
        locationAlreadyFetched = Value(locationAlreadyFetched),
        syncStatus = Value(syncStatus);
  static Insertable<Order> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? agencyId,
    Expression<String>? customerId,
    Expression<String>? fairId,
    Expression<String>? representative1Id,
    Expression<String>? representative2Id,
    Expression<String>? representative3Id,
    Expression<String>? address1,
    Expression<String>? address2,
    Expression<String>? addressCode,
    Expression<String>? city,
    Expression<String>? postalCode,
    Expression<double>? amountHT,
    Expression<double>? amountTTC,
    Expression<int>? intermediatePaymentPercentage,
    Expression<double>? creditAmount,
    Expression<double>? creditTotalCost,
    Expression<double>? depositAmount,
    Expression<String>? fundingStatus,
    Expression<String>? insuranceType,
    Expression<double>? monthlyPaymentAmount,
    Expression<int>? monthlyPaymentsCount,
    Expression<double>? nominalRate,
    Expression<String>? orderFormId,
    Expression<String>? orderType,
    Expression<String>? origin,
    Expression<String>? originDetails,
    Expression<String>? paymentTerms,
    Expression<DateTime>? installAt,
    Expression<DateTime>? endProjectAt,
    Expression<String>? deferment,
    Expression<String>? signingMethod,
    Expression<String>? status,
    Expression<String>? cartStatus,
    Expression<int>? signatureStep,
    Expression<double>? apr,
    Expression<double>? intermediatePaymentAmount,
    Expression<bool>? keepOldStuff,
    Expression<int>? houseAge,
    Expression<bool>? isProPremise,
    Expression<String>? envelopeId,
    Expression<bool>? envelopeAlreadySigned,
    Expression<String>? envelopeRecipientIds,
    Expression<String>? envelopeSignedRecipientIds,
    Expression<DateTime>? envelopeSignedAt,
    Expression<bool>? shouldRecreateEnvelope,
    Expression<String>? location,
    Expression<bool>? locationAlreadyFetched,
    Expression<String>? syncStatus,
    Expression<bool>? isCashPayment,
    Expression<bool>? isFinancingPayment,
    Expression<String>? cashPaymentMethod,
    Expression<String>? financingPaymentMethod,
    Expression<String>? orderFormFileDataId,
    Expression<String>? termsDocumentFileDataId,
    Expression<String>? vatCertificateFileDataId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (agencyId != null) 'agency_id': agencyId,
      if (customerId != null) 'customer_id': customerId,
      if (fairId != null) 'fair_id': fairId,
      if (representative1Id != null) 'representative1_id': representative1Id,
      if (representative2Id != null) 'representative2_id': representative2Id,
      if (representative3Id != null) 'representative3_id': representative3Id,
      if (address1 != null) 'address1': address1,
      if (address2 != null) 'address2': address2,
      if (addressCode != null) 'address_code': addressCode,
      if (city != null) 'city': city,
      if (postalCode != null) 'postal_code': postalCode,
      if (amountHT != null) 'amount_h_t': amountHT,
      if (amountTTC != null) 'amount_t_t_c': amountTTC,
      if (intermediatePaymentPercentage != null)
        'intermediate_payment_percentage': intermediatePaymentPercentage,
      if (creditAmount != null) 'credit_amount': creditAmount,
      if (creditTotalCost != null) 'credit_total_cost': creditTotalCost,
      if (depositAmount != null) 'deposit_amount': depositAmount,
      if (fundingStatus != null) 'funding_status': fundingStatus,
      if (insuranceType != null) 'insurance_type': insuranceType,
      if (monthlyPaymentAmount != null)
        'monthly_payment_amount': monthlyPaymentAmount,
      if (monthlyPaymentsCount != null)
        'monthly_payments_count': monthlyPaymentsCount,
      if (nominalRate != null) 'nominal_rate': nominalRate,
      if (orderFormId != null) 'order_form_id': orderFormId,
      if (orderType != null) 'order_type': orderType,
      if (origin != null) 'origin': origin,
      if (originDetails != null) 'origin_details': originDetails,
      if (paymentTerms != null) 'payment_terms': paymentTerms,
      if (installAt != null) 'install_at': installAt,
      if (endProjectAt != null) 'end_project_at': endProjectAt,
      if (deferment != null) 'deferment': deferment,
      if (signingMethod != null) 'signing_method': signingMethod,
      if (status != null) 'status': status,
      if (cartStatus != null) 'cart_status': cartStatus,
      if (signatureStep != null) 'signature_step': signatureStep,
      if (apr != null) 'apr': apr,
      if (intermediatePaymentAmount != null)
        'intermediate_payment_amount': intermediatePaymentAmount,
      if (keepOldStuff != null) 'keep_old_stuff': keepOldStuff,
      if (houseAge != null) 'house_age': houseAge,
      if (isProPremise != null) 'is_pro_premise': isProPremise,
      if (envelopeId != null) 'envelope_id': envelopeId,
      if (envelopeAlreadySigned != null)
        'envelope_already_signed': envelopeAlreadySigned,
      if (envelopeRecipientIds != null)
        'envelope_recipient_ids': envelopeRecipientIds,
      if (envelopeSignedRecipientIds != null)
        'envelope_signed_recipient_ids': envelopeSignedRecipientIds,
      if (envelopeSignedAt != null) 'envelope_signed_at': envelopeSignedAt,
      if (shouldRecreateEnvelope != null)
        'should_recreate_envelope': shouldRecreateEnvelope,
      if (location != null) 'location': location,
      if (locationAlreadyFetched != null)
        'location_already_fetched': locationAlreadyFetched,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (isCashPayment != null) 'is_cash_payment': isCashPayment,
      if (isFinancingPayment != null)
        'is_financing_payment': isFinancingPayment,
      if (cashPaymentMethod != null) 'cash_payment_method': cashPaymentMethod,
      if (financingPaymentMethod != null)
        'financing_payment_method': financingPaymentMethod,
      if (orderFormFileDataId != null)
        'order_form_file_data_id': orderFormFileDataId,
      if (termsDocumentFileDataId != null)
        'terms_document_file_data_id': termsDocumentFileDataId,
      if (vatCertificateFileDataId != null)
        'vat_certificate_file_data_id': vatCertificateFileDataId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrdersCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<String>? agencyId,
      Value<String>? customerId,
      Value<String?>? fairId,
      Value<String?>? representative1Id,
      Value<String?>? representative2Id,
      Value<String?>? representative3Id,
      Value<String>? address1,
      Value<String?>? address2,
      Value<String>? addressCode,
      Value<String>? city,
      Value<String>? postalCode,
      Value<double>? amountHT,
      Value<double>? amountTTC,
      Value<int?>? intermediatePaymentPercentage,
      Value<double>? creditAmount,
      Value<double>? creditTotalCost,
      Value<double>? depositAmount,
      Value<FundingStatus?>? fundingStatus,
      Value<InsuranceType>? insuranceType,
      Value<double>? monthlyPaymentAmount,
      Value<int>? monthlyPaymentsCount,
      Value<double>? nominalRate,
      Value<String>? orderFormId,
      Value<OrderType>? orderType,
      Value<Origin?>? origin,
      Value<OriginDetails?>? originDetails,
      Value<PaymentTerms>? paymentTerms,
      Value<DateTime?>? installAt,
      Value<DateTime?>? endProjectAt,
      Value<Deferment>? deferment,
      Value<SigningMethod?>? signingMethod,
      Value<OrderStatus>? status,
      Value<CartStatus>? cartStatus,
      Value<int>? signatureStep,
      Value<double>? apr,
      Value<double?>? intermediatePaymentAmount,
      Value<bool>? keepOldStuff,
      Value<int?>? houseAge,
      Value<bool>? isProPremise,
      Value<String?>? envelopeId,
      Value<bool>? envelopeAlreadySigned,
      Value<List<String>>? envelopeRecipientIds,
      Value<List<String>>? envelopeSignedRecipientIds,
      Value<DateTime?>? envelopeSignedAt,
      Value<bool>? shouldRecreateEnvelope,
      Value<GeoPoint?>? location,
      Value<bool>? locationAlreadyFetched,
      Value<SyncStatus>? syncStatus,
      Value<bool?>? isCashPayment,
      Value<bool?>? isFinancingPayment,
      Value<CashPaymentMethod?>? cashPaymentMethod,
      Value<FinancingPaymentMethod?>? financingPaymentMethod,
      Value<String?>? orderFormFileDataId,
      Value<String?>? termsDocumentFileDataId,
      Value<String?>? vatCertificateFileDataId,
      Value<int>? rowid}) {
    return OrdersCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      agencyId: agencyId ?? this.agencyId,
      customerId: customerId ?? this.customerId,
      fairId: fairId ?? this.fairId,
      representative1Id: representative1Id ?? this.representative1Id,
      representative2Id: representative2Id ?? this.representative2Id,
      representative3Id: representative3Id ?? this.representative3Id,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      addressCode: addressCode ?? this.addressCode,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
      amountHT: amountHT ?? this.amountHT,
      amountTTC: amountTTC ?? this.amountTTC,
      intermediatePaymentPercentage:
          intermediatePaymentPercentage ?? this.intermediatePaymentPercentage,
      creditAmount: creditAmount ?? this.creditAmount,
      creditTotalCost: creditTotalCost ?? this.creditTotalCost,
      depositAmount: depositAmount ?? this.depositAmount,
      fundingStatus: fundingStatus ?? this.fundingStatus,
      insuranceType: insuranceType ?? this.insuranceType,
      monthlyPaymentAmount: monthlyPaymentAmount ?? this.monthlyPaymentAmount,
      monthlyPaymentsCount: monthlyPaymentsCount ?? this.monthlyPaymentsCount,
      nominalRate: nominalRate ?? this.nominalRate,
      orderFormId: orderFormId ?? this.orderFormId,
      orderType: orderType ?? this.orderType,
      origin: origin ?? this.origin,
      originDetails: originDetails ?? this.originDetails,
      paymentTerms: paymentTerms ?? this.paymentTerms,
      installAt: installAt ?? this.installAt,
      endProjectAt: endProjectAt ?? this.endProjectAt,
      deferment: deferment ?? this.deferment,
      signingMethod: signingMethod ?? this.signingMethod,
      status: status ?? this.status,
      cartStatus: cartStatus ?? this.cartStatus,
      signatureStep: signatureStep ?? this.signatureStep,
      apr: apr ?? this.apr,
      intermediatePaymentAmount:
          intermediatePaymentAmount ?? this.intermediatePaymentAmount,
      keepOldStuff: keepOldStuff ?? this.keepOldStuff,
      houseAge: houseAge ?? this.houseAge,
      isProPremise: isProPremise ?? this.isProPremise,
      envelopeId: envelopeId ?? this.envelopeId,
      envelopeAlreadySigned:
          envelopeAlreadySigned ?? this.envelopeAlreadySigned,
      envelopeRecipientIds: envelopeRecipientIds ?? this.envelopeRecipientIds,
      envelopeSignedRecipientIds:
          envelopeSignedRecipientIds ?? this.envelopeSignedRecipientIds,
      envelopeSignedAt: envelopeSignedAt ?? this.envelopeSignedAt,
      shouldRecreateEnvelope:
          shouldRecreateEnvelope ?? this.shouldRecreateEnvelope,
      location: location ?? this.location,
      locationAlreadyFetched:
          locationAlreadyFetched ?? this.locationAlreadyFetched,
      syncStatus: syncStatus ?? this.syncStatus,
      isCashPayment: isCashPayment ?? this.isCashPayment,
      isFinancingPayment: isFinancingPayment ?? this.isFinancingPayment,
      cashPaymentMethod: cashPaymentMethod ?? this.cashPaymentMethod,
      financingPaymentMethod:
          financingPaymentMethod ?? this.financingPaymentMethod,
      orderFormFileDataId: orderFormFileDataId ?? this.orderFormFileDataId,
      termsDocumentFileDataId:
          termsDocumentFileDataId ?? this.termsDocumentFileDataId,
      vatCertificateFileDataId:
          vatCertificateFileDataId ?? this.vatCertificateFileDataId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (agencyId.present) {
      map['agency_id'] = Variable<String>(agencyId.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (fairId.present) {
      map['fair_id'] = Variable<String>(fairId.value);
    }
    if (representative1Id.present) {
      map['representative1_id'] = Variable<String>(representative1Id.value);
    }
    if (representative2Id.present) {
      map['representative2_id'] = Variable<String>(representative2Id.value);
    }
    if (representative3Id.present) {
      map['representative3_id'] = Variable<String>(representative3Id.value);
    }
    if (address1.present) {
      map['address1'] = Variable<String>(address1.value);
    }
    if (address2.present) {
      map['address2'] = Variable<String>(address2.value);
    }
    if (addressCode.present) {
      map['address_code'] = Variable<String>(addressCode.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (postalCode.present) {
      map['postal_code'] = Variable<String>(postalCode.value);
    }
    if (amountHT.present) {
      map['amount_h_t'] = Variable<double>(amountHT.value);
    }
    if (amountTTC.present) {
      map['amount_t_t_c'] = Variable<double>(amountTTC.value);
    }
    if (intermediatePaymentPercentage.present) {
      map['intermediate_payment_percentage'] =
          Variable<int>(intermediatePaymentPercentage.value);
    }
    if (creditAmount.present) {
      map['credit_amount'] = Variable<double>(creditAmount.value);
    }
    if (creditTotalCost.present) {
      map['credit_total_cost'] = Variable<double>(creditTotalCost.value);
    }
    if (depositAmount.present) {
      map['deposit_amount'] = Variable<double>(depositAmount.value);
    }
    if (fundingStatus.present) {
      map['funding_status'] = Variable<String>(
          $OrdersTable.$converterfundingStatusn.toSql(fundingStatus.value));
    }
    if (insuranceType.present) {
      map['insurance_type'] = Variable<String>(
          $OrdersTable.$converterinsuranceType.toSql(insuranceType.value));
    }
    if (monthlyPaymentAmount.present) {
      map['monthly_payment_amount'] =
          Variable<double>(monthlyPaymentAmount.value);
    }
    if (monthlyPaymentsCount.present) {
      map['monthly_payments_count'] = Variable<int>(monthlyPaymentsCount.value);
    }
    if (nominalRate.present) {
      map['nominal_rate'] = Variable<double>(nominalRate.value);
    }
    if (orderFormId.present) {
      map['order_form_id'] = Variable<String>(orderFormId.value);
    }
    if (orderType.present) {
      map['order_type'] = Variable<String>(
          $OrdersTable.$converterorderType.toSql(orderType.value));
    }
    if (origin.present) {
      map['origin'] =
          Variable<String>($OrdersTable.$converteroriginn.toSql(origin.value));
    }
    if (originDetails.present) {
      map['origin_details'] = Variable<String>(
          $OrdersTable.$converteroriginDetailsn.toSql(originDetails.value));
    }
    if (paymentTerms.present) {
      map['payment_terms'] = Variable<String>(
          $OrdersTable.$converterpaymentTerms.toSql(paymentTerms.value));
    }
    if (installAt.present) {
      map['install_at'] = Variable<DateTime>(installAt.value);
    }
    if (endProjectAt.present) {
      map['end_project_at'] = Variable<DateTime>(endProjectAt.value);
    }
    if (deferment.present) {
      map['deferment'] = Variable<String>(
          $OrdersTable.$converterdeferment.toSql(deferment.value));
    }
    if (signingMethod.present) {
      map['signing_method'] = Variable<String>(
          $OrdersTable.$convertersigningMethodn.toSql(signingMethod.value));
    }
    if (status.present) {
      map['status'] =
          Variable<String>($OrdersTable.$converterstatus.toSql(status.value));
    }
    if (cartStatus.present) {
      map['cart_status'] = Variable<String>(
          $OrdersTable.$convertercartStatus.toSql(cartStatus.value));
    }
    if (signatureStep.present) {
      map['signature_step'] = Variable<int>(signatureStep.value);
    }
    if (apr.present) {
      map['apr'] = Variable<double>(apr.value);
    }
    if (intermediatePaymentAmount.present) {
      map['intermediate_payment_amount'] =
          Variable<double>(intermediatePaymentAmount.value);
    }
    if (keepOldStuff.present) {
      map['keep_old_stuff'] = Variable<bool>(keepOldStuff.value);
    }
    if (houseAge.present) {
      map['house_age'] = Variable<int>(houseAge.value);
    }
    if (isProPremise.present) {
      map['is_pro_premise'] = Variable<bool>(isProPremise.value);
    }
    if (envelopeId.present) {
      map['envelope_id'] = Variable<String>(envelopeId.value);
    }
    if (envelopeAlreadySigned.present) {
      map['envelope_already_signed'] =
          Variable<bool>(envelopeAlreadySigned.value);
    }
    if (envelopeRecipientIds.present) {
      map['envelope_recipient_ids'] = Variable<String>($OrdersTable
          .$converterenvelopeRecipientIds
          .toSql(envelopeRecipientIds.value));
    }
    if (envelopeSignedRecipientIds.present) {
      map['envelope_signed_recipient_ids'] = Variable<String>($OrdersTable
          .$converterenvelopeSignedRecipientIds
          .toSql(envelopeSignedRecipientIds.value));
    }
    if (envelopeSignedAt.present) {
      map['envelope_signed_at'] = Variable<DateTime>(envelopeSignedAt.value);
    }
    if (shouldRecreateEnvelope.present) {
      map['should_recreate_envelope'] =
          Variable<bool>(shouldRecreateEnvelope.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(
          $OrdersTable.$converterlocationn.toSql(location.value));
    }
    if (locationAlreadyFetched.present) {
      map['location_already_fetched'] =
          Variable<bool>(locationAlreadyFetched.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(
          $OrdersTable.$convertersyncStatus.toSql(syncStatus.value));
    }
    if (isCashPayment.present) {
      map['is_cash_payment'] = Variable<bool>(isCashPayment.value);
    }
    if (isFinancingPayment.present) {
      map['is_financing_payment'] = Variable<bool>(isFinancingPayment.value);
    }
    if (cashPaymentMethod.present) {
      map['cash_payment_method'] = Variable<String>($OrdersTable
          .$convertercashPaymentMethodn
          .toSql(cashPaymentMethod.value));
    }
    if (financingPaymentMethod.present) {
      map['financing_payment_method'] = Variable<String>($OrdersTable
          .$converterfinancingPaymentMethodn
          .toSql(financingPaymentMethod.value));
    }
    if (orderFormFileDataId.present) {
      map['order_form_file_data_id'] =
          Variable<String>(orderFormFileDataId.value);
    }
    if (termsDocumentFileDataId.present) {
      map['terms_document_file_data_id'] =
          Variable<String>(termsDocumentFileDataId.value);
    }
    if (vatCertificateFileDataId.present) {
      map['vat_certificate_file_data_id'] =
          Variable<String>(vatCertificateFileDataId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdersCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('agencyId: $agencyId, ')
          ..write('customerId: $customerId, ')
          ..write('fairId: $fairId, ')
          ..write('representative1Id: $representative1Id, ')
          ..write('representative2Id: $representative2Id, ')
          ..write('representative3Id: $representative3Id, ')
          ..write('address1: $address1, ')
          ..write('address2: $address2, ')
          ..write('addressCode: $addressCode, ')
          ..write('city: $city, ')
          ..write('postalCode: $postalCode, ')
          ..write('amountHT: $amountHT, ')
          ..write('amountTTC: $amountTTC, ')
          ..write(
              'intermediatePaymentPercentage: $intermediatePaymentPercentage, ')
          ..write('creditAmount: $creditAmount, ')
          ..write('creditTotalCost: $creditTotalCost, ')
          ..write('depositAmount: $depositAmount, ')
          ..write('fundingStatus: $fundingStatus, ')
          ..write('insuranceType: $insuranceType, ')
          ..write('monthlyPaymentAmount: $monthlyPaymentAmount, ')
          ..write('monthlyPaymentsCount: $monthlyPaymentsCount, ')
          ..write('nominalRate: $nominalRate, ')
          ..write('orderFormId: $orderFormId, ')
          ..write('orderType: $orderType, ')
          ..write('origin: $origin, ')
          ..write('originDetails: $originDetails, ')
          ..write('paymentTerms: $paymentTerms, ')
          ..write('installAt: $installAt, ')
          ..write('endProjectAt: $endProjectAt, ')
          ..write('deferment: $deferment, ')
          ..write('signingMethod: $signingMethod, ')
          ..write('status: $status, ')
          ..write('cartStatus: $cartStatus, ')
          ..write('signatureStep: $signatureStep, ')
          ..write('apr: $apr, ')
          ..write('intermediatePaymentAmount: $intermediatePaymentAmount, ')
          ..write('keepOldStuff: $keepOldStuff, ')
          ..write('houseAge: $houseAge, ')
          ..write('isProPremise: $isProPremise, ')
          ..write('envelopeId: $envelopeId, ')
          ..write('envelopeAlreadySigned: $envelopeAlreadySigned, ')
          ..write('envelopeRecipientIds: $envelopeRecipientIds, ')
          ..write('envelopeSignedRecipientIds: $envelopeSignedRecipientIds, ')
          ..write('envelopeSignedAt: $envelopeSignedAt, ')
          ..write('shouldRecreateEnvelope: $shouldRecreateEnvelope, ')
          ..write('location: $location, ')
          ..write('locationAlreadyFetched: $locationAlreadyFetched, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isCashPayment: $isCashPayment, ')
          ..write('isFinancingPayment: $isFinancingPayment, ')
          ..write('cashPaymentMethod: $cashPaymentMethod, ')
          ..write('financingPaymentMethod: $financingPaymentMethod, ')
          ..write('orderFormFileDataId: $orderFormFileDataId, ')
          ..write('termsDocumentFileDataId: $termsDocumentFileDataId, ')
          ..write('vatCertificateFileDataId: $vatCertificateFileDataId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FileDatasTable extends FileDatas
    with TableInfo<$FileDatasTable, FileData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FileDatasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => getIt<UuidUtilsInterface>().generate());
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _agencyIdMeta =
      const VerificationMeta('agencyId');
  @override
  late final GeneratedColumn<String> agencyId = GeneratedColumn<String>(
      'agency_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES agencies (id)'));
  static const VerificationMeta _uniqueNameMeta =
      const VerificationMeta('uniqueName');
  @override
  late final GeneratedColumn<String> uniqueName = GeneratedColumn<String>(
      'unique_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _existsInStorageMeta =
      const VerificationMeta('existsInStorage');
  @override
  late final GeneratedColumn<bool> existsInStorage = GeneratedColumn<bool>(
      'exists_in_storage', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("exists_in_storage" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumnWithTypeConverter<SyncStatus, String> syncStatus =
      GeneratedColumn<String>('sync_status', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<SyncStatus>($FileDatasTable.$convertersyncStatus);
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumnWithTypeConverter<FileDataMode, String> mode =
      GeneratedColumn<String>('mode', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<FileDataMode>($FileDatasTable.$convertermode);
  static const VerificationMeta _familyIdMeta =
      const VerificationMeta('familyId');
  @override
  late final GeneratedColumn<String> familyId = GeneratedColumn<String>(
      'family_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES file_data_families (id)'));
  static const VerificationMeta _customerIdMeta =
      const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
      'customer_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES customers (id)'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<FileDataType, String> type =
      GeneratedColumn<String>('type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<FileDataType>($FileDatasTable.$convertertype);
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<double> size = GeneratedColumn<double>(
      'size', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _mimeTypeMeta =
      const VerificationMeta('mimeType');
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
      'mime_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _downloadUrlMeta =
      const VerificationMeta('downloadUrl');
  @override
  late final GeneratedColumn<String> downloadUrl = GeneratedColumn<String>(
      'download_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _previewFileDataIdMeta =
      const VerificationMeta('previewFileDataId');
  @override
  late final GeneratedColumn<String> previewFileDataId =
      GeneratedColumn<String>('preview_file_data_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isPreviewMeta =
      const VerificationMeta('isPreview');
  @override
  late final GeneratedColumn<bool> isPreview = GeneratedColumn<bool>(
      'is_preview', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_preview" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _orderIdMeta =
      const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>(
      'order_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES orders (id)'));
  static const VerificationMeta _searchableDisplayNameMeta =
      const VerificationMeta('searchableDisplayName');
  @override
  late final GeneratedColumn<String> searchableDisplayName =
      GeneratedColumn<String>('searchable_display_name', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        agencyId,
        uniqueName,
        displayName,
        existsInStorage,
        syncStatus,
        mode,
        familyId,
        customerId,
        type,
        size,
        mimeType,
        downloadUrl,
        previewFileDataId,
        isPreview,
        orderId,
        searchableDisplayName
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'file_datas';
  @override
  VerificationContext validateIntegrity(Insertable<FileData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('agency_id')) {
      context.handle(_agencyIdMeta,
          agencyId.isAcceptableOrUnknown(data['agency_id']!, _agencyIdMeta));
    }
    if (data.containsKey('unique_name')) {
      context.handle(
          _uniqueNameMeta,
          uniqueName.isAcceptableOrUnknown(
              data['unique_name']!, _uniqueNameMeta));
    } else if (isInserting) {
      context.missing(_uniqueNameMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('exists_in_storage')) {
      context.handle(
          _existsInStorageMeta,
          existsInStorage.isAcceptableOrUnknown(
              data['exists_in_storage']!, _existsInStorageMeta));
    }
    context.handle(_syncStatusMeta, const VerificationResult.success());
    context.handle(_modeMeta, const VerificationResult.success());
    if (data.containsKey('family_id')) {
      context.handle(_familyIdMeta,
          familyId.isAcceptableOrUnknown(data['family_id']!, _familyIdMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id']!, _customerIdMeta));
    }
    context.handle(_typeMeta, const VerificationResult.success());
    if (data.containsKey('size')) {
      context.handle(
          _sizeMeta, size.isAcceptableOrUnknown(data['size']!, _sizeMeta));
    }
    if (data.containsKey('mime_type')) {
      context.handle(_mimeTypeMeta,
          mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta));
    }
    if (data.containsKey('download_url')) {
      context.handle(
          _downloadUrlMeta,
          downloadUrl.isAcceptableOrUnknown(
              data['download_url']!, _downloadUrlMeta));
    }
    if (data.containsKey('preview_file_data_id')) {
      context.handle(
          _previewFileDataIdMeta,
          previewFileDataId.isAcceptableOrUnknown(
              data['preview_file_data_id']!, _previewFileDataIdMeta));
    }
    if (data.containsKey('is_preview')) {
      context.handle(_isPreviewMeta,
          isPreview.isAcceptableOrUnknown(data['is_preview']!, _isPreviewMeta));
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    }
    if (data.containsKey('searchable_display_name')) {
      context.handle(
          _searchableDisplayNameMeta,
          searchableDisplayName.isAcceptableOrUnknown(
              data['searchable_display_name']!, _searchableDisplayNameMeta));
    } else if (isInserting) {
      context.missing(_searchableDisplayNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FileData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FileData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      uniqueName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unique_name'])!,
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name'])!,
      agencyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}agency_id']),
      existsInStorage: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}exists_in_storage'])!,
      syncStatus: $FileDatasTable.$convertersyncStatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!),
      mode: $FileDatasTable.$convertermode.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mode'])!),
      familyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}family_id']),
      customerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_id']),
      type: $FileDatasTable.$convertertype.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!),
      size: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}size'])!,
      mimeType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mime_type']),
      downloadUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}download_url']),
      previewFileDataId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}preview_file_data_id']),
      isPreview: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_preview'])!,
      orderId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $FileDatasTable createAlias(String alias) {
    return $FileDatasTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SyncStatus, String, String> $convertersyncStatus =
      const EnumNameConverter<SyncStatus>(SyncStatus.values);
  static JsonTypeConverter2<FileDataMode, String, String> $convertermode =
      const EnumNameConverter<FileDataMode>(FileDataMode.values);
  static JsonTypeConverter2<FileDataType, String, String> $convertertype =
      const EnumNameConverter<FileDataType>(FileDataType.values);
}

class FileDatasCompanion extends UpdateCompanion<FileData> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String?> agencyId;
  final Value<String> uniqueName;
  final Value<String> displayName;
  final Value<bool> existsInStorage;
  final Value<SyncStatus> syncStatus;
  final Value<FileDataMode> mode;
  final Value<String?> familyId;
  final Value<String?> customerId;
  final Value<FileDataType> type;
  final Value<double> size;
  final Value<String?> mimeType;
  final Value<String?> downloadUrl;
  final Value<String?> previewFileDataId;
  final Value<bool> isPreview;
  final Value<String?> orderId;
  final Value<String> searchableDisplayName;
  final Value<int> rowid;
  const FileDatasCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.agencyId = const Value.absent(),
    this.uniqueName = const Value.absent(),
    this.displayName = const Value.absent(),
    this.existsInStorage = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.mode = const Value.absent(),
    this.familyId = const Value.absent(),
    this.customerId = const Value.absent(),
    this.type = const Value.absent(),
    this.size = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.downloadUrl = const Value.absent(),
    this.previewFileDataId = const Value.absent(),
    this.isPreview = const Value.absent(),
    this.orderId = const Value.absent(),
    this.searchableDisplayName = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FileDatasCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.agencyId = const Value.absent(),
    required String uniqueName,
    required String displayName,
    this.existsInStorage = const Value.absent(),
    required SyncStatus syncStatus,
    required FileDataMode mode,
    this.familyId = const Value.absent(),
    this.customerId = const Value.absent(),
    required FileDataType type,
    this.size = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.downloadUrl = const Value.absent(),
    this.previewFileDataId = const Value.absent(),
    this.isPreview = const Value.absent(),
    this.orderId = const Value.absent(),
    required String searchableDisplayName,
    this.rowid = const Value.absent(),
  })  : uniqueName = Value(uniqueName),
        displayName = Value(displayName),
        syncStatus = Value(syncStatus),
        mode = Value(mode),
        type = Value(type),
        searchableDisplayName = Value(searchableDisplayName);
  static Insertable<FileData> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? agencyId,
    Expression<String>? uniqueName,
    Expression<String>? displayName,
    Expression<bool>? existsInStorage,
    Expression<String>? syncStatus,
    Expression<String>? mode,
    Expression<String>? familyId,
    Expression<String>? customerId,
    Expression<String>? type,
    Expression<double>? size,
    Expression<String>? mimeType,
    Expression<String>? downloadUrl,
    Expression<String>? previewFileDataId,
    Expression<bool>? isPreview,
    Expression<String>? orderId,
    Expression<String>? searchableDisplayName,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (agencyId != null) 'agency_id': agencyId,
      if (uniqueName != null) 'unique_name': uniqueName,
      if (displayName != null) 'display_name': displayName,
      if (existsInStorage != null) 'exists_in_storage': existsInStorage,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (mode != null) 'mode': mode,
      if (familyId != null) 'family_id': familyId,
      if (customerId != null) 'customer_id': customerId,
      if (type != null) 'type': type,
      if (size != null) 'size': size,
      if (mimeType != null) 'mime_type': mimeType,
      if (downloadUrl != null) 'download_url': downloadUrl,
      if (previewFileDataId != null) 'preview_file_data_id': previewFileDataId,
      if (isPreview != null) 'is_preview': isPreview,
      if (orderId != null) 'order_id': orderId,
      if (searchableDisplayName != null)
        'searchable_display_name': searchableDisplayName,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FileDatasCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<String?>? agencyId,
      Value<String>? uniqueName,
      Value<String>? displayName,
      Value<bool>? existsInStorage,
      Value<SyncStatus>? syncStatus,
      Value<FileDataMode>? mode,
      Value<String?>? familyId,
      Value<String?>? customerId,
      Value<FileDataType>? type,
      Value<double>? size,
      Value<String?>? mimeType,
      Value<String?>? downloadUrl,
      Value<String?>? previewFileDataId,
      Value<bool>? isPreview,
      Value<String?>? orderId,
      Value<String>? searchableDisplayName,
      Value<int>? rowid}) {
    return FileDatasCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      agencyId: agencyId ?? this.agencyId,
      uniqueName: uniqueName ?? this.uniqueName,
      displayName: displayName ?? this.displayName,
      existsInStorage: existsInStorage ?? this.existsInStorage,
      syncStatus: syncStatus ?? this.syncStatus,
      mode: mode ?? this.mode,
      familyId: familyId ?? this.familyId,
      customerId: customerId ?? this.customerId,
      type: type ?? this.type,
      size: size ?? this.size,
      mimeType: mimeType ?? this.mimeType,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      previewFileDataId: previewFileDataId ?? this.previewFileDataId,
      isPreview: isPreview ?? this.isPreview,
      orderId: orderId ?? this.orderId,
      searchableDisplayName:
          searchableDisplayName ?? this.searchableDisplayName,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (agencyId.present) {
      map['agency_id'] = Variable<String>(agencyId.value);
    }
    if (uniqueName.present) {
      map['unique_name'] = Variable<String>(uniqueName.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (existsInStorage.present) {
      map['exists_in_storage'] = Variable<bool>(existsInStorage.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(
          $FileDatasTable.$convertersyncStatus.toSql(syncStatus.value));
    }
    if (mode.present) {
      map['mode'] =
          Variable<String>($FileDatasTable.$convertermode.toSql(mode.value));
    }
    if (familyId.present) {
      map['family_id'] = Variable<String>(familyId.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (type.present) {
      map['type'] =
          Variable<String>($FileDatasTable.$convertertype.toSql(type.value));
    }
    if (size.present) {
      map['size'] = Variable<double>(size.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (downloadUrl.present) {
      map['download_url'] = Variable<String>(downloadUrl.value);
    }
    if (previewFileDataId.present) {
      map['preview_file_data_id'] = Variable<String>(previewFileDataId.value);
    }
    if (isPreview.present) {
      map['is_preview'] = Variable<bool>(isPreview.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (searchableDisplayName.present) {
      map['searchable_display_name'] =
          Variable<String>(searchableDisplayName.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FileDatasCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('agencyId: $agencyId, ')
          ..write('uniqueName: $uniqueName, ')
          ..write('displayName: $displayName, ')
          ..write('existsInStorage: $existsInStorage, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('mode: $mode, ')
          ..write('familyId: $familyId, ')
          ..write('customerId: $customerId, ')
          ..write('type: $type, ')
          ..write('size: $size, ')
          ..write('mimeType: $mimeType, ')
          ..write('downloadUrl: $downloadUrl, ')
          ..write('previewFileDataId: $previewFileDataId, ')
          ..write('isPreview: $isPreview, ')
          ..write('orderId: $orderId, ')
          ..write('searchableDisplayName: $searchableDisplayName, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ServicesTable extends Services with TableInfo<$ServicesTable, Service> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => getIt<UuidUtilsInterface>().generate());
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _designationMeta =
      const VerificationMeta('designation');
  @override
  late final GeneratedColumn<String> designation = GeneratedColumn<String>(
      'designation', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumnWithTypeConverter<ServiceCategory, String>
      category = GeneratedColumn<String>('category', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<ServiceCategory>($ServicesTable.$convertercategory);
  static const VerificationMeta _defaultVatMeta =
      const VerificationMeta('defaultVat');
  @override
  late final GeneratedColumnWithTypeConverter<TaxLevel, String> defaultVat =
      GeneratedColumn<String>('default_vat', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<TaxLevel>($ServicesTable.$converterdefaultVat);
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
      'unit', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
      'status', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _subFamilyIdMeta =
      const VerificationMeta('subFamilyId');
  @override
  late final GeneratedColumn<String> subFamilyId = GeneratedColumn<String>(
      'sub_family_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES service_sub_families (id)'));
  static const VerificationMeta _agencyIdMeta =
      const VerificationMeta('agencyId');
  @override
  late final GeneratedColumn<String> agencyId = GeneratedColumn<String>(
      'agency_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES agencies (id)'));
  static const VerificationMeta _sageIdMeta = const VerificationMeta('sageId');
  @override
  late final GeneratedColumn<String> sageId = GeneratedColumn<String>(
      'sage_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isCleaningMeta =
      const VerificationMeta('isCleaning');
  @override
  late final GeneratedColumn<bool> isCleaning = GeneratedColumn<bool>(
      'is_cleaning', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_cleaning" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _sheetFileDataIdMeta =
      const VerificationMeta('sheetFileDataId');
  @override
  late final GeneratedColumn<String> sheetFileDataId = GeneratedColumn<String>(
      'sheet_file_data_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES file_datas (id)'));
  static const VerificationMeta _searchableLabelMeta =
      const VerificationMeta('searchableLabel');
  @override
  late final GeneratedColumn<String> searchableLabel = GeneratedColumn<String>(
      'searchable_label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        label,
        designation,
        category,
        defaultVat,
        unit,
        status,
        subFamilyId,
        agencyId,
        sageId,
        isCleaning,
        sheetFileDataId,
        searchableLabel
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'services';
  @override
  VerificationContext validateIntegrity(Insertable<Service> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('designation')) {
      context.handle(
          _designationMeta,
          designation.isAcceptableOrUnknown(
              data['designation']!, _designationMeta));
    }
    context.handle(_categoryMeta, const VerificationResult.success());
    context.handle(_defaultVatMeta, const VerificationResult.success());
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('sub_family_id')) {
      context.handle(
          _subFamilyIdMeta,
          subFamilyId.isAcceptableOrUnknown(
              data['sub_family_id']!, _subFamilyIdMeta));
    } else if (isInserting) {
      context.missing(_subFamilyIdMeta);
    }
    if (data.containsKey('agency_id')) {
      context.handle(_agencyIdMeta,
          agencyId.isAcceptableOrUnknown(data['agency_id']!, _agencyIdMeta));
    }
    if (data.containsKey('sage_id')) {
      context.handle(_sageIdMeta,
          sageId.isAcceptableOrUnknown(data['sage_id']!, _sageIdMeta));
    } else if (isInserting) {
      context.missing(_sageIdMeta);
    }
    if (data.containsKey('is_cleaning')) {
      context.handle(
          _isCleaningMeta,
          isCleaning.isAcceptableOrUnknown(
              data['is_cleaning']!, _isCleaningMeta));
    }
    if (data.containsKey('sheet_file_data_id')) {
      context.handle(
          _sheetFileDataIdMeta,
          sheetFileDataId.isAcceptableOrUnknown(
              data['sheet_file_data_id']!, _sheetFileDataIdMeta));
    }
    if (data.containsKey('searchable_label')) {
      context.handle(
          _searchableLabelMeta,
          searchableLabel.isAcceptableOrUnknown(
              data['searchable_label']!, _searchableLabelMeta));
    } else if (isInserting) {
      context.missing(_searchableLabelMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Service map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Service(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      designation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}designation']),
      category: $ServicesTable.$convertercategory.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!),
      defaultVat: $ServicesTable.$converterdefaultVat.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}default_vat'])!),
      unit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!,
      subFamilyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sub_family_id'])!,
      agencyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}agency_id']),
      sageId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sage_id'])!,
      isCleaning: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_cleaning'])!,
      sheetFileDataId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}sheet_file_data_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $ServicesTable createAlias(String alias) {
    return $ServicesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ServiceCategory, String, String>
      $convertercategory =
      const EnumNameConverter<ServiceCategory>(ServiceCategory.values);
  static JsonTypeConverter2<TaxLevel, String, String> $converterdefaultVat =
      const EnumNameConverter<TaxLevel>(TaxLevel.values);
}

class ServicesCompanion extends UpdateCompanion<Service> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String> label;
  final Value<String?> designation;
  final Value<ServiceCategory> category;
  final Value<TaxLevel> defaultVat;
  final Value<String> unit;
  final Value<int> status;
  final Value<String> subFamilyId;
  final Value<String?> agencyId;
  final Value<String> sageId;
  final Value<bool> isCleaning;
  final Value<String?> sheetFileDataId;
  final Value<String> searchableLabel;
  final Value<int> rowid;
  const ServicesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.label = const Value.absent(),
    this.designation = const Value.absent(),
    this.category = const Value.absent(),
    this.defaultVat = const Value.absent(),
    this.unit = const Value.absent(),
    this.status = const Value.absent(),
    this.subFamilyId = const Value.absent(),
    this.agencyId = const Value.absent(),
    this.sageId = const Value.absent(),
    this.isCleaning = const Value.absent(),
    this.sheetFileDataId = const Value.absent(),
    this.searchableLabel = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ServicesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String label,
    this.designation = const Value.absent(),
    required ServiceCategory category,
    required TaxLevel defaultVat,
    required String unit,
    required int status,
    required String subFamilyId,
    this.agencyId = const Value.absent(),
    required String sageId,
    this.isCleaning = const Value.absent(),
    this.sheetFileDataId = const Value.absent(),
    required String searchableLabel,
    this.rowid = const Value.absent(),
  })  : label = Value(label),
        category = Value(category),
        defaultVat = Value(defaultVat),
        unit = Value(unit),
        status = Value(status),
        subFamilyId = Value(subFamilyId),
        sageId = Value(sageId),
        searchableLabel = Value(searchableLabel);
  static Insertable<Service> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? label,
    Expression<String>? designation,
    Expression<String>? category,
    Expression<String>? defaultVat,
    Expression<String>? unit,
    Expression<int>? status,
    Expression<String>? subFamilyId,
    Expression<String>? agencyId,
    Expression<String>? sageId,
    Expression<bool>? isCleaning,
    Expression<String>? sheetFileDataId,
    Expression<String>? searchableLabel,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (label != null) 'label': label,
      if (designation != null) 'designation': designation,
      if (category != null) 'category': category,
      if (defaultVat != null) 'default_vat': defaultVat,
      if (unit != null) 'unit': unit,
      if (status != null) 'status': status,
      if (subFamilyId != null) 'sub_family_id': subFamilyId,
      if (agencyId != null) 'agency_id': agencyId,
      if (sageId != null) 'sage_id': sageId,
      if (isCleaning != null) 'is_cleaning': isCleaning,
      if (sheetFileDataId != null) 'sheet_file_data_id': sheetFileDataId,
      if (searchableLabel != null) 'searchable_label': searchableLabel,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ServicesCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<String>? label,
      Value<String?>? designation,
      Value<ServiceCategory>? category,
      Value<TaxLevel>? defaultVat,
      Value<String>? unit,
      Value<int>? status,
      Value<String>? subFamilyId,
      Value<String?>? agencyId,
      Value<String>? sageId,
      Value<bool>? isCleaning,
      Value<String?>? sheetFileDataId,
      Value<String>? searchableLabel,
      Value<int>? rowid}) {
    return ServicesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      label: label ?? this.label,
      designation: designation ?? this.designation,
      category: category ?? this.category,
      defaultVat: defaultVat ?? this.defaultVat,
      unit: unit ?? this.unit,
      status: status ?? this.status,
      subFamilyId: subFamilyId ?? this.subFamilyId,
      agencyId: agencyId ?? this.agencyId,
      sageId: sageId ?? this.sageId,
      isCleaning: isCleaning ?? this.isCleaning,
      sheetFileDataId: sheetFileDataId ?? this.sheetFileDataId,
      searchableLabel: searchableLabel ?? this.searchableLabel,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (designation.present) {
      map['designation'] = Variable<String>(designation.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(
          $ServicesTable.$convertercategory.toSql(category.value));
    }
    if (defaultVat.present) {
      map['default_vat'] = Variable<String>(
          $ServicesTable.$converterdefaultVat.toSql(defaultVat.value));
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (subFamilyId.present) {
      map['sub_family_id'] = Variable<String>(subFamilyId.value);
    }
    if (agencyId.present) {
      map['agency_id'] = Variable<String>(agencyId.value);
    }
    if (sageId.present) {
      map['sage_id'] = Variable<String>(sageId.value);
    }
    if (isCleaning.present) {
      map['is_cleaning'] = Variable<bool>(isCleaning.value);
    }
    if (sheetFileDataId.present) {
      map['sheet_file_data_id'] = Variable<String>(sheetFileDataId.value);
    }
    if (searchableLabel.present) {
      map['searchable_label'] = Variable<String>(searchableLabel.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServicesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('label: $label, ')
          ..write('designation: $designation, ')
          ..write('category: $category, ')
          ..write('defaultVat: $defaultVat, ')
          ..write('unit: $unit, ')
          ..write('status: $status, ')
          ..write('subFamilyId: $subFamilyId, ')
          ..write('agencyId: $agencyId, ')
          ..write('sageId: $sageId, ')
          ..write('isCleaning: $isCleaning, ')
          ..write('sheetFileDataId: $sheetFileDataId, ')
          ..write('searchableLabel: $searchableLabel, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ServiceOptionItemsTable extends ServiceOptionItems
    with TableInfo<$ServiceOptionItemsTable, ServiceOptionItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServiceOptionItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => getIt<UuidUtilsInterface>().generate());
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
      'type', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, createdAt, updatedAt, label, type];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'service_option_items';
  @override
  VerificationContext validateIntegrity(Insertable<ServiceOptionItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServiceOptionItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServiceOptionItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $ServiceOptionItemsTable createAlias(String alias) {
    return $ServiceOptionItemsTable(attachedDatabase, alias);
  }
}

class ServiceOptionItemsCompanion extends UpdateCompanion<ServiceOptionItem> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String> label;
  final Value<int> type;
  final Value<int> rowid;
  const ServiceOptionItemsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.label = const Value.absent(),
    this.type = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ServiceOptionItemsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String label,
    required int type,
    this.rowid = const Value.absent(),
  })  : label = Value(label),
        type = Value(type);
  static Insertable<ServiceOptionItem> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? label,
    Expression<int>? type,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (label != null) 'label': label,
      if (type != null) 'type': type,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ServiceOptionItemsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<String>? label,
      Value<int>? type,
      Value<int>? rowid}) {
    return ServiceOptionItemsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      label: label ?? this.label,
      type: type ?? this.type,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServiceOptionItemsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('label: $label, ')
          ..write('type: $type, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ServiceOptionsTable extends ServiceOptions
    with TableInfo<$ServiceOptionsTable, ServiceOption> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServiceOptionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => getIt<UuidUtilsInterface>().generate());
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _serviceIdMeta =
      const VerificationMeta('serviceId');
  @override
  late final GeneratedColumn<String> serviceId = GeneratedColumn<String>(
      'service_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES services (id)'));
  static const VerificationMeta _agencyIdMeta =
      const VerificationMeta('agencyId');
  @override
  late final GeneratedColumn<String> agencyId = GeneratedColumn<String>(
      'agency_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES agencies (id)'));
  static const VerificationMeta _option1IdMeta =
      const VerificationMeta('option1Id');
  @override
  late final GeneratedColumn<String> option1Id = GeneratedColumn<String>(
      'option1_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES service_option_items (id)'));
  static const VerificationMeta _option2IdMeta =
      const VerificationMeta('option2Id');
  @override
  late final GeneratedColumn<String> option2Id = GeneratedColumn<String>(
      'option2_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES service_option_items (id)'));
  static const VerificationMeta _designationMeta =
      const VerificationMeta('designation');
  @override
  late final GeneratedColumn<String> designation = GeneratedColumn<String>(
      'designation', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        serviceId,
        agencyId,
        option1Id,
        option2Id,
        designation
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'service_options';
  @override
  VerificationContext validateIntegrity(Insertable<ServiceOption> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('service_id')) {
      context.handle(_serviceIdMeta,
          serviceId.isAcceptableOrUnknown(data['service_id']!, _serviceIdMeta));
    } else if (isInserting) {
      context.missing(_serviceIdMeta);
    }
    if (data.containsKey('agency_id')) {
      context.handle(_agencyIdMeta,
          agencyId.isAcceptableOrUnknown(data['agency_id']!, _agencyIdMeta));
    }
    if (data.containsKey('option1_id')) {
      context.handle(_option1IdMeta,
          option1Id.isAcceptableOrUnknown(data['option1_id']!, _option1IdMeta));
    } else if (isInserting) {
      context.missing(_option1IdMeta);
    }
    if (data.containsKey('option2_id')) {
      context.handle(_option2IdMeta,
          option2Id.isAcceptableOrUnknown(data['option2_id']!, _option2IdMeta));
    }
    if (data.containsKey('designation')) {
      context.handle(
          _designationMeta,
          designation.isAcceptableOrUnknown(
              data['designation']!, _designationMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServiceOption map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServiceOption(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      serviceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}service_id'])!,
      agencyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}agency_id']),
      option1Id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}option1_id'])!,
      option2Id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}option2_id']),
      designation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}designation']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $ServiceOptionsTable createAlias(String alias) {
    return $ServiceOptionsTable(attachedDatabase, alias);
  }
}

class ServiceOptionsCompanion extends UpdateCompanion<ServiceOption> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String> serviceId;
  final Value<String?> agencyId;
  final Value<String> option1Id;
  final Value<String?> option2Id;
  final Value<String?> designation;
  final Value<int> rowid;
  const ServiceOptionsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.serviceId = const Value.absent(),
    this.agencyId = const Value.absent(),
    this.option1Id = const Value.absent(),
    this.option2Id = const Value.absent(),
    this.designation = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ServiceOptionsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String serviceId,
    this.agencyId = const Value.absent(),
    required String option1Id,
    this.option2Id = const Value.absent(),
    this.designation = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : serviceId = Value(serviceId),
        option1Id = Value(option1Id);
  static Insertable<ServiceOption> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? serviceId,
    Expression<String>? agencyId,
    Expression<String>? option1Id,
    Expression<String>? option2Id,
    Expression<String>? designation,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (serviceId != null) 'service_id': serviceId,
      if (agencyId != null) 'agency_id': agencyId,
      if (option1Id != null) 'option1_id': option1Id,
      if (option2Id != null) 'option2_id': option2Id,
      if (designation != null) 'designation': designation,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ServiceOptionsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<String>? serviceId,
      Value<String?>? agencyId,
      Value<String>? option1Id,
      Value<String?>? option2Id,
      Value<String?>? designation,
      Value<int>? rowid}) {
    return ServiceOptionsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      serviceId: serviceId ?? this.serviceId,
      agencyId: agencyId ?? this.agencyId,
      option1Id: option1Id ?? this.option1Id,
      option2Id: option2Id ?? this.option2Id,
      designation: designation ?? this.designation,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (serviceId.present) {
      map['service_id'] = Variable<String>(serviceId.value);
    }
    if (agencyId.present) {
      map['agency_id'] = Variable<String>(agencyId.value);
    }
    if (option1Id.present) {
      map['option1_id'] = Variable<String>(option1Id.value);
    }
    if (option2Id.present) {
      map['option2_id'] = Variable<String>(option2Id.value);
    }
    if (designation.present) {
      map['designation'] = Variable<String>(designation.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServiceOptionsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('serviceId: $serviceId, ')
          ..write('agencyId: $agencyId, ')
          ..write('option1Id: $option1Id, ')
          ..write('option2Id: $option2Id, ')
          ..write('designation: $designation, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PriceListsTable extends PriceLists
    with TableInfo<$PriceListsTable, PriceList> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PriceListsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => getIt<UuidUtilsInterface>().generate());
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _serviceIdMeta =
      const VerificationMeta('serviceId');
  @override
  late final GeneratedColumn<String> serviceId = GeneratedColumn<String>(
      'service_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES services (id)'));
  static const VerificationMeta _agencyIdMeta =
      const VerificationMeta('agencyId');
  @override
  late final GeneratedColumn<String> agencyId = GeneratedColumn<String>(
      'agency_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES agencies (id)'));
  static const VerificationMeta _priceListTypeMeta =
      const VerificationMeta('priceListType');
  @override
  late final GeneratedColumnWithTypeConverter<PriceListType, String>
      priceListType = GeneratedColumn<String>(
              'price_list_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<PriceListType>(
              $PriceListsTable.$converterpriceListType);
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
      'priority', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        serviceId,
        agencyId,
        priceListType,
        priority,
        startDate,
        endDate
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'price_lists';
  @override
  VerificationContext validateIntegrity(Insertable<PriceList> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('service_id')) {
      context.handle(_serviceIdMeta,
          serviceId.isAcceptableOrUnknown(data['service_id']!, _serviceIdMeta));
    } else if (isInserting) {
      context.missing(_serviceIdMeta);
    }
    if (data.containsKey('agency_id')) {
      context.handle(_agencyIdMeta,
          agencyId.isAcceptableOrUnknown(data['agency_id']!, _agencyIdMeta));
    }
    context.handle(_priceListTypeMeta, const VerificationResult.success());
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PriceList map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PriceList(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      serviceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}service_id'])!,
      agencyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}agency_id']),
      priceListType: $PriceListsTable.$converterpriceListType.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}price_list_type'])!),
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}priority'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $PriceListsTable createAlias(String alias) {
    return $PriceListsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PriceListType, String, String>
      $converterpriceListType =
      const EnumNameConverter<PriceListType>(PriceListType.values);
}

class PriceListsCompanion extends UpdateCompanion<PriceList> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String> serviceId;
  final Value<String?> agencyId;
  final Value<PriceListType> priceListType;
  final Value<int> priority;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<int> rowid;
  const PriceListsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.serviceId = const Value.absent(),
    this.agencyId = const Value.absent(),
    this.priceListType = const Value.absent(),
    this.priority = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PriceListsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String serviceId,
    this.agencyId = const Value.absent(),
    required PriceListType priceListType,
    required int priority,
    required DateTime startDate,
    required DateTime endDate,
    this.rowid = const Value.absent(),
  })  : serviceId = Value(serviceId),
        priceListType = Value(priceListType),
        priority = Value(priority),
        startDate = Value(startDate),
        endDate = Value(endDate);
  static Insertable<PriceList> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? serviceId,
    Expression<String>? agencyId,
    Expression<String>? priceListType,
    Expression<int>? priority,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (serviceId != null) 'service_id': serviceId,
      if (agencyId != null) 'agency_id': agencyId,
      if (priceListType != null) 'price_list_type': priceListType,
      if (priority != null) 'priority': priority,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PriceListsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<String>? serviceId,
      Value<String?>? agencyId,
      Value<PriceListType>? priceListType,
      Value<int>? priority,
      Value<DateTime>? startDate,
      Value<DateTime>? endDate,
      Value<int>? rowid}) {
    return PriceListsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      serviceId: serviceId ?? this.serviceId,
      agencyId: agencyId ?? this.agencyId,
      priceListType: priceListType ?? this.priceListType,
      priority: priority ?? this.priority,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (serviceId.present) {
      map['service_id'] = Variable<String>(serviceId.value);
    }
    if (agencyId.present) {
      map['agency_id'] = Variable<String>(agencyId.value);
    }
    if (priceListType.present) {
      map['price_list_type'] = Variable<String>(
          $PriceListsTable.$converterpriceListType.toSql(priceListType.value));
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PriceListsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('serviceId: $serviceId, ')
          ..write('agencyId: $agencyId, ')
          ..write('priceListType: $priceListType, ')
          ..write('priority: $priority, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PriceListItemsTable extends PriceListItems
    with TableInfo<$PriceListItemsTable, PriceListItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PriceListItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => getIt<UuidUtilsInterface>().generate());
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _priceListIdMeta =
      const VerificationMeta('priceListId');
  @override
  late final GeneratedColumn<String> priceListId = GeneratedColumn<String>(
      'price_list_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES price_lists (id)'));
  static const VerificationMeta _agencyIdMeta =
      const VerificationMeta('agencyId');
  @override
  late final GeneratedColumn<String> agencyId = GeneratedColumn<String>(
      'agency_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES agencies (id)'));
  static const VerificationMeta _option1IdMeta =
      const VerificationMeta('option1Id');
  @override
  late final GeneratedColumn<String> option1Id = GeneratedColumn<String>(
      'option1_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES service_option_items (id)'));
  static const VerificationMeta _option2IdMeta =
      const VerificationMeta('option2Id');
  @override
  late final GeneratedColumn<String> option2Id = GeneratedColumn<String>(
      'option2_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES service_option_items (id)'));
  static const VerificationMeta _minQuantityMeta =
      const VerificationMeta('minQuantity');
  @override
  late final GeneratedColumn<double> minQuantity = GeneratedColumn<double>(
      'min_quantity', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _maxQuantityMeta =
      const VerificationMeta('maxQuantity');
  @override
  late final GeneratedColumn<double> maxQuantity = GeneratedColumn<double>(
      'max_quantity', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
      'unit', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        priceListId,
        agencyId,
        option1Id,
        option2Id,
        minQuantity,
        maxQuantity,
        price,
        unit
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'price_list_items';
  @override
  VerificationContext validateIntegrity(Insertable<PriceListItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('price_list_id')) {
      context.handle(
          _priceListIdMeta,
          priceListId.isAcceptableOrUnknown(
              data['price_list_id']!, _priceListIdMeta));
    } else if (isInserting) {
      context.missing(_priceListIdMeta);
    }
    if (data.containsKey('agency_id')) {
      context.handle(_agencyIdMeta,
          agencyId.isAcceptableOrUnknown(data['agency_id']!, _agencyIdMeta));
    }
    if (data.containsKey('option1_id')) {
      context.handle(_option1IdMeta,
          option1Id.isAcceptableOrUnknown(data['option1_id']!, _option1IdMeta));
    }
    if (data.containsKey('option2_id')) {
      context.handle(_option2IdMeta,
          option2Id.isAcceptableOrUnknown(data['option2_id']!, _option2IdMeta));
    }
    if (data.containsKey('min_quantity')) {
      context.handle(
          _minQuantityMeta,
          minQuantity.isAcceptableOrUnknown(
              data['min_quantity']!, _minQuantityMeta));
    } else if (isInserting) {
      context.missing(_minQuantityMeta);
    }
    if (data.containsKey('max_quantity')) {
      context.handle(
          _maxQuantityMeta,
          maxQuantity.isAcceptableOrUnknown(
              data['max_quantity']!, _maxQuantityMeta));
    } else if (isInserting) {
      context.missing(_maxQuantityMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PriceListItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PriceListItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      priceListId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}price_list_id'])!,
      agencyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}agency_id']),
      option1Id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}option1_id']),
      option2Id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}option2_id']),
      minQuantity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}min_quantity'])!,
      maxQuantity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}max_quantity'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price'])!,
      unit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $PriceListItemsTable createAlias(String alias) {
    return $PriceListItemsTable(attachedDatabase, alias);
  }
}

class PriceListItemsCompanion extends UpdateCompanion<PriceListItem> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String> priceListId;
  final Value<String?> agencyId;
  final Value<String?> option1Id;
  final Value<String?> option2Id;
  final Value<double> minQuantity;
  final Value<double> maxQuantity;
  final Value<double> price;
  final Value<String> unit;
  final Value<int> rowid;
  const PriceListItemsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.priceListId = const Value.absent(),
    this.agencyId = const Value.absent(),
    this.option1Id = const Value.absent(),
    this.option2Id = const Value.absent(),
    this.minQuantity = const Value.absent(),
    this.maxQuantity = const Value.absent(),
    this.price = const Value.absent(),
    this.unit = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PriceListItemsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String priceListId,
    this.agencyId = const Value.absent(),
    this.option1Id = const Value.absent(),
    this.option2Id = const Value.absent(),
    required double minQuantity,
    required double maxQuantity,
    required double price,
    required String unit,
    this.rowid = const Value.absent(),
  })  : priceListId = Value(priceListId),
        minQuantity = Value(minQuantity),
        maxQuantity = Value(maxQuantity),
        price = Value(price),
        unit = Value(unit);
  static Insertable<PriceListItem> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? priceListId,
    Expression<String>? agencyId,
    Expression<String>? option1Id,
    Expression<String>? option2Id,
    Expression<double>? minQuantity,
    Expression<double>? maxQuantity,
    Expression<double>? price,
    Expression<String>? unit,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (priceListId != null) 'price_list_id': priceListId,
      if (agencyId != null) 'agency_id': agencyId,
      if (option1Id != null) 'option1_id': option1Id,
      if (option2Id != null) 'option2_id': option2Id,
      if (minQuantity != null) 'min_quantity': minQuantity,
      if (maxQuantity != null) 'max_quantity': maxQuantity,
      if (price != null) 'price': price,
      if (unit != null) 'unit': unit,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PriceListItemsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<String>? priceListId,
      Value<String?>? agencyId,
      Value<String?>? option1Id,
      Value<String?>? option2Id,
      Value<double>? minQuantity,
      Value<double>? maxQuantity,
      Value<double>? price,
      Value<String>? unit,
      Value<int>? rowid}) {
    return PriceListItemsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      priceListId: priceListId ?? this.priceListId,
      agencyId: agencyId ?? this.agencyId,
      option1Id: option1Id ?? this.option1Id,
      option2Id: option2Id ?? this.option2Id,
      minQuantity: minQuantity ?? this.minQuantity,
      maxQuantity: maxQuantity ?? this.maxQuantity,
      price: price ?? this.price,
      unit: unit ?? this.unit,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (priceListId.present) {
      map['price_list_id'] = Variable<String>(priceListId.value);
    }
    if (agencyId.present) {
      map['agency_id'] = Variable<String>(agencyId.value);
    }
    if (option1Id.present) {
      map['option1_id'] = Variable<String>(option1Id.value);
    }
    if (option2Id.present) {
      map['option2_id'] = Variable<String>(option2Id.value);
    }
    if (minQuantity.present) {
      map['min_quantity'] = Variable<double>(minQuantity.value);
    }
    if (maxQuantity.present) {
      map['max_quantity'] = Variable<double>(maxQuantity.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PriceListItemsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('priceListId: $priceListId, ')
          ..write('agencyId: $agencyId, ')
          ..write('option1Id: $option1Id, ')
          ..write('option2Id: $option2Id, ')
          ..write('minQuantity: $minQuantity, ')
          ..write('maxQuantity: $maxQuantity, ')
          ..write('price: $price, ')
          ..write('unit: $unit, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OrdersContactsTable extends OrdersContacts
    with TableInfo<$OrdersContactsTable, OrderContact> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdersContactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _orderIdMeta =
      const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>(
      'order_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES orders (id)'));
  static const VerificationMeta _contactIdMeta =
      const VerificationMeta('contactId');
  @override
  late final GeneratedColumn<String> contactId = GeneratedColumn<String>(
      'contact_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES contacts (id)'));
  @override
  List<GeneratedColumn> get $columns => [orderId, contactId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orders_contacts';
  @override
  VerificationContext validateIntegrity(Insertable<OrderContact> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('contact_id')) {
      context.handle(_contactIdMeta,
          contactId.isAcceptableOrUnknown(data['contact_id']!, _contactIdMeta));
    } else if (isInserting) {
      context.missing(_contactIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {orderId, contactId};
  @override
  OrderContact map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderContact(
      orderId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order_id'])!,
      contactId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}contact_id'])!,
    );
  }

  @override
  $OrdersContactsTable createAlias(String alias) {
    return $OrdersContactsTable(attachedDatabase, alias);
  }
}

class OrdersContactsCompanion extends UpdateCompanion<OrderContact> {
  final Value<String> orderId;
  final Value<String> contactId;
  final Value<int> rowid;
  const OrdersContactsCompanion({
    this.orderId = const Value.absent(),
    this.contactId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrdersContactsCompanion.insert({
    required String orderId,
    required String contactId,
    this.rowid = const Value.absent(),
  })  : orderId = Value(orderId),
        contactId = Value(contactId);
  static Insertable<OrderContact> custom({
    Expression<String>? orderId,
    Expression<String>? contactId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (orderId != null) 'order_id': orderId,
      if (contactId != null) 'contact_id': contactId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrdersContactsCompanion copyWith(
      {Value<String>? orderId, Value<String>? contactId, Value<int>? rowid}) {
    return OrdersContactsCompanion(
      orderId: orderId ?? this.orderId,
      contactId: contactId ?? this.contactId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (contactId.present) {
      map['contact_id'] = Variable<String>(contactId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdersContactsCompanion(')
          ..write('orderId: $orderId, ')
          ..write('contactId: $contactId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DiscountCodesTable extends DiscountCodes
    with TableInfo<$DiscountCodesTable, DiscountCode> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DiscountCodesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => getIt<UuidUtilsInterface>().generate());
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<DiscountCodeType, String> type =
      GeneratedColumn<String>('type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<DiscountCodeType>($DiscountCodesTable.$convertertype);
  static const VerificationMeta _discountMeta =
      const VerificationMeta('discount');
  @override
  late final GeneratedColumn<double> discount = GeneratedColumn<double>(
      'discount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _agencyIdMeta =
      const VerificationMeta('agencyId');
  @override
  late final GeneratedColumn<String> agencyId = GeneratedColumn<String>(
      'agency_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES agencies (id)'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES representatives (id)'));
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        code,
        type,
        discount,
        startDate,
        endDate,
        agencyId,
        userId,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'discount_codes';
  @override
  VerificationContext validateIntegrity(Insertable<DiscountCode> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    context.handle(_typeMeta, const VerificationResult.success());
    if (data.containsKey('discount')) {
      context.handle(_discountMeta,
          discount.isAcceptableOrUnknown(data['discount']!, _discountMeta));
    } else if (isInserting) {
      context.missing(_discountMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('agency_id')) {
      context.handle(_agencyIdMeta,
          agencyId.isAcceptableOrUnknown(data['agency_id']!, _agencyIdMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DiscountCode map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DiscountCode(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      type: $DiscountCodesTable.$convertertype.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!),
      discount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}discount'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date']),
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date']),
      agencyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}agency_id']),
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $DiscountCodesTable createAlias(String alias) {
    return $DiscountCodesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<DiscountCodeType, String, String> $convertertype =
      const EnumNameConverter<DiscountCodeType>(DiscountCodeType.values);
}

class DiscountCodesCompanion extends UpdateCompanion<DiscountCode> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String> code;
  final Value<DiscountCodeType> type;
  final Value<double> discount;
  final Value<DateTime?> startDate;
  final Value<DateTime?> endDate;
  final Value<String?> agencyId;
  final Value<String?> userId;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const DiscountCodesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.code = const Value.absent(),
    this.type = const Value.absent(),
    this.discount = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.agencyId = const Value.absent(),
    this.userId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DiscountCodesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String code,
    required DiscountCodeType type,
    required double discount,
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.agencyId = const Value.absent(),
    this.userId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        type = Value(type),
        discount = Value(discount);
  static Insertable<DiscountCode> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? code,
    Expression<String>? type,
    Expression<double>? discount,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? agencyId,
    Expression<String>? userId,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (code != null) 'code': code,
      if (type != null) 'type': type,
      if (discount != null) 'discount': discount,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (agencyId != null) 'agency_id': agencyId,
      if (userId != null) 'user_id': userId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DiscountCodesCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<String>? code,
      Value<DiscountCodeType>? type,
      Value<double>? discount,
      Value<DateTime?>? startDate,
      Value<DateTime?>? endDate,
      Value<String?>? agencyId,
      Value<String?>? userId,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return DiscountCodesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      code: code ?? this.code,
      type: type ?? this.type,
      discount: discount ?? this.discount,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      agencyId: agencyId ?? this.agencyId,
      userId: userId ?? this.userId,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
          $DiscountCodesTable.$convertertype.toSql(type.value));
    }
    if (discount.present) {
      map['discount'] = Variable<double>(discount.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (agencyId.present) {
      map['agency_id'] = Variable<String>(agencyId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiscountCodesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('code: $code, ')
          ..write('type: $type, ')
          ..write('discount: $discount, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('agencyId: $agencyId, ')
          ..write('userId: $userId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OrderRowsTable extends OrderRows
    with TableInfo<$OrderRowsTable, OrderRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrderRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => getIt<UuidUtilsInterface>().generate());
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _orderIdMeta =
      const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>(
      'order_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES orders (id)'));
  static const VerificationMeta _agencyIdMeta =
      const VerificationMeta('agencyId');
  @override
  late final GeneratedColumn<String> agencyId = GeneratedColumn<String>(
      'agency_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES agencies (id)'));
  static const VerificationMeta _serviceIdMeta =
      const VerificationMeta('serviceId');
  @override
  late final GeneratedColumn<String> serviceId = GeneratedColumn<String>(
      'service_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES services (id)'));
  static const VerificationMeta _designationMeta =
      const VerificationMeta('designation');
  @override
  late final GeneratedColumn<String> designation = GeneratedColumn<String>(
      'designation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _discountMeta =
      const VerificationMeta('discount');
  @override
  late final GeneratedColumn<double> discount = GeneratedColumn<double>(
      'discount', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _option1IdMeta =
      const VerificationMeta('option1Id');
  @override
  late final GeneratedColumn<String> option1Id = GeneratedColumn<String>(
      'option1_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES service_option_items (id)'));
  static const VerificationMeta _option2IdMeta =
      const VerificationMeta('option2Id');
  @override
  late final GeneratedColumn<String> option2Id = GeneratedColumn<String>(
      'option2_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES service_option_items (id)'));
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
      'quantity', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _grossPriceMeta =
      const VerificationMeta('grossPrice');
  @override
  late final GeneratedColumn<double> grossPrice = GeneratedColumn<double>(
      'gross_price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
      'unit', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _taxLevelMeta =
      const VerificationMeta('taxLevel');
  @override
  late final GeneratedColumnWithTypeConverter<TaxLevel, String> taxLevel =
      GeneratedColumn<String>('tax_level', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<TaxLevel>($OrderRowsTable.$convertertaxLevel);
  static const VerificationMeta _discountCodeIdMeta =
      const VerificationMeta('discountCodeId');
  @override
  late final GeneratedColumn<String> discountCodeId = GeneratedColumn<String>(
      'discount_code_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES discount_codes (id)'));
  static const VerificationMeta _priceListItemIdMeta =
      const VerificationMeta('priceListItemId');
  @override
  late final GeneratedColumn<String> priceListItemId = GeneratedColumn<String>(
      'price_list_item_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES price_list_items (id)'));
  static const VerificationMeta _optionsHaveChangedMeta =
      const VerificationMeta('optionsHaveChanged');
  @override
  late final GeneratedColumn<bool> optionsHaveChanged = GeneratedColumn<bool>(
      'options_have_changed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("options_have_changed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _supplierIdMeta =
      const VerificationMeta('supplierId');
  @override
  late final GeneratedColumn<String> supplierId = GeneratedColumn<String>(
      'supplier_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES suppliers (id)'));
  static const VerificationMeta _withWorkforceMeta =
      const VerificationMeta('withWorkforce');
  @override
  late final GeneratedColumn<bool> withWorkforce = GeneratedColumn<bool>(
      'with_workforce', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("with_workforce" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        orderId,
        agencyId,
        serviceId,
        designation,
        discount,
        option1Id,
        option2Id,
        quantity,
        grossPrice,
        unit,
        taxLevel,
        discountCodeId,
        priceListItemId,
        optionsHaveChanged,
        supplierId,
        withWorkforce
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'order_rows';
  @override
  VerificationContext validateIntegrity(Insertable<OrderRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('agency_id')) {
      context.handle(_agencyIdMeta,
          agencyId.isAcceptableOrUnknown(data['agency_id']!, _agencyIdMeta));
    } else if (isInserting) {
      context.missing(_agencyIdMeta);
    }
    if (data.containsKey('service_id')) {
      context.handle(_serviceIdMeta,
          serviceId.isAcceptableOrUnknown(data['service_id']!, _serviceIdMeta));
    } else if (isInserting) {
      context.missing(_serviceIdMeta);
    }
    if (data.containsKey('designation')) {
      context.handle(
          _designationMeta,
          designation.isAcceptableOrUnknown(
              data['designation']!, _designationMeta));
    } else if (isInserting) {
      context.missing(_designationMeta);
    }
    if (data.containsKey('discount')) {
      context.handle(_discountMeta,
          discount.isAcceptableOrUnknown(data['discount']!, _discountMeta));
    }
    if (data.containsKey('option1_id')) {
      context.handle(_option1IdMeta,
          option1Id.isAcceptableOrUnknown(data['option1_id']!, _option1IdMeta));
    }
    if (data.containsKey('option2_id')) {
      context.handle(_option2IdMeta,
          option2Id.isAcceptableOrUnknown(data['option2_id']!, _option2IdMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('gross_price')) {
      context.handle(
          _grossPriceMeta,
          grossPrice.isAcceptableOrUnknown(
              data['gross_price']!, _grossPriceMeta));
    } else if (isInserting) {
      context.missing(_grossPriceMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    context.handle(_taxLevelMeta, const VerificationResult.success());
    if (data.containsKey('discount_code_id')) {
      context.handle(
          _discountCodeIdMeta,
          discountCodeId.isAcceptableOrUnknown(
              data['discount_code_id']!, _discountCodeIdMeta));
    }
    if (data.containsKey('price_list_item_id')) {
      context.handle(
          _priceListItemIdMeta,
          priceListItemId.isAcceptableOrUnknown(
              data['price_list_item_id']!, _priceListItemIdMeta));
    }
    if (data.containsKey('options_have_changed')) {
      context.handle(
          _optionsHaveChangedMeta,
          optionsHaveChanged.isAcceptableOrUnknown(
              data['options_have_changed']!, _optionsHaveChangedMeta));
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
          _supplierIdMeta,
          supplierId.isAcceptableOrUnknown(
              data['supplier_id']!, _supplierIdMeta));
    }
    if (data.containsKey('with_workforce')) {
      context.handle(
          _withWorkforceMeta,
          withWorkforce.isAcceptableOrUnknown(
              data['with_workforce']!, _withWorkforceMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrderRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      orderId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order_id'])!,
      agencyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}agency_id'])!,
      serviceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}service_id'])!,
      designation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}designation'])!,
      discount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}discount']),
      option1Id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}option1_id']),
      option2Id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}option2_id']),
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quantity'])!,
      grossPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}gross_price'])!,
      unit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit'])!,
      taxLevel: $OrderRowsTable.$convertertaxLevel.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tax_level'])!),
      discountCodeId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}discount_code_id']),
      priceListItemId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}price_list_item_id']),
      optionsHaveChanged: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}options_have_changed'])!,
      supplierId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}supplier_id']),
      withWorkforce: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}with_workforce'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $OrderRowsTable createAlias(String alias) {
    return $OrderRowsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TaxLevel, String, String> $convertertaxLevel =
      const EnumNameConverter<TaxLevel>(TaxLevel.values);
}

class OrderRowsCompanion extends UpdateCompanion<OrderRow> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String> orderId;
  final Value<String> agencyId;
  final Value<String> serviceId;
  final Value<String> designation;
  final Value<double?> discount;
  final Value<String?> option1Id;
  final Value<String?> option2Id;
  final Value<double> quantity;
  final Value<double> grossPrice;
  final Value<String> unit;
  final Value<TaxLevel> taxLevel;
  final Value<String?> discountCodeId;
  final Value<String?> priceListItemId;
  final Value<bool> optionsHaveChanged;
  final Value<String?> supplierId;
  final Value<bool> withWorkforce;
  final Value<int> rowid;
  const OrderRowsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.orderId = const Value.absent(),
    this.agencyId = const Value.absent(),
    this.serviceId = const Value.absent(),
    this.designation = const Value.absent(),
    this.discount = const Value.absent(),
    this.option1Id = const Value.absent(),
    this.option2Id = const Value.absent(),
    this.quantity = const Value.absent(),
    this.grossPrice = const Value.absent(),
    this.unit = const Value.absent(),
    this.taxLevel = const Value.absent(),
    this.discountCodeId = const Value.absent(),
    this.priceListItemId = const Value.absent(),
    this.optionsHaveChanged = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.withWorkforce = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrderRowsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String orderId,
    required String agencyId,
    required String serviceId,
    required String designation,
    this.discount = const Value.absent(),
    this.option1Id = const Value.absent(),
    this.option2Id = const Value.absent(),
    required double quantity,
    required double grossPrice,
    required String unit,
    required TaxLevel taxLevel,
    this.discountCodeId = const Value.absent(),
    this.priceListItemId = const Value.absent(),
    this.optionsHaveChanged = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.withWorkforce = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : orderId = Value(orderId),
        agencyId = Value(agencyId),
        serviceId = Value(serviceId),
        designation = Value(designation),
        quantity = Value(quantity),
        grossPrice = Value(grossPrice),
        unit = Value(unit),
        taxLevel = Value(taxLevel);
  static Insertable<OrderRow> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? orderId,
    Expression<String>? agencyId,
    Expression<String>? serviceId,
    Expression<String>? designation,
    Expression<double>? discount,
    Expression<String>? option1Id,
    Expression<String>? option2Id,
    Expression<double>? quantity,
    Expression<double>? grossPrice,
    Expression<String>? unit,
    Expression<String>? taxLevel,
    Expression<String>? discountCodeId,
    Expression<String>? priceListItemId,
    Expression<bool>? optionsHaveChanged,
    Expression<String>? supplierId,
    Expression<bool>? withWorkforce,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (orderId != null) 'order_id': orderId,
      if (agencyId != null) 'agency_id': agencyId,
      if (serviceId != null) 'service_id': serviceId,
      if (designation != null) 'designation': designation,
      if (discount != null) 'discount': discount,
      if (option1Id != null) 'option1_id': option1Id,
      if (option2Id != null) 'option2_id': option2Id,
      if (quantity != null) 'quantity': quantity,
      if (grossPrice != null) 'gross_price': grossPrice,
      if (unit != null) 'unit': unit,
      if (taxLevel != null) 'tax_level': taxLevel,
      if (discountCodeId != null) 'discount_code_id': discountCodeId,
      if (priceListItemId != null) 'price_list_item_id': priceListItemId,
      if (optionsHaveChanged != null)
        'options_have_changed': optionsHaveChanged,
      if (supplierId != null) 'supplier_id': supplierId,
      if (withWorkforce != null) 'with_workforce': withWorkforce,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrderRowsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<String>? orderId,
      Value<String>? agencyId,
      Value<String>? serviceId,
      Value<String>? designation,
      Value<double?>? discount,
      Value<String?>? option1Id,
      Value<String?>? option2Id,
      Value<double>? quantity,
      Value<double>? grossPrice,
      Value<String>? unit,
      Value<TaxLevel>? taxLevel,
      Value<String?>? discountCodeId,
      Value<String?>? priceListItemId,
      Value<bool>? optionsHaveChanged,
      Value<String?>? supplierId,
      Value<bool>? withWorkforce,
      Value<int>? rowid}) {
    return OrderRowsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      orderId: orderId ?? this.orderId,
      agencyId: agencyId ?? this.agencyId,
      serviceId: serviceId ?? this.serviceId,
      designation: designation ?? this.designation,
      discount: discount ?? this.discount,
      option1Id: option1Id ?? this.option1Id,
      option2Id: option2Id ?? this.option2Id,
      quantity: quantity ?? this.quantity,
      grossPrice: grossPrice ?? this.grossPrice,
      unit: unit ?? this.unit,
      taxLevel: taxLevel ?? this.taxLevel,
      discountCodeId: discountCodeId ?? this.discountCodeId,
      priceListItemId: priceListItemId ?? this.priceListItemId,
      optionsHaveChanged: optionsHaveChanged ?? this.optionsHaveChanged,
      supplierId: supplierId ?? this.supplierId,
      withWorkforce: withWorkforce ?? this.withWorkforce,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (agencyId.present) {
      map['agency_id'] = Variable<String>(agencyId.value);
    }
    if (serviceId.present) {
      map['service_id'] = Variable<String>(serviceId.value);
    }
    if (designation.present) {
      map['designation'] = Variable<String>(designation.value);
    }
    if (discount.present) {
      map['discount'] = Variable<double>(discount.value);
    }
    if (option1Id.present) {
      map['option1_id'] = Variable<String>(option1Id.value);
    }
    if (option2Id.present) {
      map['option2_id'] = Variable<String>(option2Id.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (grossPrice.present) {
      map['gross_price'] = Variable<double>(grossPrice.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (taxLevel.present) {
      map['tax_level'] = Variable<String>(
          $OrderRowsTable.$convertertaxLevel.toSql(taxLevel.value));
    }
    if (discountCodeId.present) {
      map['discount_code_id'] = Variable<String>(discountCodeId.value);
    }
    if (priceListItemId.present) {
      map['price_list_item_id'] = Variable<String>(priceListItemId.value);
    }
    if (optionsHaveChanged.present) {
      map['options_have_changed'] = Variable<bool>(optionsHaveChanged.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<String>(supplierId.value);
    }
    if (withWorkforce.present) {
      map['with_workforce'] = Variable<bool>(withWorkforce.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrderRowsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('orderId: $orderId, ')
          ..write('agencyId: $agencyId, ')
          ..write('serviceId: $serviceId, ')
          ..write('designation: $designation, ')
          ..write('discount: $discount, ')
          ..write('option1Id: $option1Id, ')
          ..write('option2Id: $option2Id, ')
          ..write('quantity: $quantity, ')
          ..write('grossPrice: $grossPrice, ')
          ..write('unit: $unit, ')
          ..write('taxLevel: $taxLevel, ')
          ..write('discountCodeId: $discountCodeId, ')
          ..write('priceListItemId: $priceListItemId, ')
          ..write('optionsHaveChanged: $optionsHaveChanged, ')
          ..write('supplierId: $supplierId, ')
          ..write('withWorkforce: $withWorkforce, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotesTable extends Notes with TableInfo<$NotesTable, Note> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => getIt<UuidUtilsInterface>().generate());
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _representativeIdMeta =
      const VerificationMeta('representativeId');
  @override
  late final GeneratedColumn<String> representativeId = GeneratedColumn<String>(
      'representative_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES representatives (id)'));
  static const VerificationMeta _customerIdMeta =
      const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
      'customer_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES customers (id)'));
  static const VerificationMeta _agencyIdMeta =
      const VerificationMeta('agencyId');
  @override
  late final GeneratedColumn<String> agencyId = GeneratedColumn<String>(
      'agency_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES agencies (id)'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        representativeId,
        customerId,
        agencyId,
        title,
        note
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notes';
  @override
  VerificationContext validateIntegrity(Insertable<Note> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('representative_id')) {
      context.handle(
          _representativeIdMeta,
          representativeId.isAcceptableOrUnknown(
              data['representative_id']!, _representativeIdMeta));
    } else if (isInserting) {
      context.missing(_representativeIdMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id']!, _customerIdMeta));
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('agency_id')) {
      context.handle(_agencyIdMeta,
          agencyId.isAcceptableOrUnknown(data['agency_id']!, _agencyIdMeta));
    } else if (isInserting) {
      context.missing(_agencyIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    } else if (isInserting) {
      context.missing(_noteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Note map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Note(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      representativeId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}representative_id'])!,
      customerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_id'])!,
      agencyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}agency_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(attachedDatabase, alias);
  }
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String> representativeId;
  final Value<String> customerId;
  final Value<String> agencyId;
  final Value<String?> title;
  final Value<String> note;
  final Value<int> rowid;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.representativeId = const Value.absent(),
    this.customerId = const Value.absent(),
    this.agencyId = const Value.absent(),
    this.title = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String representativeId,
    required String customerId,
    required String agencyId,
    this.title = const Value.absent(),
    required String note,
    this.rowid = const Value.absent(),
  })  : representativeId = Value(representativeId),
        customerId = Value(customerId),
        agencyId = Value(agencyId),
        note = Value(note);
  static Insertable<Note> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? representativeId,
    Expression<String>? customerId,
    Expression<String>? agencyId,
    Expression<String>? title,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (representativeId != null) 'representative_id': representativeId,
      if (customerId != null) 'customer_id': customerId,
      if (agencyId != null) 'agency_id': agencyId,
      if (title != null) 'title': title,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotesCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<String>? representativeId,
      Value<String>? customerId,
      Value<String>? agencyId,
      Value<String?>? title,
      Value<String>? note,
      Value<int>? rowid}) {
    return NotesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      representativeId: representativeId ?? this.representativeId,
      customerId: customerId ?? this.customerId,
      agencyId: agencyId ?? this.agencyId,
      title: title ?? this.title,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (representativeId.present) {
      map['representative_id'] = Variable<String>(representativeId.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (agencyId.present) {
      map['agency_id'] = Variable<String>(agencyId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('representativeId: $representativeId, ')
          ..write('customerId: $customerId, ')
          ..write('agencyId: $agencyId, ')
          ..write('title: $title, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EmailTemplatesTable extends EmailTemplates
    with TableInfo<$EmailTemplatesTable, EmailTemplate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmailTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => getIt<UuidUtilsInterface>().generate());
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _templateIdMeta =
      const VerificationMeta('templateId');
  @override
  late final GeneratedColumn<int> templateId = GeneratedColumn<int>(
      'template_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _templateNameMeta =
      const VerificationMeta('templateName');
  @override
  late final GeneratedColumn<String> templateName = GeneratedColumn<String>(
      'template_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, createdAt, updatedAt, templateId, templateName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'email_templates';
  @override
  VerificationContext validateIntegrity(Insertable<EmailTemplate> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('template_id')) {
      context.handle(
          _templateIdMeta,
          templateId.isAcceptableOrUnknown(
              data['template_id']!, _templateIdMeta));
    } else if (isInserting) {
      context.missing(_templateIdMeta);
    }
    if (data.containsKey('template_name')) {
      context.handle(
          _templateNameMeta,
          templateName.isAcceptableOrUnknown(
              data['template_name']!, _templateNameMeta));
    } else if (isInserting) {
      context.missing(_templateNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EmailTemplate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmailTemplate(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      templateId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}template_id'])!,
      templateName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}template_name'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $EmailTemplatesTable createAlias(String alias) {
    return $EmailTemplatesTable(attachedDatabase, alias);
  }
}

class EmailTemplatesCompanion extends UpdateCompanion<EmailTemplate> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> templateId;
  final Value<String> templateName;
  final Value<int> rowid;
  const EmailTemplatesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.templateId = const Value.absent(),
    this.templateName = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EmailTemplatesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required int templateId,
    required String templateName,
    this.rowid = const Value.absent(),
  })  : templateId = Value(templateId),
        templateName = Value(templateName);
  static Insertable<EmailTemplate> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? templateId,
    Expression<String>? templateName,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (templateId != null) 'template_id': templateId,
      if (templateName != null) 'template_name': templateName,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EmailTemplatesCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? templateId,
      Value<String>? templateName,
      Value<int>? rowid}) {
    return EmailTemplatesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      templateId: templateId ?? this.templateId,
      templateName: templateName ?? this.templateName,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<int>(templateId.value);
    }
    if (templateName.present) {
      map['template_name'] = Variable<String>(templateName.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmailTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('templateId: $templateId, ')
          ..write('templateName: $templateName, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DiscountCodesServicesTable extends DiscountCodesServices
    with TableInfo<$DiscountCodesServicesTable, DiscountCodeService> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DiscountCodesServicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _discountCodeIdMeta =
      const VerificationMeta('discountCodeId');
  @override
  late final GeneratedColumn<String> discountCodeId = GeneratedColumn<String>(
      'discount_code_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES discount_codes (id)'));
  static const VerificationMeta _serviceIdMeta =
      const VerificationMeta('serviceId');
  @override
  late final GeneratedColumn<String> serviceId = GeneratedColumn<String>(
      'service_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES services (id)'));
  @override
  List<GeneratedColumn> get $columns => [discountCodeId, serviceId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'discount_codes_services';
  @override
  VerificationContext validateIntegrity(
      Insertable<DiscountCodeService> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('discount_code_id')) {
      context.handle(
          _discountCodeIdMeta,
          discountCodeId.isAcceptableOrUnknown(
              data['discount_code_id']!, _discountCodeIdMeta));
    } else if (isInserting) {
      context.missing(_discountCodeIdMeta);
    }
    if (data.containsKey('service_id')) {
      context.handle(_serviceIdMeta,
          serviceId.isAcceptableOrUnknown(data['service_id']!, _serviceIdMeta));
    } else if (isInserting) {
      context.missing(_serviceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {discountCodeId, serviceId};
  @override
  DiscountCodeService map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DiscountCodeService(
      discountCodeId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}discount_code_id'])!,
      serviceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}service_id'])!,
    );
  }

  @override
  $DiscountCodesServicesTable createAlias(String alias) {
    return $DiscountCodesServicesTable(attachedDatabase, alias);
  }
}

class DiscountCodesServicesCompanion
    extends UpdateCompanion<DiscountCodeService> {
  final Value<String> discountCodeId;
  final Value<String> serviceId;
  final Value<int> rowid;
  const DiscountCodesServicesCompanion({
    this.discountCodeId = const Value.absent(),
    this.serviceId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DiscountCodesServicesCompanion.insert({
    required String discountCodeId,
    required String serviceId,
    this.rowid = const Value.absent(),
  })  : discountCodeId = Value(discountCodeId),
        serviceId = Value(serviceId);
  static Insertable<DiscountCodeService> custom({
    Expression<String>? discountCodeId,
    Expression<String>? serviceId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (discountCodeId != null) 'discount_code_id': discountCodeId,
      if (serviceId != null) 'service_id': serviceId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DiscountCodesServicesCompanion copyWith(
      {Value<String>? discountCodeId,
      Value<String>? serviceId,
      Value<int>? rowid}) {
    return DiscountCodesServicesCompanion(
      discountCodeId: discountCodeId ?? this.discountCodeId,
      serviceId: serviceId ?? this.serviceId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (discountCodeId.present) {
      map['discount_code_id'] = Variable<String>(discountCodeId.value);
    }
    if (serviceId.present) {
      map['service_id'] = Variable<String>(serviceId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiscountCodesServicesCompanion(')
          ..write('discountCodeId: $discountCodeId, ')
          ..write('serviceId: $serviceId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DiscountCodesServiceSubFamiliesTable
    extends DiscountCodesServiceSubFamilies
    with
        TableInfo<$DiscountCodesServiceSubFamiliesTable,
            DiscountCodeServiceSubFamily> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DiscountCodesServiceSubFamiliesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _discountCodeIdMeta =
      const VerificationMeta('discountCodeId');
  @override
  late final GeneratedColumn<String> discountCodeId = GeneratedColumn<String>(
      'discount_code_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES discount_codes (id)'));
  static const VerificationMeta _serviceSubFamilyIdMeta =
      const VerificationMeta('serviceSubFamilyId');
  @override
  late final GeneratedColumn<String> serviceSubFamilyId =
      GeneratedColumn<String>('service_sub_family_id', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'REFERENCES service_sub_families (id)'));
  @override
  List<GeneratedColumn> get $columns => [discountCodeId, serviceSubFamilyId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'discount_codes_service_sub_families';
  @override
  VerificationContext validateIntegrity(
      Insertable<DiscountCodeServiceSubFamily> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('discount_code_id')) {
      context.handle(
          _discountCodeIdMeta,
          discountCodeId.isAcceptableOrUnknown(
              data['discount_code_id']!, _discountCodeIdMeta));
    } else if (isInserting) {
      context.missing(_discountCodeIdMeta);
    }
    if (data.containsKey('service_sub_family_id')) {
      context.handle(
          _serviceSubFamilyIdMeta,
          serviceSubFamilyId.isAcceptableOrUnknown(
              data['service_sub_family_id']!, _serviceSubFamilyIdMeta));
    } else if (isInserting) {
      context.missing(_serviceSubFamilyIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {discountCodeId, serviceSubFamilyId};
  @override
  DiscountCodeServiceSubFamily map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DiscountCodeServiceSubFamily(
      discountCodeId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}discount_code_id'])!,
      serviceSubFamilyId: attachedDatabase.typeMapping.read(DriftSqlType.string,
          data['${effectivePrefix}service_sub_family_id'])!,
    );
  }

  @override
  $DiscountCodesServiceSubFamiliesTable createAlias(String alias) {
    return $DiscountCodesServiceSubFamiliesTable(attachedDatabase, alias);
  }
}

class DiscountCodesServiceSubFamiliesCompanion
    extends UpdateCompanion<DiscountCodeServiceSubFamily> {
  final Value<String> discountCodeId;
  final Value<String> serviceSubFamilyId;
  final Value<int> rowid;
  const DiscountCodesServiceSubFamiliesCompanion({
    this.discountCodeId = const Value.absent(),
    this.serviceSubFamilyId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DiscountCodesServiceSubFamiliesCompanion.insert({
    required String discountCodeId,
    required String serviceSubFamilyId,
    this.rowid = const Value.absent(),
  })  : discountCodeId = Value(discountCodeId),
        serviceSubFamilyId = Value(serviceSubFamilyId);
  static Insertable<DiscountCodeServiceSubFamily> custom({
    Expression<String>? discountCodeId,
    Expression<String>? serviceSubFamilyId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (discountCodeId != null) 'discount_code_id': discountCodeId,
      if (serviceSubFamilyId != null)
        'service_sub_family_id': serviceSubFamilyId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DiscountCodesServiceSubFamiliesCompanion copyWith(
      {Value<String>? discountCodeId,
      Value<String>? serviceSubFamilyId,
      Value<int>? rowid}) {
    return DiscountCodesServiceSubFamiliesCompanion(
      discountCodeId: discountCodeId ?? this.discountCodeId,
      serviceSubFamilyId: serviceSubFamilyId ?? this.serviceSubFamilyId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (discountCodeId.present) {
      map['discount_code_id'] = Variable<String>(discountCodeId.value);
    }
    if (serviceSubFamilyId.present) {
      map['service_sub_family_id'] = Variable<String>(serviceSubFamilyId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiscountCodesServiceSubFamiliesCompanion(')
          ..write('discountCodeId: $discountCodeId, ')
          ..write('serviceSubFamilyId: $serviceSubFamilyId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DiscountCodesServiceFamiliesTable extends DiscountCodesServiceFamilies
    with
        TableInfo<$DiscountCodesServiceFamiliesTable,
            DiscountCodeServiceFamily> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DiscountCodesServiceFamiliesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _discountCodeIdMeta =
      const VerificationMeta('discountCodeId');
  @override
  late final GeneratedColumn<String> discountCodeId = GeneratedColumn<String>(
      'discount_code_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES discount_codes (id)'));
  static const VerificationMeta _serviceFamilyIdMeta =
      const VerificationMeta('serviceFamilyId');
  @override
  late final GeneratedColumn<String> serviceFamilyId = GeneratedColumn<String>(
      'service_family_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES service_families (id)'));
  @override
  List<GeneratedColumn> get $columns => [discountCodeId, serviceFamilyId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'discount_codes_service_families';
  @override
  VerificationContext validateIntegrity(
      Insertable<DiscountCodeServiceFamily> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('discount_code_id')) {
      context.handle(
          _discountCodeIdMeta,
          discountCodeId.isAcceptableOrUnknown(
              data['discount_code_id']!, _discountCodeIdMeta));
    } else if (isInserting) {
      context.missing(_discountCodeIdMeta);
    }
    if (data.containsKey('service_family_id')) {
      context.handle(
          _serviceFamilyIdMeta,
          serviceFamilyId.isAcceptableOrUnknown(
              data['service_family_id']!, _serviceFamilyIdMeta));
    } else if (isInserting) {
      context.missing(_serviceFamilyIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {discountCodeId, serviceFamilyId};
  @override
  DiscountCodeServiceFamily map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DiscountCodeServiceFamily(
      discountCodeId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}discount_code_id'])!,
      serviceFamilyId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}service_family_id'])!,
    );
  }

  @override
  $DiscountCodesServiceFamiliesTable createAlias(String alias) {
    return $DiscountCodesServiceFamiliesTable(attachedDatabase, alias);
  }
}

class DiscountCodesServiceFamiliesCompanion
    extends UpdateCompanion<DiscountCodeServiceFamily> {
  final Value<String> discountCodeId;
  final Value<String> serviceFamilyId;
  final Value<int> rowid;
  const DiscountCodesServiceFamiliesCompanion({
    this.discountCodeId = const Value.absent(),
    this.serviceFamilyId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DiscountCodesServiceFamiliesCompanion.insert({
    required String discountCodeId,
    required String serviceFamilyId,
    this.rowid = const Value.absent(),
  })  : discountCodeId = Value(discountCodeId),
        serviceFamilyId = Value(serviceFamilyId);
  static Insertable<DiscountCodeServiceFamily> custom({
    Expression<String>? discountCodeId,
    Expression<String>? serviceFamilyId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (discountCodeId != null) 'discount_code_id': discountCodeId,
      if (serviceFamilyId != null) 'service_family_id': serviceFamilyId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DiscountCodesServiceFamiliesCompanion copyWith(
      {Value<String>? discountCodeId,
      Value<String>? serviceFamilyId,
      Value<int>? rowid}) {
    return DiscountCodesServiceFamiliesCompanion(
      discountCodeId: discountCodeId ?? this.discountCodeId,
      serviceFamilyId: serviceFamilyId ?? this.serviceFamilyId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (discountCodeId.present) {
      map['discount_code_id'] = Variable<String>(discountCodeId.value);
    }
    if (serviceFamilyId.present) {
      map['service_family_id'] = Variable<String>(serviceFamilyId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiscountCodesServiceFamiliesCompanion(')
          ..write('discountCodeId: $discountCodeId, ')
          ..write('serviceFamilyId: $serviceFamilyId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AgencyDatabase extends GeneratedDatabase {
  _$AgencyDatabase(QueryExecutor e) : super(e);
  late final $AgenciesTable agencies = $AgenciesTable(this);
  late final $RepresentativesTable representatives =
      $RepresentativesTable(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $ContactsTable contacts = $ContactsTable(this);
  late final $UserSettingsTable userSettings = $UserSettingsTable(this);
  late final $SuppliersTable suppliers = $SuppliersTable(this);
  late final $ServiceFamiliesTable serviceFamilies =
      $ServiceFamiliesTable(this);
  late final $ServiceSubFamiliesTable serviceSubFamilies =
      $ServiceSubFamiliesTable(this);
  late final $FileDataFamiliesTable fileDataFamilies =
      $FileDataFamiliesTable(this);
  late final $FairsTable fairs = $FairsTable(this);
  late final $OrdersTable orders = $OrdersTable(this);
  late final $FileDatasTable fileDatas = $FileDatasTable(this);
  late final $ServicesTable services = $ServicesTable(this);
  late final $ServiceOptionItemsTable serviceOptionItems =
      $ServiceOptionItemsTable(this);
  late final $ServiceOptionsTable serviceOptions = $ServiceOptionsTable(this);
  late final $PriceListsTable priceLists = $PriceListsTable(this);
  late final $PriceListItemsTable priceListItems = $PriceListItemsTable(this);
  late final $OrdersContactsTable ordersContacts = $OrdersContactsTable(this);
  late final $DiscountCodesTable discountCodes = $DiscountCodesTable(this);
  late final $OrderRowsTable orderRows = $OrderRowsTable(this);
  late final $NotesTable notes = $NotesTable(this);
  late final $EmailTemplatesTable emailTemplates = $EmailTemplatesTable(this);
  late final $DiscountCodesServicesTable discountCodesServices =
      $DiscountCodesServicesTable(this);
  late final $DiscountCodesServiceSubFamiliesTable
      discountCodesServiceSubFamilies =
      $DiscountCodesServiceSubFamiliesTable(this);
  late final $DiscountCodesServiceFamiliesTable discountCodesServiceFamilies =
      $DiscountCodesServiceFamiliesTable(this);
  late final AgencyDriftDao agencyDriftDao =
      AgencyDriftDao(this as AgencyDatabase);
  late final ContactDriftDao contactDriftDao =
      ContactDriftDao(this as AgencyDatabase);
  late final CustomerDriftDao customerDriftDao =
      CustomerDriftDao(this as AgencyDatabase);
  late final DiscountCodeDriftDao discountCodeDriftDao =
      DiscountCodeDriftDao(this as AgencyDatabase);
  late final EmailTemplateDriftDao emailTemplateDriftDao =
      EmailTemplateDriftDao(this as AgencyDatabase);
  late final FairDriftDao fairDriftDao = FairDriftDao(this as AgencyDatabase);
  late final FileDataDriftDao fileDataDriftDao =
      FileDataDriftDao(this as AgencyDatabase);
  late final FileDataFamilyDriftDao fileDataFamilyDriftDao =
      FileDataFamilyDriftDao(this as AgencyDatabase);
  late final NoteDriftDao noteDriftDao = NoteDriftDao(this as AgencyDatabase);
  late final OrderDriftDao orderDriftDao =
      OrderDriftDao(this as AgencyDatabase);
  late final OrderContactDriftDao orderContactDriftDao =
      OrderContactDriftDao(this as AgencyDatabase);
  late final RepresentativeDriftDao representativeDriftDao =
      RepresentativeDriftDao(this as AgencyDatabase);
  late final ServiceFamilyDriftDao serviceFamilyDriftDao =
      ServiceFamilyDriftDao(this as AgencyDatabase);
  late final ServiceSubFamilyDriftDao serviceSubFamilyDriftDao =
      ServiceSubFamilyDriftDao(this as AgencyDatabase);
  late final ServiceDriftDao serviceDriftDao =
      ServiceDriftDao(this as AgencyDatabase);
  late final DiscountCodeServiceFamilyDriftDao
      discountCodeServiceFamilyDriftDao =
      DiscountCodeServiceFamilyDriftDao(this as AgencyDatabase);
  late final DiscountCodeServiceSubFamilyDriftDao
      discountCodeServiceSubFamilyDriftDao =
      DiscountCodeServiceSubFamilyDriftDao(this as AgencyDatabase);
  late final DiscountCodeServiceDriftDao discountCodeServiceDriftDao =
      DiscountCodeServiceDriftDao(this as AgencyDatabase);
  late final ServiceOptionItemDriftDao serviceOptionItemDriftDao =
      ServiceOptionItemDriftDao(this as AgencyDatabase);
  late final ServiceOptionDriftDao serviceOptionDriftDao =
      ServiceOptionDriftDao(this as AgencyDatabase);
  late final PriceListDriftDao priceListDriftDao =
      PriceListDriftDao(this as AgencyDatabase);
  late final PriceListItemDriftDao priceListItemDriftDao =
      PriceListItemDriftDao(this as AgencyDatabase);
  late final OrderRowDriftDao orderRowDriftDao =
      OrderRowDriftDao(this as AgencyDatabase);
  late final SupplierDriftDao supplierDriftDao =
      SupplierDriftDao(this as AgencyDatabase);
  late final UserSettingDriftDao userSettingDriftDao =
      UserSettingDriftDao(this as AgencyDatabase);
  Selectable<Customer> customersByAddressOrByPhoneOrByEmail(
      {required List<String> fullAddresses,
      required List<String> emails,
      required List<String> formattedPhones,
      required List<String> formattedMobilePhones,
      required List<String> formattedPhonesWithCode,
      required List<String> formattedMobilePhonesWithCode}) {
    var $arrayStartIndex = 1;
    final expandedfullAddresses =
        $expandVar($arrayStartIndex, fullAddresses.length);
    $arrayStartIndex += fullAddresses.length;
    final expandedemails = $expandVar($arrayStartIndex, emails.length);
    $arrayStartIndex += emails.length;
    final expandedformattedPhones =
        $expandVar($arrayStartIndex, formattedPhones.length);
    $arrayStartIndex += formattedPhones.length;
    final expandedformattedMobilePhones =
        $expandVar($arrayStartIndex, formattedMobilePhones.length);
    $arrayStartIndex += formattedMobilePhones.length;
    final expandedformattedPhonesWithCode =
        $expandVar($arrayStartIndex, formattedPhonesWithCode.length);
    $arrayStartIndex += formattedPhonesWithCode.length;
    final expandedformattedMobilePhonesWithCode =
        $expandVar($arrayStartIndex, formattedMobilePhonesWithCode.length);
    $arrayStartIndex += formattedMobilePhonesWithCode.length;
    return customSelect(
        'SELECT DISTINCT c.* FROM customers AS c JOIN contacts AS co ON co.customer_id = c.id WHERE c.searchable_address IN ($expandedfullAddresses) OR co.searchable_email IN ($expandedemails) OR(co.searchable_phone <> \'\' AND(co.searchable_phone IN ($expandedformattedPhones) OR co.searchable_phone IN ($expandedformattedMobilePhones)))OR(co.searchable_phone_with_code <> \'\' AND(co.searchable_phone_with_code IN ($expandedformattedPhonesWithCode) OR co.searchable_phone_with_code IN ($expandedformattedMobilePhonesWithCode)))OR(co.searchable_mobile_phone <> \'\' AND(co.searchable_mobile_phone IN ($expandedformattedPhones) OR co.searchable_mobile_phone IN ($expandedformattedMobilePhones)))OR(co.searchable_mobile_phone_with_code <> \'\' AND(co.searchable_mobile_phone_with_code IN ($expandedformattedPhonesWithCode) OR co.searchable_mobile_phone_with_code IN ($expandedformattedMobilePhonesWithCode)))',
        variables: [
          for (var $ in fullAddresses) Variable<String>($),
          for (var $ in emails) Variable<String>($),
          for (var $ in formattedPhones) Variable<String>($),
          for (var $ in formattedMobilePhones) Variable<String>($),
          for (var $ in formattedPhonesWithCode) Variable<String>($),
          for (var $ in formattedMobilePhonesWithCode) Variable<String>($)
        ],
        readsFrom: {
          customers,
          contacts,
        }).asyncMap(customers.mapFromRow);
  }

  Selectable<Service> servicesByDiscountId({required String discountCodeId}) {
    return customSelect(
        'SELECT s.* FROM services AS s JOIN discount_codes_services AS dcs ON dcs.service_id = s.id WHERE dcs.discount_code_id = ?1',
        variables: [
          Variable<String>(discountCodeId)
        ],
        readsFrom: {
          services,
          discountCodesServices,
        }).asyncMap(services.mapFromRow);
  }

  Selectable<Service> activeServicesByFamilyId({required String familyId}) {
    return customSelect(
        'SELECT s.* FROM services AS s JOIN service_sub_families AS ssf ON ssf.id = s.sub_family_id JOIN service_families AS sf ON sf.id = ssf.family_id WHERE sf.id = ?1 AND s.status = 1 ORDER BY s.label ASC',
        variables: [
          Variable<String>(familyId)
        ],
        readsFrom: {
          services,
          serviceSubFamilies,
          serviceFamilies,
        }).asyncMap(services.mapFromRow);
  }

  Selectable<ServiceSubFamily> serviceSubFamiliesByDiscountId(
      {required String discountCodeId}) {
    return customSelect(
        'SELECT ssf.* FROM service_sub_families AS ssf JOIN discount_codes_service_sub_families AS dcssf ON dcssf.service_sub_family_id = ssf.id WHERE dcssf.discount_code_id = ?1',
        variables: [
          Variable<String>(discountCodeId)
        ],
        readsFrom: {
          serviceSubFamilies,
          discountCodesServiceSubFamilies,
        }).asyncMap(serviceSubFamilies.mapFromRow);
  }

  Selectable<ServiceFamily> activeServiceFamilies() {
    return customSelect(
        'SELECT sf.* FROM service_families AS sf JOIN service_sub_families AS ssf ON ssf.family_id = sf.id JOIN services AS s ON s.sub_family_id = ssf.id WHERE s.status = 1 GROUP BY sf.id HAVING COUNT(s.id) > 0 ORDER BY sf.position ASC',
        variables: [],
        readsFrom: {
          serviceFamilies,
          serviceSubFamilies,
          services,
        }).asyncMap(serviceFamilies.mapFromRow);
  }

  Selectable<ServiceFamily> serviceFamiliesByDiscountId(
      {required String discountCodeId}) {
    return customSelect(
        'SELECT sf.* FROM service_families AS sf JOIN discount_codes_service_families AS dcsf ON dcsf.service_family_id = sf.id WHERE dcsf.discount_code_id = ?1',
        variables: [
          Variable<String>(discountCodeId)
        ],
        readsFrom: {
          serviceFamilies,
          discountCodesServiceFamilies,
        }).asyncMap(serviceFamilies.mapFromRow);
  }

  Selectable<DiscountCode> availableDiscountCodes({required String date}) {
    return customSelect(
        'SELECT dc.* FROM discount_codes AS dc WHERE dc.deleted_at IS NULL AND((dc.start_date IS NULL AND dc.end_date IS NULL)OR(strftime(\'%Y-%m-%d 00:00:00\', datetime(julianday(datetime(dc.start_date, \'unixepoch\')) +(2.0 / 24.0), \'localtime\')) <= strftime(\'%Y-%m-%d 00:00:00\', ?1) AND strftime(\'%Y-%m-%d 00:00:00\', datetime(julianday(datetime(dc.end_date, \'unixepoch\')) +(2.0 / 24.0), \'localtime\')) >= strftime(\'%Y-%m-%d 00:00:00\', ?1)))',
        variables: [
          Variable<String>(date)
        ],
        readsFrom: {
          discountCodes,
        }).asyncMap(discountCodes.mapFromRow);
  }

  Selectable<DiscountCode> availableDiscountCodesByCode(
      {required String code, required String date}) {
    return customSelect(
        'SELECT dc.* FROM discount_codes AS dc WHERE dc.code = ?1 AND dc.deleted_at IS NULL AND((dc.start_date IS NULL AND dc.end_date IS NULL)OR(strftime(\'%Y-%m-%d 00:00:00\', datetime(julianday(datetime(dc.start_date, \'unixepoch\')) +(2.0 / 24.0), \'localtime\')) <= strftime(\'%Y-%m-%d 00:00:00\', ?2) AND strftime(\'%Y-%m-%d 00:00:00\', datetime(julianday(datetime(dc.end_date, \'unixepoch\')) +(2.0 / 24.0), \'localtime\')) >= strftime(\'%Y-%m-%d 00:00:00\', ?2)))',
        variables: [
          Variable<String>(code),
          Variable<String>(date)
        ],
        readsFrom: {
          discountCodes,
        }).asyncMap(discountCodes.mapFromRow);
  }

  Selectable<Contact> contactsByOrderId({required String orderId}) {
    return customSelect(
        'SELECT c.* FROM contacts AS c JOIN orders_contacts AS oc ON oc.contact_id = c.id WHERE oc.order_id = ?1',
        variables: [
          Variable<String>(orderId)
        ],
        readsFrom: {
          contacts,
          ordersContacts,
        }).asyncMap(contacts.mapFromRow);
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        agencies,
        representatives,
        customers,
        contacts,
        userSettings,
        suppliers,
        serviceFamilies,
        serviceSubFamilies,
        fileDataFamilies,
        fairs,
        orders,
        fileDatas,
        services,
        serviceOptionItems,
        serviceOptions,
        priceLists,
        priceListItems,
        ordersContacts,
        discountCodes,
        orderRows,
        notes,
        emailTemplates,
        discountCodesServices,
        discountCodesServiceSubFamilies,
        discountCodesServiceFamilies
      ];
}
