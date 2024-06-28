import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:maple_common/maple_common.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

// Interface:-------------------------------------------------------------------
abstract class FileDataServiceInterface {
  // Getters:-------------------------------------------------------------------
  Future<Directory> get privateDirectory;
  // Methods:-------------------------------------------------------------------
  Future<void> create(FileData item,
      {bool applyToFirestore = true, bool onlyToFirestore = false});
  Future<void> createAndUpload(FileData item, File file,
      {bool applyToFirestore = true});
  Future<List<FileData>> getByCustomerId(String customerId);
  Stream<List<FileData>> getByCustomerIdAsStream(String customerId);
  Future<FileData?> getById(String id, {bool isRemote = false});
  Future<FileData?> getByUniqueName(String uniqueName, {bool isRemote = false});
  Future<File?> getFileFromFileSystem(String uniqueName,
      {bool withDownload = false});
  Stream<List<FileData>> searchByCustomerIdByTypeAsStream(
      String query, String customerId, FileDataType type,
      {bool eager = false});
  Future<void> downloadFile(FileData fileData);
  Future<void> removeFromFileSystem(String uniqueName);
  Future<void> removeRemoteFilesFromFileSystem();
  Future<void> deleteById(String id);
  Future<void> openFromFileSystemByUniqueName(String uniqueName,
      {File? file, bool download = true, bool withRemove = false});
  Stream<List<FileData>> getByFamilyIdAsStream(String familyId,
      {bool eager = false});
  Future<void> startSyncByAgencyIdOrByNullAgencyId(
      {String? agencyId, int batchSize = 100});
  Future<void> stopSync();
  Future<void> deleteAll({bool applyToFirestore = true});
  Future<void> tryUpload(File file, {int trial = 1});
  Future<void> update(FileData item, {bool applyToFirestore = true});
}

