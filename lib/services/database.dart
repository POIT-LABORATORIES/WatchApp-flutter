import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  DatabaseService(String collectionName) {
    collection = FirebaseFirestore.instance.collection(collectionName);
  }

  CollectionReference collection;

  Stream<QuerySnapshot> get items {
    return collection.snapshots();
  }
}

class FirestoreCollectionKey {
  static const watches = "watches";
  static const users = "users";
}
