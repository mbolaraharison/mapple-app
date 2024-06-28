import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';
import 'package:easy_localization/easy_localization.dart';
export 'package:collection/collection.dart';

class Service extends AbstractBaseModel implements Insertable<Service> {
  Service({
    required super.id,
    required this.label,
    required this.designation,
    required this.category,
    required this.defaultVat,
    required this.unit,
    required this.status,
    required this.subFamilyId,
    required this.agencyId,
    required this.sageId,
    required this.isCleaning,
    required this.sheetFileDataId,
    super.createdAt,
    super.updatedAt,
  }) {
    searchableLabel = label.toSearchable();
  }

  // Variables:-----------------------------------------------------------------
  final String label;
  final String? designation;
  final ServiceCategory category;
  final TaxLevel defaultVat;
  final String unit;
  final int status;
  final String subFamilyId;
  final String? agencyId;
  final String sageId;
  final bool isCleaning;
  final String? sheetFileDataId;

  ServiceSubFamily? subFamily;
  List<ServiceOption> options = [];
  FileData? sheetFileData;

  // Search fields
  late String searchableLabel;

  // Getters:--------------------------------------------------------------------
  bool get hasOptions {
    return options.isNotEmpty;
  }

  int get optionsCount {
    if (!hasOptions) return 0;
    return options.first.option2Id != null ? 2 : 1;
  }

  List<ServiceOptionItem>? get firstLevelOptionItems {
    if (!hasOptions) return null;
    List<ServiceOptionItem> firstLevelOptionItems = options
        .map((e) {
          return e.option1;
        })
        .where((element) => element != null)
        .cast<ServiceOptionItem>()
        .toList();

    // Remove duplicates
    firstLevelOptionItems = firstLevelOptionItems.fold<List<ServiceOptionItem>>(
        [], (List<ServiceOptionItem> list, ServiceOptionItem element) {
      if (!list.any((e) => e.id == element.id)) {
        list.add(element);
      }
      return list;
    }).toList();

    return firstLevelOptionItems;
  }

  bool get isActive => status == 1;

  bool get isMiscellanous {
    return category == ServiceCategory.DIV;
  }

  // Methods:-------------------------------------------------------------------
  Future<void> loadSubFamily(
      {bool eager = false, List<Type> flow = const []}) async {
    // check flow
    flow = List.from(flow);
    if (!flow.contains(Service)) {
      flow.add(Service);
    } else {
      return;
    }
    subFamily = await getIt<ServiceSubFamilyServiceInterface>()
        .getById(subFamilyId, eager: eager, flow: flow);
  }

  Future<void> loadOptions(
      {bool eager = false, List<Type> flow = const []}) async {
    // check flow
    flow = List.from(flow);
    if (!flow.contains(Service)) {
      flow.add(Service);
    } else {
      return;
    }
    options = await getIt<ServiceOptionServiceInterface>()
        .getByServiceId(id, eager: eager, flow: flow);
  }

  Future<void> loadSheetFileData() async {
    if (sheetFileDataId == null) return;
    sheetFileData =
        await getIt<FileDataServiceInterface>().getById(sheetFileDataId!);
  }

  @override
  Future<void> loadData(
      {bool eager = false, List<Type> flow = const []}) async {
    await loadSubFamily(eager: eager, flow: flow);
    await loadOptions(eager: eager, flow: flow);
    await loadSheetFileData();
  }

  List<ServiceOptionItem>? getSecondLevelOptionItems(
    ServiceOptionItem firstLevelOptionItem,
  ) {
    if (!hasOptions || optionsCount != 2) return null;

    return options
        .where((e) => e.option1Id == firstLevelOptionItem.id)
        .map((e) {
          return e.option2;
        })
        .where((element) => element != null)
        .cast<ServiceOptionItem>()
        .toList();
  }

  String getUnit(PriceListItem? priceListItem) {
    String computedUnit = unit;

    if (priceListItem != null) {
      computedUnit = priceListItem.unit;
    }

    return computedUnit;
  }

  String getUnitLabel(PriceListItem? priceListItem) {
    String computedUnit = getUnit(priceListItem);
    if (computedUnit == 'FOR') {
      return 'unit.FOR'.tr();
    }
    return computedUnit;
  }

  // Base methods:--------------------------------------------------------------
  factory Service.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Service(
      id: snapshot.id,
      label: data?['label'],
      designation: data?['designation'] ?? '',
      category: ServiceCategory.values.firstWhere(
        (e) => e.name == data?['category'],
        orElse: () => ServiceCategory.PREST,
      ),
      defaultVat: TaxLevel.values.firstWhere(
        (e) => e.name == data?['defaultVat'],
      ),
      unit: data?['unit'],
      status: data?['status'],
      subFamilyId: data?['subFamilyId'],
      agencyId: data?['agencyId'],
      sageId: data?['sageId'],
      isCleaning: data?['isCleaning'] ?? false,
      sheetFileDataId: data?['sheetFileDataId'],
      createdAt: (data?['createdAt'] as Timestamp).toDate(),
      updatedAt: (data?['updatedAt'] as Timestamp).toDate(),
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'label': label,
      'designation': designation,
      'category': category.name,
      'defaultVat': defaultVat.name,
      'unit': unit,
      'status': status,
      'subFamilyId': subFamilyId,
      'agencyId': agencyId,
      'sageId': sageId,
      'isCleaning': isCleaning,
      'sheetFileDataId': sheetFileDataId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  Service copyWith({
    String? id,
    String? label,
    String? designation,
    ServiceCategory? category,
    TaxLevel? defaultVat,
    String? unit,
    int? status,
    String? subFamilyId,
    String? agencyId,
    String? sageId,
    bool? isCleaning,
    String? sheetFileDataId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Service(
      id: id ?? this.id,
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
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    StringUtilsInterface stringUtils = getIt<StringUtilsInterface>();
    return {
      'id': Variable<String>(id),
      'label': Variable<String>(label),
      'designation': Variable<String>(designation),
      'category': Variable<String>(category.name),
      'default_vat': Variable<String>(defaultVat.name),
      'unit': Variable<String>(unit),
      'status': Variable<int>(status),
      'sub_family_id': Variable<String>(subFamilyId),
      'agency_id': Variable<String>(stringUtils.valueIfNotEmpty(agencyId)),
      'sage_id': Variable<String>(sageId),
      'is_cleaning': Variable<bool>(isCleaning),
      'sheet_file_data_id':
          Variable<String>(stringUtils.valueIfNotEmpty(sheetFileDataId)),
      'searchable_label': Variable<String>(searchableLabel),
      'created_at': Variable<DateTime>(createdAt),
      'updated_at': Variable<DateTime>(updatedAt),
    };
  }

  @override
  bool identicalTo(AbstractBaseModel other) {
    if (identical(this, other)) return true;

    return other is Service &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.label == label &&
        other.designation == designation &&
        other.category == category &&
        other.defaultVat == defaultVat &&
        other.unit == unit &&
        other.status == status &&
        other.subFamilyId == subFamilyId &&
        other.agencyId == agencyId &&
        other.sageId == sageId &&
        other.isCleaning == isCleaning &&
        other.sheetFileDataId == sheetFileDataId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
}
