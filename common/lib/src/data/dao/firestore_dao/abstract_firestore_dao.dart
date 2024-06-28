import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

abstract class AbstractFirestoreDao<T extends AbstractBaseModel>
    implements FirestoreDaoInterface<T> {
  @override
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<List<T>> getAll() async {
    return (await collection.get().then((QuerySnapshot<T> result) {
      return result.docs.map((e) {
        return e.data();
      });
    }))
        .toList();
  }

  Stream<DocumentSnapshot<T>> getSnapshots(T item) {
    return collection.doc(item.id).snapshots();
  }

  Future<List<T>> getAllByAgencyId(String agencyId) async {
    return await collection
        .where('agencyId', isEqualTo: agencyId)
        .get()
        .then((QuerySnapshot<T> snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList(growable: false);
    });
  }

  Future<List<T>> getAllByNullAgencyId() async {
    return await collection
        .where('agencyId', isEqualTo: null)
        .get()
        .then((QuerySnapshot<T> snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList(growable: false);
    });
  }

  Future<List<T>> getAllByAgencyIdOrNullAgencyId(String agencyId) async {
    List<T> itemsWithAgencyId = await getAllByAgencyId(agencyId);
    List<T> itemsWithNullAgencyId = await getAllByNullAgencyId();

    return [...itemsWithAgencyId, ...itemsWithNullAgencyId];
  }

  Future<T?> getById(String id) async {
    return await collection.doc(id).get().then((DocumentSnapshot<T> snapshot) {
      return snapshot.data();
    });
  }

  Future<List<T>> getByIds(List<String> ids) async {
    return await collection
        .where(FieldPath.documentId, whereIn: ids)
        .get()
        .then((QuerySnapshot<T> snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList(growable: false);
    });
  }

  Future<T> create(T item) async {
    await collection.doc(item.id).set(item);
    return item;
  }

  Future<T> update(T item) async {
    item.updatedAt = DateTime.now();

    await collection.doc(item.id).update(item.toFirestore());

    return item;
  }

  Future<T> createOrUpdate(T item) async {
    T? existingItem = await getById(item.id);
    if (existingItem == null) {
      return await create(item);
    }
    return await update(item);
  }

  Future<void> delete(T item, {bool forceDelete = false}) async {
    if (item is AbstractIsSoftDeletable && !forceDelete) {
      item.delete();
      await collection.doc(item.id).update(item.toFirestore());
      return;
    }

    await collection.doc(item.id).delete();
  }

  Future<void> deleteAll() async {
    final elements = await getAll();

    for (var element in elements) {
      await delete(element);
    }
  }
}
