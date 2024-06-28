import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:maple_common/maple_common.dart';
import 'package:mime/mime.dart';

class FileData extends AbstractBaseModel implements Insertable<FileData> {
  // Constructor:---------------------------------------------------------------
  FileData({
    required super.id,
    required this.uniqueName,
    required this.displayName,
    required this.agencyId,
    this.existsInStorage = false,
    this.syncStatus = SyncStatus.NOT_READY,
    this.mode = FileDataMode.remote,
    this.familyId,
    this.customerId,
    this.type = FileDataType.normal,
    this.size = 0,
    this.mimeType,
    this.downloadUrl,
    this.previewFileDataId,
    this.isPreview = false,
    this.orderId,
    super.createdAt,
    super.updatedAt,
  }) {
    searchableDisplayName = displayName.toSearchable();
  }

  // Variables:-----------------------------------------------------------------
  String uniqueName;
  String displayName;
  bool existsInStorage;
  SyncStatus syncStatus;
  FileDataMode mode;
  String? familyId;
  String? customerId;
  FileDataType type;
  double size;
  String? mimeType;
  String? downloadUrl;
  String? previewFileDataId;
  bool isPreview;
  final String? agencyId;
  final String? orderId;
  // Search fields
  late String searchableDisplayName;

  FileData? previewFileData;

  // Methods:-------------------------------------------------------------------
  @override
  Future<void> loadData(
      {bool eager = false, List<Type> flow = const []}) async {
    await loadPreviewFileData();
  }

  Future<void> loadPreviewFileData() async {
    if (previewFileDataId == null) {
      return;
    }
    previewFileData = await getIt<FileDataServiceInterface>()
        .getById(previewFileDataId!, isRemote: true);
  }

  // Getters:-------------------------------------------------------------------
  Future<File?> get file async {
    final fileDataService = getIt<FileDataServiceInterface>();
    if (mode == FileDataMode.local) {
      return fileDataService.getFileFromFileSystem(uniqueName);
    }

    // Download from storage
    await fileDataService.downloadFile(this);
    return fileDataService.getFileFromFileSystem(uniqueName);
  }

  Future<String?> get mimeTypeByUniqueName async {
    File? file = await this.file;
    if (file == null) {
      return null;
    }
    return lookupMimeType(file.path);
  }

  Future<bool?> get isImage async {
    String? mimeType = await mimeTypeByUniqueName;
    if (mimeType == null) {
      return null;
    }
    return mimeType.startsWith('image/');
  }

  Future<bool?> get isPdf async {
    String? mimeType = await mimeTypeByUniqueName;
    if (mimeType == null) {
      return null;
    }
    return mimeType.startsWith('application/pdf');
  }

  Future<bool?> get isVideo async {
    String? mimeType = await mimeTypeByUniqueName;
    if (mimeType == null) {
      return null;
    }
    return mimeType.startsWith('video/');
  }

  String get previewFileName {
    List<String> fileNameParts = uniqueName.split('.');
    String fileName = fileNameParts.first;
    String extension = fileNameParts.last;
    String previewFileName = '$fileName-display-preview.$extension';
    return previewFileName;
  }

  Future<File?> get previewFile async {
    return await getIt<FileDataServiceInterface>()
        .getFileFromFileSystem(previewFileName);
  }

  String get extension {
    return uniqueName.toLowerCase().split('.').last;
  }

  bool get isRemote {
    return mode == FileDataMode.remote;
  }

  // Methods:-------------------------------------------------------------------
  Future<void> removeFromFileSystem() async {
    if (mode == FileDataMode.local) {
      throw Exception('Cannot remove local file');
    }
    return getIt<FileDataServiceInterface>().removeFromFileSystem(uniqueName);
  }

