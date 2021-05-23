import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  DatabaseService({ this.collection });

  final CollectionReference collection;

  Stream<QuerySnapshot> get items {
    return collection.snapshots();
  }
}

class FirestoreCollectionKey {
  static const watches = "watches";
  static const users = "users";
}
