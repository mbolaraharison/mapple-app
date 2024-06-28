import 'package:maple_common/maple_common.dart';
import 'dart:async';

// Interface:-------------------------------------------------------------------
abstract class RepresentativeAppraisalServiceInterface {
  Future<RepresentativeAppraisal> create(RepresentativeAppraisal appraisal);
  Future<RepresentativeAppraisal> update(RepresentativeAppraisal appraisal);
  Stream<RepresentativeAppraisal?> getByIdAsStream(String id,
      {bool eager = false});
  Future<List<RepresentativeAppraisal>>
      getNotCompletedByRepresentativeByRepresentativeId(
          String representativeId);
  Stream<List<RepresentativeAppraisal>> getByAgencyIdAsStream(String agencyId,
      {bool eager = false});
  Stream<List<RepresentativeAppraisal>> getByRepresentativeIdAsStream(
      String representativeId,
      {bool eager = false});
  Stream<List<RepresentativeAppraisal>> getAllFullyCompletedAsStream(
      String representativeId);
}

// Implementation:--------------------------------------------------------------
class RepresentativeAppraisalService
    implements RepresentativeAppraisalServiceInterface {
  // DAO:-----------------------------------------------------------------------
  final RepresentativeAppraisalFirestoreDao _remoteDao =
      getIt<RepresentativeAppraisalFirestoreDao>();

  @override
  Future<RepresentativeAppraisal> create(RepresentativeAppraisal appraisal) {
    return _remoteDao.create(appraisal);
  }

  @override
  Future<RepresentativeAppraisal> update(RepresentativeAppraisal appraisal) {
    return _remoteDao.update(appraisal);
  }

  @override
  Stream<RepresentativeAppraisal?> getByIdAsStream(String id,
      {bool eager = false}) {
    Stream<RepresentativeAppraisal?> representativeAppraisalStream =
        _remoteDao.getByIdAsStream(id);
    if (eager) {
      representativeAppraisalStream = representativeAppraisalStream
          .asyncMap((RepresentativeAppraisal? representativeAppraisal) async {
        if (representativeAppraisal != null) {
          await representativeAppraisal.loadData();
        }
        return representativeAppraisal;
      });
    }
    return representativeAppraisalStream;
  }

  @override
  Future<List<RepresentativeAppraisal>>
      getNotCompletedByRepresentativeByRepresentativeId(
          String representativeId) {
    return _remoteDao
        .getNotCompletedByRepresentativeByRepresentativeId(representativeId);
  }

  @override
  Stream<List<RepresentativeAppraisal>> getByAgencyIdAsStream(String agencyId,
      {bool eager = false}) {
    Stream<List<RepresentativeAppraisal>> appraisalsStream =
        _remoteDao.getByAgencyIdAsStream(agencyId);

    if (eager) {
      appraisalsStream = appraisalsStream.asyncMap(
          (List<RepresentativeAppraisal> representativeAppraisals) async {
        for (var representativeAppraisal in representativeAppraisals) {
          await representativeAppraisal.loadData();
        }
        return representativeAppraisals;
      });
    }

    return appraisalsStream;
  }

  @override
  Stream<List<RepresentativeAppraisal>> getByRepresentativeIdAsStream(
      String representativeId,
      {bool eager = false}) {
    Stream<List<RepresentativeAppraisal>> appraisalsStream =
        _remoteDao.getByRepresentativeIdAsStream(representativeId);
    if (eager) {
      appraisalsStream = appraisalsStream.asyncMap(
          (List<RepresentativeAppraisal> representativeAppraisals) async {
        final futures = <Future<void>>[];
        for (int i = 0; i < representativeAppraisals.length; i += 10) {
          List<RepresentativeAppraisal> representativeAppraisalsChunk =
              representativeAppraisals.sublist(
                  i,
                  i + 10 > representativeAppraisals.length
                      ? representativeAppraisals.length
                      : i + 10);
          futures.addAll(representativeAppraisalsChunk
              .map((e) => e.loadData())
              .toList(growable: false));
        }
        await Future.wait(futures);
        return representativeAppraisals;
      });
    }

    return appraisalsStream;
  }

  @override
  Stream<List<RepresentativeAppraisal>> getAllFullyCompletedAsStream(
      String representativeId) {
    return _remoteDao.getAllFullyCompletedAsStream(representativeId);
  }
}
