import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart' hide Table;
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';
import 'package:path/path.dart' as p;
import 'package:easy_localization/easy_localization.dart';

part 'agency_database.g.dart';

const String agencyDatabasePath = 'databases/agency_database.sqlite';

@DriftDatabase(tables: [
  Agencies,
  Contacts,
  Customers,
  DiscountCodes,
  EmailTemplates,
  Fairs,
  FileDatas,
  FileDataFamilies,
  Notes,
  Orders,
  OrdersContacts,
  Representatives,
  ServiceFamilies,
  ServiceSubFamilies,
  Services,
  DiscountCodesServices,
  DiscountCodesServiceSubFamilies,
  DiscountCodesServiceFamilies,
  ServiceOptionItems,
  ServiceOptions,
  PriceLists,
  PriceListItems,
  OrderRows,
  Suppliers,
  UserSettings,
], daos: [
  AgencyDriftDao,
  ContactDriftDao,
  CustomerDriftDao,
  DiscountCodeDriftDao,
  EmailTemplateDriftDao,
  FairDriftDao,
  FileDataDriftDao,
  FileDataFamilyDriftDao,
  NoteDriftDao,
  OrderDriftDao,
  OrderContactDriftDao,
  RepresentativeDriftDao,
  ServiceFamilyDriftDao,
  ServiceSubFamilyDriftDao,
  ServiceDriftDao,
  DiscountCodeServiceFamilyDriftDao,
  DiscountCodeServiceSubFamilyDriftDao,
  DiscountCodeServiceDriftDao,
  ServiceOptionItemDriftDao,
  ServiceOptionDriftDao,
  PriceListDriftDao,
  PriceListItemDriftDao,
  OrderRowDriftDao,
  SupplierDriftDao,
  UserSettingDriftDao,
], include: {
  'contact.drift',
  'discount_code.drift',
  'service_family.drift',
  'service_sub_family.drift',
  'service.drift',
  'customer.drift',
})
class AgencyDatabase extends _$AgencyDatabase with PrivateDirectoryMixin {
  AgencyDatabase() : super(_openConnection());

  late final AuthStoreInterface _authStore = getIt<AuthStoreInterface>();
  late final SyncStoreInterface _syncStore = getIt<SyncStoreInterface>();
  late final LocalDbUtilsInterface _localDbUtils =
      getIt<LocalDbUtilsInterface>();
  late final RepresentativeServiceInterface _representativeService =
      getIt<RepresentativeServiceInterface>();
  late final AgencyServiceInterface _agencyService =
      getIt<AgencyServiceInterface>();
  late final ContactServiceInterface _contactService =
      getIt<ContactServiceInterface>();
  late final CustomerServiceInterface _customerService =
      getIt<CustomerServiceInterface>();
  late final DiscountCodeServiceInterface _discountCodesService =
      getIt<DiscountCodeServiceInterface>();
  late final EmailTemplateServiceInterface _emailTemplateService =
      getIt<EmailTemplateServiceInterface>();
  late final FairServiceInterface _fairService = getIt<FairServiceInterface>();
  late final FileDataServiceInterface _fileDataService =
      getIt<FileDataServiceInterface>();
  late final FileDataFamilyServiceInterface _fileDataFamilyService =
      getIt<FileDataFamilyServiceInterface>();
  late final NoteServiceInterface _noteService = getIt<NoteServiceInterface>();
  late final NotificationTokenServiceInterface _notificationTokenService =
      getIt<NotificationTokenServiceInterface>();
  late final OrderServiceInterface _orderService =
      getIt<OrderServiceInterface>();
  late final OrderRowServiceInterface _orderRowService =
      getIt<OrderRowServiceInterface>();
  late final PriceListServiceInterface _priceListService =
      getIt<PriceListServiceInterface>();
  late final PriceListItemServiceInterface _priceListItemService =
      getIt<PriceListItemServiceInterface>();
  late final ServiceServiceInterface _serviceService =
      getIt<ServiceServiceInterface>();
  late final ServiceFamilyServiceInterface _serviceFamilyService =
      getIt<ServiceFamilyServiceInterface>();
  late final ServiceOptionServiceInterface _serviceOptionService =
      getIt<ServiceOptionServiceInterface>();
  late final ServiceOptionItemServiceInterface _serviceOptionItemService =
      getIt<ServiceOptionItemServiceInterface>();
  late final ServiceSubFamilyServiceInterface _serviceSubFamilyService =
      getIt<ServiceSubFamilyServiceInterface>();
  late final SupplierServiceInterface _supplierService =
      getIt<SupplierServiceInterface>();
  late final UserSettingServiceInterface _userSettingService =
      getIt<UserSettingServiceInterface>();

