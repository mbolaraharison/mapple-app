import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class FileDataFamilyServiceInterface {
  Stream<List<FileDataFamily>> getAllAsStream();

  Future<void> startSyncAll({int batchSize = 100});

  Future<void> stopSync();

  Future<void> deleteAll({bool applyToFirestore = true});
}

// Implementation:--------------------------------------------------------------
class FileDataFamilyService extends AbstractModelService<
    FileDataFamily,
    $FileDataFamiliesTable,
    AgencyDatabase> implements FileDataFamilyServiceInterface {
  FileDataFamilyService()
      : super(getIt<FileDataFamilyDriftDao>(),
            getIt<FileDataFamilyFirestoreDao>());
}