  // Base methods:--------------------------------------------------------------
  factory FileData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return FileData(
      id: snapshot.id,
      uniqueName: data?['uniqueName'] as String,
      displayName: data?['displayName'] as String,
      existsInStorage: data?['existsInStorage'] as bool,
      syncStatus: SyncStatus.values.firstWhere(
        (e) => e.name == data?['syncStatus'],
      ),
      mode: data?['mode'] != null
          ? FileDataMode.values.firstWhere(
              (e) => e.name == data?['mode'],
            )
          : FileDataMode.local,
      familyId: data?['familyId'] as String?,
      customerId: data?['customerId'] as String?,
      type: data?['type'] != null
          ? FileDataType.values.firstWhere(
              (e) => e.name == data?['type'],
            )
          : FileDataType.normal,
      size: data?['size']?.toDouble() ?? 0,
      mimeType: data?['mimeType'] as String?,
      downloadUrl: data?['downloadUrl'] as String?,
      previewFileDataId: data?['previewFileDataId'] as String?,
      isPreview: data?['isPreview'] as bool? ?? false,
      agencyId: data?['agencyId'],
      orderId: data?['orderId'] as String?,
      createdAt: data?['createdAt']?.toDate() as DateTime?,
      updatedAt: data?['updatedAt']?.toDate() as DateTime?,
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'uniqueName': uniqueName,
      'displayName': displayName,
      'existsInStorage': existsInStorage,
      'syncStatus': syncStatus.name,
      'mode': mode.name,
      'familyId': familyId,
      'customerId': customerId,
      'type': type.name,
      'size': size,
      'mimeType': mimeType,
      'downloadUrl': downloadUrl,
      'previewFileDataId': previewFileDataId,
      'isPreview': isPreview,
      'agencyId': agencyId,
      'orderId': orderId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  FileData copyWith({
    String? id,
    String? uniqueName,
    String? displayName,
    bool? existsInStorage,
    SyncStatus? syncStatus,
    FileDataMode? mode,
    String? familyId,
    String? customerId,
    FileDataType? type,
    double? size,
    String? mimeType,
    String? downloadUrl,
    String? previewFileDataId,
    bool? isPreview,
    String? agencyId,
    String? orderId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FileData(
      id: id ?? this.id,
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
      agencyId: agencyId ?? this.agencyId,
      orderId: orderId ?? this.orderId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    StringUtilsInterface stringUtils = getIt<StringUtilsInterface>();
    return {
      'id': Variable<String>(id),
      'unique_name': Variable<String>(uniqueName),
      'display_name': Variable<String>(displayName),
      'exists_in_storage': Variable<bool>(existsInStorage),
      'sync_status': Variable<String>(syncStatus.name),
      'mode': Variable<String>(mode.name),
      'family_id': Variable<String>(stringUtils.valueIfNotEmpty(familyId)),
      'customer_id': Variable<String>(stringUtils.valueIfNotEmpty(customerId)),
      'type': Variable<String>(type.name),
      'size': Variable<double>(size),
      'mime_type': Variable<String>(stringUtils.valueIfNotEmpty(mimeType)),
      'download_url':
          Variable<String>(stringUtils.valueIfNotEmpty(downloadUrl)),
      'preview_file_data_id':
          Variable<String>(stringUtils.valueIfNotEmpty(previewFileDataId)),
      'is_preview': Variable<bool>(isPreview),
      'agency_id': Variable<String>(stringUtils.valueIfNotEmpty(agencyId)),
      'order_id': Variable<String>(stringUtils.valueIfNotEmpty(orderId)),
      'searchable_display_name': Variable<String>(searchableDisplayName),
      'created_at': Variable<DateTime>(createdAt),
      'updated_at': Variable<DateTime>(updatedAt),
    };
  }

  @override
  bool identicalTo(AbstractBaseModel other) {
    if (identical(this, other)) return true;

    return other is FileData &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.uniqueName == uniqueName &&
        other.displayName == displayName &&
        other.existsInStorage == existsInStorage &&
        other.syncStatus == syncStatus &&
        other.mode == mode &&
        other.familyId == familyId &&
        other.customerId == customerId &&
        other.type == type &&
        other.size == size &&
        other.mimeType == mimeType &&
        other.downloadUrl == downloadUrl &&
        other.previewFileDataId == previewFileDataId &&
        other.isPreview == isPreview &&
        other.agencyId == agencyId &&
        other.orderId == orderId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }
}
