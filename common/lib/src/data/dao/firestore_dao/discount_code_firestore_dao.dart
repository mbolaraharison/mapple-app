import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

class DiscountCodeFirestoreDao extends AbstractFirestoreDao<DiscountCode> {
  @override
  String collectionName = 'discountCodes';

  @override
  CollectionReference<DiscountCode> get collection =>
      db.collection(collectionName).withConverter<DiscountCode>(
            fromFirestore: DiscountCode.fromFirestore,
            toFirestore: (DiscountCode dc, options) => dc.toFirestore(),
          );

  Future<bool> isCodeAvailable({
    required String code,
    required String agencyId,
    DiscountCode? discountCode,
  }) async {
    final query1 = await collection
        .where('code', isEqualTo: code)
        .where('agencyId', isNull: true)
        .where('deletedAt', isNull: true)
        .get();
    var query2Snapshot = collection
        .where('agencyId', isEqualTo: agencyId)
        .where('code', isEqualTo: code)
        .where('deletedAt', isNull: true);

    if (discountCode != null) {
      query2Snapshot = query2Snapshot.where(
        FieldPath.documentId,
        isNotEqualTo: discountCode.id,
      );
    }

    final query2 = await query2Snapshot.get();

    return query1.docs.isEmpty && query2.docs.isEmpty;
  }

  Future<String> generateCode(String agencyId) async {
    String code = '';
    bool isCodeAvailable = false;

    while (!isCodeAvailable) {
      code = getIt<StringUtilsInterface>()
          .generateStringWithMinAndMaxLength(4, 10)
          .toUpperCase();
      isCodeAvailable =
          await this.isCodeAvailable(code: code, agencyId: agencyId);
    }

    return code;
  }

  @override
  Future<List<DiscountCode>> getAllByAgencyIdOrNullAgencyId(
      String agencyId) async {
    List<DiscountCode> withAgencyId = await collection
        .where('agencyId', isEqualTo: agencyId)
        .get()
        .then((QuerySnapshot<DiscountCode> result) {
      return result.docs.map((e) {
        return e.data();
      }).toList();
    });
    List<DiscountCode> withoutAgencyId = await collection
        .where('agencyId', isNull: true)
        .get()
        .then((QuerySnapshot<DiscountCode> result) {
      return result.docs.map((e) {
        return e.data();
      }).toList();
    });
    return [...withAgencyId, ...withoutAgencyId];
  }
}
