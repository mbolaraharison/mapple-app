import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

class PriceListItemFirestoreDao extends AbstractFirestoreDao<PriceListItem> {
  @override
  String collectionName = 'priceListItems';

  @override
  CollectionReference<PriceListItem> get collection =>
      db.collection(collectionName).withConverter<PriceListItem>(
            fromFirestore: PriceListItem.fromFirestore,
            toFirestore: (PriceListItem p, options) => p.toFirestore(),
          );
}