  late final DiscountCodeServiceDriftDao _discountCodeServiceDao =
      getIt.get<DiscountCodeServiceDriftDao>();
  late final DiscountCodeServiceFamilyDriftDao _discountCodeServiceFamilyDao =
      getIt.get<DiscountCodeServiceFamilyDriftDao>();
  late final DiscountCodeServiceSubFamilyDriftDao
      _discountCodeServiceSubFamilyDao =
      getIt.get<DiscountCodeServiceSubFamilyDriftDao>();
  late final OrderContactDriftDao _orderContactDao =
      getIt.get<OrderContactDriftDao>();

  late final RootNavigatorInterface _rootNavigator =
      getIt.get<RootNavigatorInterface>();

  @override
  int get schemaVersion => 1;

  final _representativeChangeStreamController =
      StreamController<void>.broadcast();

  Stream<void> get representativeChangeStream =>
      _representativeChangeStreamController.stream;

  // Static:--------------------------------------------------------------------
  static Future<AgencyDatabase> createDatabase() async {
    if (kDebugMode) {
      print('createDatabase');
    }
    final dbFolder = await PrivateDirectoryMixin.getPrivateDirectory();
    final file = File(p.join(dbFolder.path, agencyDatabasePath));
    // Delete the database file.
    if (await file.exists()) {
      await file.delete();
    }

    final database = AgencyDatabase();
    await database.executor.ensureOpen(database);
    return database;
  }

  // Queries:-------------------------------------------------------------------

  // Methods:-------------------------------------------------------------------
  void initSync() {
    _onAuthChange(_authStore.currentUser);
    reaction((_) => _authStore.currentUser, _onAuthChange);
  }

  Future<void> _onAuthChange(User? user) async {
    _authStore.setIsLoading(true);
    // If user is logged in
    if (user != null) {
      // Get current agency in local db
      final String? agencyId =
          await _localDbUtils.get(Representative.currentAgencyIdKey);

      await load(
          email: _authStore.currentUser?.email ?? '', agencyId: agencyId);
      _authStore.setIsLoading(false);
    } else {
      _stopAllSync();
      await _clearDatabase();
      _authStore.setIsLoading(false);
    }
  }

