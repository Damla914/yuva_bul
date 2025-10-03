import 'package:ev_bul/product/utility/base/base_firebase_model.dart';
import 'package:ev_bul/product/utility/firebase/firebase_collection.dart';

mixin FirebaseUtility {
  Future<List<T>?> fetchList<T extends IdModel, R extends BaseFirebaseModel<T>>(
    R data,
    FirebaseCollection collection,
  ) async {
    final animalsCollectionReferance = collection.reference;

    final response = await animalsCollectionReferance
        .withConverter<T>(
          fromFirestore: (snapshot, options) {
            return data.fromFirebase(snapshot);
          },
          toFirestore: (value, options) {
            return {};
          },
        )
        .get();

    if (response.docs.isNotEmpty) {
      final values = response.docs.map((e) => e.data()).toList();
      return values;
    }
    return null;
  }
}
