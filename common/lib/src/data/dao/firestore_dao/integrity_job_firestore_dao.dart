import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:maple_common/maple_common.dart';

class IntegrityJobFirestoreDao extends AbstractFirestoreDao<IntegrityJobModel> {
  @override
  String collectionName = 'integrityJobs';

  @override
  CollectionReference<IntegrityJobModel> get collection =>
      db.collection(collectionName).withConverter<IntegrityJobModel>(
            fromFirestore: IntegrityJobModel.fromFirestore,
            toFirestore: (IntegrityJobModel job, options) => job.toFirestore(),
          );

  Future<IntegrityJobModel?> getRunningByAgencyId(String agencyId) async {
    return await collection
        .where('agencyId', isEqualTo: agencyId)
        .where('isRunning', isEqualTo: true)
        .limit(1)
        .get()
        .then((QuerySnapshot<IntegrityJobModel> snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs[0].data();
      }
      return null;
    });
  }

  Future<IntegrityJobModel> triggerIntegrityJob(
    String agencyId,
    List<Map<String, String>> causes,
  ) async {
    IntegrityJobModel? integrityJobModel = await getRunningByAgencyId(agencyId);
    if (integrityJobModel == null) {
      if (kDebugMode) {
        print('Running integrity job');
      }
      UuidUtilsInterface uuidUtils = getIt<UuidUtilsInterface>();
      IntegrityJobModel integrityJobModel = IntegrityJobModel(
        id: uuidUtils.generate(),
        agencyId: agencyId,
        causes: causes,
        isRunning: false,
        duration: 0,
        syncedAt: DateTime.now(),
      );
      await create(integrityJobModel);
      return integrityJobModel;
    } else {
      if (kDebugMode) {
        print('Integrity job already running');
      }

      return integrityJobModel;
    }
  }
}
