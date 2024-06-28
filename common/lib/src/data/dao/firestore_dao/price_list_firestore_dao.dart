import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

class PriceListFirestoreDao extends AbstractFirestoreDao<PriceList> {
  @override
  String collectionName = 'priceLists';

  @override
  CollectionReference<PriceList> get collection =>
      db.collection(collectionName).withConverter<PriceList>(
            fromFirestore: PriceList.fromFirestore,
            toFirestore: (PriceList p, options) => p.toFirestore(),
          );
}