// Implementation:--------------------------------------------------------------
class FileDataService
    extends AbstractModelService<FileData, $FileDatasTable, AgencyDatabase>
    with PrivateDirectoryMixin
    implements FileDataServiceInterface {
  // Constructor:---------------------------------------------------------------
  FileDataService()
      : super(getIt<FileDataDriftDao>(), getIt<FileDataFirestoreDao>()) {
    _uploadFiles();
  }

  // Services:------------------------------------------------------------------
  final AgencyServiceInterface _agencyService = getIt<AgencyServiceInterface>();

  // Methods:-------------------------------------------------------------------
  @override
  Stream<List<FileData>> searchByCustomerIdByTypeAsStream(
      String query, String customerId, FileDataType type,
      {bool eager = false}) {
    Stream<List<FileData>> fileDataStream = (localDao as FileDataDriftDao)
        .searchByCustomerIdByTypeAsStream(query, customerId, type);
    if (eager) {
      fileDataStream = fileDataStream.asyncMap((fileDatas) async {
        for (FileData fileData in fileDatas) {
          await fileData.loadData(eager: eager);
        }
        return fileDatas;
      });
    }
    return fileDataStream;
  }

  @override
  Future<List<FileData>> getByCustomerId(String customerId) {
    return (localDao as FileDataDriftDao).findByCustomerId(customerId);
  }

  @override
  Stream<List<FileData>> getByCustomerIdAsStream(String customerId) {
    return (localDao as FileDataDriftDao).findByCustomerIdAsStream(customerId);
  }

  @override
  Future<FileData?> getById(String id, {bool isRemote = false}) async {
    if (isRemote == false) {
      return (localDao as FileDataDriftDao).findById(id);
    }

    return remoteDao.getById(id);
  }

  @override
  Future<FileData?> getByUniqueName(String uniqueName,
      {bool isRemote = false}) {
    if (isRemote == false) {
      return (localDao as FileDataDriftDao).findByUniqueName(uniqueName);
    }
    return (remoteDao as FileDataFirestoreDao).findByUniqueName(uniqueName);
  }

  @override
  Stream<List<FileData>> getByFamilyIdAsStream(String familyId,
      {bool eager = false}) {
    Stream<List<FileData>> fileDataStream =
        (localDao as FileDataDriftDao).findByFamilyIdAsStream(familyId);
    if (eager) {
      fileDataStream = fileDataStream.asyncMap((fileDatas) async {
        for (FileData fileData in fileDatas) {
          await fileData.loadData(eager: eager);
        }
        return fileDatas;
      });
    }
    return fileDataStream;
  }

  @override
  Future<void> downloadFile(FileData fileData) async {
    // download file
    File? file = await getFileFromFileSystem(fileData.uniqueName);
    if (file == null) {
      await (remoteDao as FileDataFirestoreDao).downloadFile(fileData);
    } else if (fileData.size != file.lengthSync()) {
      // force re-download if the file size is different
      await removeFromFileSystem(fileData.uniqueName);
      await (remoteDao as FileDataFirestoreDao).downloadFile(fileData);
    }
  }

  @override
  Future<void> createAndUpload(
    FileData item,
    File file, {
    bool applyToFirestore = true,
  }) async {
    await super.create(item, applyToFirestore: applyToFirestore);

    tryUpload(file);
  }

  @override
  Future<File?> getFileFromFileSystem(String uniqueName,
      {bool withDownload = false}) async {
    Directory directory = await privateDirectory;
    File file = File('${directory.path}/$uniqueName');
    bool existsInFileSystem = await file.exists();
    // If file is not in local, download it then get it (according to withDownload)
    if (!existsInFileSystem) {
      FileData? fileData = await getByUniqueName(uniqueName);
      if (!withDownload || fileData == null) {
        return null;
      }
      await downloadFile(fileData);
      return await getFileFromFileSystem(uniqueName);
    }
    return file;
  }

  Future<List<File>> getAllFilesFromFileSystem() async {
    Directory directory = await privateDirectory;
    List<FileSystemEntity> files = directory.listSync();
    return files.whereType<File>().toList();
  }

  @override
  Future<void> removeFromFileSystem(String uniqueName) async {
    File? file = await getFileFromFileSystem(uniqueName);
    if (file != null) {
      await tryAndRemoveFile(file);
      await removePreviewFromFileSystem(uniqueName);
    }
  }

  Future<void> tryAndRemoveFile(File file) async {
    if (await file.exists()) {
      try {
        await file.delete(recursive: true);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  Future<void> removePreviewFromFileSystem(String previewFileName) async {
    File? file = await getFileFromFileSystem(previewFileName);
    if (file != null) {
      await tryAndRemoveFile(file);
    }
  }

  @override
  Future<void> removeRemoteFilesFromFileSystem() async {
    List<File> files = await getAllFilesFromFileSystem();
    for (File file in files) {
      String uniqueName = file.path.split('/').last;
      if (uniqueName == 'local.db') {
        continue;
      }
      FileData? fileData = await getByUniqueName(uniqueName);
      if (fileData == null || fileData.mode == FileDataMode.remote) {
        await removeFromFileSystem(uniqueName);
      }
    }

    // Remove empty folders
    Directory directory = await privateDirectory;
    List<FileSystemEntity> allFiles = directory.listSync();
    for (FileSystemEntity file in allFiles) {
      if (file is Directory) {
        if (file.listSync().isEmpty) {
          await file.delete(recursive: false);
        }
      }
    }
  }

  @override
  Future<void> deleteById(String id) async {
    FileData? fileData = await getById(id);
    if (fileData != null) {
      await delete(fileData);
    }
  }

  @override
  Future<void> openFromFileSystemByUniqueName(
    String uniqueName, {
    File? file,
    bool download = true,
    bool open = false,
    bool withRemove = false,
  }) async {
    file = file ?? await getFileFromFileSystem(uniqueName);
    if (file == null && download) {
      // download file
      await (remoteDao as FileDataFirestoreDao)
          .downloadFileByUniqueName(uniqueName);
      // get file from file system
      file = await getFileFromFileSystem(uniqueName);
      if (file != null) {
        // open file
        Directory tempDir = await getTemporaryDirectory();
        File tempFile = await file.copy('${tempDir.path}/$uniqueName');
        await OpenFilex.open(tempFile.path);
        await tempFile.delete();

        // remove file from file system
        if (withRemove) {
          await removeFromFileSystem(uniqueName);
        }
      }
      return;
    }
    if (file != null) {
      // open file
      Directory tempDir = await getTemporaryDirectory();
      File tempFile = await file.copy('${tempDir.path}/$uniqueName');
      await OpenFilex.open(tempFile.path);
      await tempFile.delete();

      // remove file from file system
      if (withRemove) {
        await removeFromFileSystem(uniqueName);
      }
    }
  }

  Future<void> _uploadFiles() async {
    // Top level directories are agencies
    final applicationDirectory = await getApplicationDocumentsDirectory();
    final firstLevelFiles = applicationDirectory.listSync();
    for (final firstLevelFile in firstLevelFiles) {
      // If not a directory -> delete it
      if (firstLevelFile is! Directory) {
        firstLevelFile.deleteSync();
        continue;
      }

      // If directory name is 'database' -> delete it (old way of storing files)
      final dirName = firstLevelFile.path.split('/').last;
      if (dirName == 'database') {
        firstLevelFile.deleteSync(recursive: true);
        continue;
      }

      // Second level directories are customers
      final customerDirectories =
          firstLevelFile.listSync().whereType<Directory>().toList();
      for (final customerDirectory in customerDirectories) {
        final files = customerDirectory.listSync().whereType<File>().toList();
        for (var file in files) {
          tryUpload(file);
        }
      }
    }
  }

  @override
  Future<void> tryUpload(File file, {int trial = 1}) async {
    final uniqueName = file.path.split('/').last;
    try {
      await _ensureFileDataExistsInStorageWithCurrentAgency(uniqueName);

      await (remoteDao as FileDataFirestoreDao).uploadFile(uniqueName, file);
      // Remove file from file system
      await file.delete();
      // Remove customer directory if empty
      final customerDirectory = file.parent;
      if (customerDirectory.listSync().isEmpty) {
        await customerDirectory.delete();
      }

      // Remove agency directory if empty
      final agencyDirectory = customerDirectory.parent;
      if (agencyDirectory.listSync().isEmpty) {
        await agencyDirectory.delete();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Upload failed: $uniqueName, trial: $trial');
      }
      if (trial < 3) {
        // Wait 5 minutes before retrying
        Timer(const Duration(minutes: 5), () async {
          await tryUpload(file, trial: trial + 1);
        });
      } else {
        await FirebaseCrashlytics.instance.recordError(
          e,
          StackTrace.current,
          reason: 'File upload failed',
          information: ['filename: $uniqueName'],
        );
      }
    }
  }

  Future<void> _ensureFileDataExistsInStorageWithCurrentAgency(
      String uniqueName) async {
    FileData? fileData = await getByUniqueName(uniqueName, isRemote: true);
    int trial = 1;
    while (fileData == null && trial < 3) {
      trial++;
      if (trial > 3) {
        throw Exception('File not found');
      }
      await Future.delayed(const Duration(seconds: 5));
      fileData = await getByUniqueName(uniqueName, isRemote: true);
    }
    Agency? agency = await _agencyService.getCurrent();
    if (agency == null) {
      throw Exception('Agency not found');
    }
    if (fileData!.existsInStorage == true) {
      throw Exception('File already exists in storage');
    }
    if (fileData.agencyId != agency.id) {
      throw Exception('File not found in current agency');
    }
  }

  // General methods:-----------------------------------------------------------
  @override
  Future<void> startSyncByAgencyIdOrByNullAgencyId(
      {String? agencyId, int batchSize = 100}) async {
    globalSubscription?.cancel();
    agencySubscription?.cancel();
    final globalCompleter = Completer<void>();
    final agencyCompleter = Completer<void>();
    bool isGlobalFutureResolved = false;
    bool isAgencyFutureResolved = false;

    globalSubscription = remoteDao.collection
        .where('agencyId', isNull: true)
        .where('isPreview', isEqualTo: false)
        .snapshots()
        .listen((snapshot) async {
      await onDataChange(snapshot.docChanges, batchSize: batchSize);

      if (!isGlobalFutureResolved) {
        isGlobalFutureResolved = true;
        globalCompleter.complete();
      }
    });

    agencySubscription = remoteDao.collection
        .where('agencyId', isEqualTo: agencyId)
        .where('isPreview', isEqualTo: false)
        .snapshots()
        .listen((snapshot) async {
      await onDataChange(snapshot.docChanges, batchSize: batchSize);

      if (!isAgencyFutureResolved) {
        isAgencyFutureResolved = true;
        agencyCompleter.complete();
      }
    });

    await Future.wait([globalCompleter.future, agencyCompleter.future]);
    removeRemoteFilesFromFileSystem();
  }

  @override
  Future<void> onDataChange(List<DocumentChange<FileData>> changes,
      {int batchSize = 100}) async {
    final futures = <Future>[];
    for (int i = 0; i < changes.length; i += batchSize) {
      final endIndex = min(i + batchSize, changes.length);
      final batchDocChanges = changes.sublist(i, endIndex);

      // batch firestore
      final batchFuture = localDao.batch((batch) async {
        for (var change in batchDocChanges) {
          final doc = change.doc;
          final data = doc.data() as FileData;
          switch (change.type) {
            case DocumentChangeType.added:
              batch = await _createSync(batch, data);
              break;
            case DocumentChangeType.modified:
              batch = await _updateSync(batch, data);
              break;
            case DocumentChangeType.removed:
              batch = await _deleteSync(batch, data);
              break;
          }
        }
      });

      futures.add(batchFuture);
    }

    await Future.wait(futures);
  }

  Future<Batch> _createSync(Batch batch, FileData fileData) async {
    batch = localDao.daoBatchCreateOrUpdate(batch, fileData);

    if (fileData.existsInStorage && fileData.mode == FileDataMode.local) {
      downloadFile(fileData);
    }

    return batch;
  }

  Future<Batch> _updateSync(Batch batch, FileData fileData) async {
    batch = localDao.daoBatchUpdate(batch, fileData);

    if (fileData.existsInStorage && fileData.mode == FileDataMode.local) {
      downloadFile(fileData);
    }

    return batch;
  }

  Future<Batch> _deleteSync(Batch batch, FileData fileData) async {
    batch = localDao.daoBatchDelete(batch, fileData);

    // remove file from file system
    removeFromFileSystem(fileData.uniqueName);

    return batch;
  }
}
