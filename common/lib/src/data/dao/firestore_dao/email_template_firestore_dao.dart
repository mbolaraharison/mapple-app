import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maple_common/maple_common.dart';

class EmailTemplateFirestoreDao extends AbstractFirestoreDao<EmailTemplate> {
  @override
  String collectionName = 'emailTemplates';

  @override
  CollectionReference<EmailTemplate> get collection =>
      db.collection(collectionName).withConverter<EmailTemplate>(
            fromFirestore: EmailTemplate.fromFirestore,
            toFirestore: (EmailTemplate f, options) => f.toFirestore(),
          );

  Future<EmailTemplate?> getByTemplateName(String templateName) async {
    return await collection
        .where('templateName', isEqualTo: templateName)
        .limit(1)
        .get()
        .then((QuerySnapshot<EmailTemplate> snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs[0].data();
      }
      return null;
    });
  }
}
