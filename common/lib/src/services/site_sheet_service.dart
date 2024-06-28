import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

// Interface:-------------------------------------------------------------------
abstract class SiteSheetServiceInterface {
  Future<SiteSheet> getOrCreateByOrderId(String orderId);
  Future<void> update(SiteSheet siteSheet);
  Future<int> getNextVersion(SiteSheet siteSheet);
  Stream<DocumentSnapshot<SiteSheet>> getSnapshots(SiteSheet siteSheet);
}

// Implementation:--------------------------------------------------------------
class SiteSheetService implements SiteSheetServiceInterface {
  // Dependencies:--------------------------------------------------------------
  late final SiteSheetFirestoreDao _siteSheetFirestoreDao =
      getIt<SiteSheetFirestoreDao>();

  // Methods:-------------------------------------------------------------------
  @override
  Future<SiteSheet> getOrCreateByOrderId(String orderId) async {
    return _siteSheetFirestoreDao.getOrCreateByOrderId(orderId);
  }

  @override
  Future<void> update(SiteSheet siteSheet) async {
    await _siteSheetFirestoreDao.update(siteSheet);
  }

  @override
  Future<int> getNextVersion(SiteSheet siteSheet) async {
    return _siteSheetFirestoreDao.getNextVersion(siteSheet);
  }

  @override
  Stream<DocumentSnapshot<SiteSheet>> getSnapshots(SiteSheet siteSheet) {
    return _siteSheetFirestoreDao.getSnapshots(siteSheet);
  }
}
