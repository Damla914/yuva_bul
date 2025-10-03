import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollection {
  category,
  animal;

  CollectionReference get reference {
    switch (this) {
      case FirebaseCollection.category:
        return FirebaseFirestore.instance.collection('animals');
      case FirebaseCollection.animal:
        return FirebaseFirestore.instance.collection('animals');
    }
  }
}
