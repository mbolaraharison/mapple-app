import 'dart:async';
import 'package:maple_common/maple_common.dart';
import 'package:mobx/mobx.dart';

part 'customer_media_store.g.dart';

// Interface:-------------------------------------------------------------------
abstract class CustomerMediaStoreInterface {
  CustomerMediaStoreInterface._(
    this.mediaFamilies,
    this.mediaList,
  );

  // Variables
  FileDataFamily? mediaFamily;
  ObservableList<FileDataFamily> mediaFamilies;
  ObservableList<FileData> mediaList;

  // Methods
  void setMediaFamily(FileDataFamily value);
}

// Implementation:--------------------------------------------------------------
// ignore: library_private_types_in_public_api
class CustomerMediaStore = _CustomerMediaStoreBase with _$CustomerMediaStore;

abstract class _CustomerMediaStoreBase
    with Store
    implements CustomerMediaStoreInterface {
  _CustomerMediaStoreBase() {
    loadData();
  }
  // Store variables:------------------------------------------------------------
  final FileDataFamilyServiceInterface _fileDataFamilyService =
      getIt<FileDataFamilyServiceInterface>();
  final FileDataServiceInterface _fileDataService =
      getIt<FileDataServiceInterface>();

  // Subscriptions:--------------------------------------------------------------
  StreamSubscription<List<FileDataFamily>>? mediaFamiliesSubscription;
  StreamSubscription<List<FileData>>? mediaListSubscription;

  // Variables:-----------------------------------------------------------------
  @override
  @observable
  FileDataFamily? mediaFamily;

  @override
  @observable
  ObservableList<FileDataFamily> mediaFamilies =
      ObservableList<FileDataFamily>();

  @override
  @observable
  ObservableList<FileData> mediaList = ObservableList<FileData>();

  // Actions:-------------------------------------------------------------------
  @override
  @action
  void setMediaFamily(FileDataFamily value) {
    mediaFamily = value;
  }

  // Methods:-------------------------------------------------------------------
  void loadAndWatchMediaFamilies() {
    mediaFamiliesSubscription?.cancel();
    mediaFamiliesSubscription = _fileDataFamilyService.getAllAsStream().listen(
          (event) => mediaFamilies = ObservableList<FileDataFamily>.of(event),
        );
  }

  void loadAndWatchMediaList() {
    mediaListSubscription?.cancel();
    if (mediaFamily == null) {
      return;
    }
    mediaListSubscription = _fileDataService
        .getByFamilyIdAsStream(mediaFamily!.id, eager: true)
        .listen(
          (event) => mediaList = ObservableList<FileData>.of(event),
        );
  }

  void watchMediaFamily() {
    reaction((_) => mediaFamily, (_) {
      loadAndWatchMediaList();
    });
  }

  void loadData() {
    loadAndWatchMediaFamilies();
    watchMediaFamily();
  }

  void dispose() {
    mediaFamiliesSubscription?.cancel();
    mediaListSubscription?.cancel();
  }
}