  // Get representative by email and agency id if defined
  // Load representative first but run AgencySync first
  Future<void> load({required String email, required String? agencyId}) async {
    await _clearDatabase();
    _representativeChangeStreamController.add(null);
    late Representative? newItem;
    late UserSetting? newItemSetting;

    if (kDebugMode) {
      print('Start synchronization ');
    }

    if (agencyId != null) {
      newItem = await _representativeService.getByEmailByAgencyIdFromFirestore(
          email, agencyId);

      newItem ??=
          await _representativeService.getFirstByEmailFromFirestore(email);
    } else {
      newItem =
          await _representativeService.getFirstByEmailFromFirestore(email);
    }

    if (newItem == null) {
      _authStore.logout();
      _rootNavigator.key.currentState?.pushNamedAndRemoveUntil(
        _rootNavigator.loginRoute,
        (route) => false,
      );
      Fluttertoast.showToast(
        msg: 'auth.errors.unauthorized'.tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: CupertinoColors.destructiveRed,
        textColor: CupertinoColors.white,
        fontSize: 16.0,
      );
      return;
    }

    // Save firebase token in db
    String? token = await FirebaseMessaging.instance.getToken();
    DeviceInfoUtilsInterface deviceInfoUtils =
        getIt<DeviceInfoUtilsInterface>();
    String? deviceId = await deviceInfoUtils.getId();
    if (token != null && deviceId != null) {
      NotificationToken notificationToken = NotificationToken(
        id: getIt<UuidUtilsInterface>().generate(),
        representativeId: newItem.id,
        deviceId: deviceId,
        token: token,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await _notificationTokenService.createOrUpdate(notificationToken);

      // Any time the token refreshes, store this in the database too.
      FirebaseMessaging.instance.onTokenRefresh.listen((value) async {
        NotificationToken notificationToken = NotificationToken(
          id: getIt<UuidUtilsInterface>().generate(),
          representativeId: newItem!.id,
          deviceId: deviceId,
          token: value,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        await _notificationTokenService.createOrUpdate(notificationToken);
      });
    }

    // Update app version
    newItemSetting = await _userSettingService.getCurrentFromFirestore();
    await newItemSetting?.updateAppVersion();

    // Save new agency id in local db
    final newAgencyId = newItem.agencyId;
    _localDbUtils.put(Representative.currentAgencyIdKey, newAgencyId);

    // if representative is not direct sale => check if there is a fair stored in local db
    if (!newItem.isDirectSale) {
      final String? fairId =
          await _localDbUtils.get(Representative.currentFairIdKey);
      // if fairId does not exist in local storage => set direct sale
      if (fairId == null) {
        newItem = await _representativeService.setIsDirectSale(newItem, true,
            applyToFirestore: true);
      } else {
        Fair? fair = await _fairService.getByIdFromFirestore(fairId);
        // if fair does not exist => set direct sale
        if (fair == null) {
          newItem = await _representativeService.setIsDirectSale(newItem, true,
              applyToFirestore: true);
        } else {
          // if fair exists but in the wrong agency => set direct sale
          if (fair.agencyId != newAgencyId) {
            newItem = await _representativeService
                .setIsDirectSale(newItem, true, applyToFirestore: true);
          } else {
            // if fair exists in the current agency but is not valid => set direct sale
            if (!fair.isValid) {
              newItem = await _representativeService
                  .setIsDirectSale(newItem, true, applyToFirestore: true);
            } else {
              await _localDbUtils.put(Representative.currentFairIdKey, fair.id);
            }
          }
        }
      }
    } else {
      await _localDbUtils.delete(Representative.currentFairIdKey);
    }

    int startTime = DateTime.now().millisecondsSinceEpoch;

    await _startSyncAndRetry(newItem, newAgencyId);

    int endTime = DateTime.now().millisecondsSinceEpoch;
    double durationInSec = (endTime - startTime) / 1000;
    if (kDebugMode) {
      print('End synchronization in $durationInSec s');
    }
  }

  Future<void> _startSyncAndRetry(Representative rep, String agencyId,
      {int retry = 0}) async {
    await _disableForeignKeys();

    await _startAllSync(agencyId);

    await _enableForeignKeys();

    // Check foreign key constraints
    try {
      // run foreign check and return result
      Selectable<QueryRow> selectable = customSelect('''
      select 
        fkc."table" as "table",
        fkl."from" as "column",
        fkc."rowid" as "rowid",
        fkc."parent" as "parent"
      from 
        pragma_foreign_key_check as fkc,
        pragma_foreign_key_list(fkc."table") fkl
      where 
        fkl.id = fkc.fkid
      ''');
      List<Future<Map<String, String>>> resultFuture =
          await selectable.map((p0) async {
        Map<String, String> result = {
          'table': p0.read<String>('table'),
          'column': p0.read<String>('column'),
        };
        Selectable<QueryRow> selectableRowInError = customSelect(
          "SELECT t.* FROM ${p0.read<String>("table")} as t where rowid = ${p0.read<String>("rowid")}",
        );
        QueryRow? queryRow = await selectableRowInError.getSingleOrNull();
        if (queryRow == null) {
          result['rowid'] = p0.read<String>('rowid');
        } else {
          final Map<String, dynamic> row = queryRow.data;
          result['id_value'] = row['id'] ?? json.encode(row);
        }
        return result;
      }).get();
      List<Map<String, String>> result = await Future.wait(resultFuture);
      if (result.isNotEmpty) {
        throw ForeignKeyException(result);
      }
      _syncStore.setIsOk(true);
    } catch (e) {
      // check all mandatory data if they exist
      bool allMandatoryDataExist =
          await _checkAllMandatoryDataIfExist(agencyId);
      // if not => clear database and retry if retry < 3
      // else => stop sync and logout
      if (!allMandatoryDataExist) {
        if (retry < 3) {
          await _clearDatabase();
          // sync recursively
          await _startSyncAndRetry(rep, agencyId, retry: retry + 1);
          return;
        } else {
          // stop sync
          _stopAllSync();
          // clear database
          await _clearDatabase();
          _authStore.logout();
          _rootNavigator.key.currentState?.pushNamedAndRemoveUntil(
            _rootNavigator.loginRoute,
            (route) => false,
          );
          Fluttertoast.showToast(
            msg: 'auth.errors.mandatory_data_missing'.tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: CupertinoColors.destructiveRed,
            textColor: CupertinoColors.white,
            fontSize: 16.0,
          );
          return;
        }
      }
      var isOnlyFileDataError = true;
      if (e is ForeignKeyException) {
        for (Map<String, String> error in e.errors) {
          if (error['table'] != 'orders') {
            isOnlyFileDataError = false;
            break;
          }
          if (error['column'] != 'terms_document_file_data_id' &&
              error['column'] != 'vat_certificate_file_data_id') {
            isOnlyFileDataError = false;
            break;
          }
        }

        // If errors concern only file data, we can fix them manually but run the integrity job anyway
        if (isOnlyFileDataError) {
          for (Map<String, String> error in e.errors) {
            if (error['table'] == 'orders') {
              if (error['column'] == 'terms_document_file_data_id') {
                await customStatement(
                    "UPDATE orders SET terms_document_file_data_id = null WHERE id = '${error['id_value']}'");
              } else if (error['column'] == 'vat_certificate_file_data_id') {
                await customStatement(
                    "UPDATE orders SET vat_certificate_file_data_id = null WHERE id = '${error['id_value']}'");
              }
            }
          }
        }
      } else {
        isOnlyFileDataError = false;
      }

      // trigger integrity job check
      IntegrityJobFirestoreDao integrityJobFirestoreDao =
          getIt<IntegrityJobFirestoreDao>();
      List<Map<String, String>> causes = [];
      if (e is ForeignKeyException) {
        causes = e.errors;
      }
      final integrityJob = await integrityJobFirestoreDao.triggerIntegrityJob(
        agencyId,
        causes,
      );
      // If errors concern only file data, do not block the user
      if (!isOnlyFileDataError) {
        _syncStore.setIsOk(false, integrityJobModel: integrityJob);
        _rootNavigator.key.currentState?.popUntil((route) => route.isFirst);
      }
      _authStore.setIsLoading(false);
      if (kDebugMode) {
        print('error : $e');
      }
      await FirebaseCrashlytics.instance.recordError(
        e,
        StackTrace.current,
        information: [
          e.toString(),
          rep.id,
          e is ForeignKeyException ? e.errorsString : ''
        ],
      );
      return;
    }
  }

  Future<bool> _checkAllMandatoryDataIfExist(String agencyId) async {
    // check agency
    Agency? agency = await _agencyService.getById(agencyId);
    // check service families
    List<ServiceFamily> serviceFamilies = await _serviceFamilyService.getAll();
    // check service sub families
    List<ServiceSubFamily> serviceSubFamilies =
        await _serviceSubFamilyService.getAll();
    // check services
    List<Service> services =
        await _serviceService.getAllByAgencyIdOrNullAgencyId(agencyId);
    // check price lists
    List<PriceList> priceLists =
        await _priceListService.getAllByAgencyIdOrNullAgencyId(agencyId);
    // check price list items
    List<PriceListItem> priceListItems =
        await _priceListItemService.getAllByAgencyIdOrNullAgencyId(agencyId);
    // check service options
    List<ServiceOption> serviceOptions =
        await _serviceOptionService.getAllByAgencyIdOrNullAgencyId(agencyId);
    // check service option items
    List<ServiceOptionItem> serviceOptionItems =
        await _serviceOptionItemService.getAll();
    // check any of the data above is empty
    if (agency == null ||
        serviceFamilies.isEmpty ||
        serviceSubFamilies.isEmpty ||
        services.isEmpty ||
        priceLists.isEmpty ||
        priceListItems.isEmpty ||
        serviceOptions.isEmpty ||
        serviceOptionItems.isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> _startAllSync(String agencyId) async {
    // Run all synchronizers
    await Future.wait([
      _agencyService.startSyncByAgencyId(agencyId: agencyId),
      _representativeService.startSyncByAgencyId(
          agencyId: agencyId, batchSize: 50),
      _customerService.startSyncByAgencyId(agencyId: agencyId, batchSize: 500),
      _contactService.startSyncByAgencyId(agencyId: agencyId, batchSize: 500),
      _emailTemplateService.startSyncAll(),
      _fairService.startSyncByAgencyId(agencyId: agencyId, batchSize: 50),
      _fileDataFamilyService.startSyncAll(),
      _fileDataService.startSyncByAgencyIdOrByNullAgencyId(agencyId: agencyId),
      _serviceFamilyService.startSyncAll(),
      _serviceSubFamilyService.startSyncAll(),
      _serviceService.startSyncByAgencyIdOrByNullAgencyId(agencyId: agencyId),
      _discountCodesService.startSyncByAgencyIdOrByNullAgencyId(
          agencyId: agencyId),
      _noteService.startSyncByAgencyId(agencyId: agencyId),
      _orderService.startSyncByAgencyId(agencyId: agencyId, batchSize: 500),
      _orderRowService.startSyncByAgencyId(agencyId: agencyId, batchSize: 500),
      _priceListService.startSyncByAgencyIdOrByNullAgencyId(agencyId: agencyId),
      _priceListItemService.startSyncByAgencyIdOrByNullAgencyId(
          agencyId: agencyId),
      _serviceOptionService.startSyncByAgencyIdOrByNullAgencyId(
          agencyId: agencyId),
      _serviceOptionItemService.startSyncAll(),
      _supplierService.startSyncByAgencyId(agencyId: agencyId),
      _userSettingService.startSyncByCurrentUser(),
    ]);
  }

  void _stopAllSync() {
    _agencyService.stopSync();
    _contactService.stopSync();
    _customerService.stopSync();
    _discountCodesService.stopSync();
    _emailTemplateService.stopSync();
    _fairService.stopSync();
    _fileDataService.stopSync();
    _fileDataFamilyService.stopSync();
    _noteService.stopSync();
    _orderService.stopSync();
    _orderRowService.stopSync();
    _priceListService.stopSync();
    _priceListItemService.stopSync();
    _representativeService.stopSync();
    _serviceService.stopSync();
    _serviceFamilyService.stopSync();
    _serviceOptionService.stopSync();
    _serviceOptionItemService.stopSync();
    _serviceSubFamilyService.stopSync();
    _supplierService.stopSync();
    _userSettingService.stopSync();
  }

  Future<void> _clearDatabase() async {
    await _disableForeignKeys();

    await Future.wait([
      _orderContactDao.daoDeleteAll(),
      _agencyService.deleteAll(applyToFirestore: false),
      _contactService.deleteAll(applyToFirestore: false),
      _customerService.deleteAll(applyToFirestore: false),
      _discountCodeServiceDao.daoDeleteAll(),
      _discountCodeServiceFamilyDao.daoDeleteAll(),
      _discountCodeServiceSubFamilyDao.daoDeleteAll(),
      _discountCodesService.deleteAll(applyToFirestore: false),
      _emailTemplateService.deleteAll(applyToFirestore: false),
      _fairService.deleteAll(applyToFirestore: false),
      _fileDataService.deleteAll(applyToFirestore: false),
      _fileDataFamilyService.deleteAll(applyToFirestore: false),
      _noteService.deleteAll(applyToFirestore: false),
      _orderService.deleteAll(applyToFirestore: false),
      _orderRowService.deleteAll(applyToFirestore: false),
      _priceListService.deleteAll(applyToFirestore: false),
      _priceListItemService.deleteAll(applyToFirestore: false),
      _representativeService.deleteAll(applyToFirestore: false),
      _serviceService.deleteAll(applyToFirestore: false),
      _serviceFamilyService.deleteAll(applyToFirestore: false),
      _serviceOptionService.deleteAll(applyToFirestore: false),
      _serviceOptionItemService.deleteAll(applyToFirestore: false),
      _serviceSubFamilyService.deleteAll(applyToFirestore: false),
      _supplierService.deleteAll(applyToFirestore: false),
      _userSettingService.deleteAll(applyToFirestore: false),
    ]);
    await _enableForeignKeys();
  }

  Future<void> _disableForeignKeys() {
    return customStatement('PRAGMA foreign_keys = OFF');
  }

  Future<void> _enableForeignKeys() {
    return customStatement('PRAGMA foreign_keys = ON');
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await PrivateDirectoryMixin.getPrivateDirectory();
    final file = File(p.join(dbFolder.path, agencyDatabasePath));
    return NativeDatabase.createInBackground(
      file,
    );
  });
}
