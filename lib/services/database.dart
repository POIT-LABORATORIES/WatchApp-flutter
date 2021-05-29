import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:watchapp/models/item.dart';

class DatabaseService {
  DatabaseService(String collectionName) {
    collection = FirebaseFirestore.instance.collection(collectionName);
  }

  CollectionReference collection;

  Future deleteDocument(String documentId) async {
    return await collection
        .doc(documentId)
        .delete()
        .catchError((error) => print("Failed to delete user: $error"));
  }

  List<Item> _itemListFromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      var data = doc.data();
      return Item(
          id: data[FirestoreWatchKey.id] ?? '',
          name: data[FirestoreWatchKey.name] ?? '',
          style: data[FirestoreWatchKey.style] ?? '',
          caseColor: data[FirestoreWatchKey.caseColor] ?? '',
          caseMaterial: data[FirestoreWatchKey.caseMaterial] ?? '',
          latitude: data[FirestoreWatchKey.latitude] ?? 0,
          longitude: data[FirestoreWatchKey.longitude] ?? 0,
          description: data[FirestoreWatchKey.description] ?? '',
          avatarUrl: data[FirestoreWatchKey.avatarUrl] ?? '');
    }).toList();
  }

  Stream<List<Item>> get items {
    return collection.snapshots().map(_itemListFromQuerySnapshot);
  }
}

class FirestoreCollectionKey {
  static const watches = "watches";
  static const users = "users";
}

class FirestoreWatchKey {
  static const id = "id";
  static const name = "name";
  static const style = "style";
  static const caseColor = "caseColor";
  static const caseMaterial = "caseMaterial";
  static const latitude = "latitude";
  static const longitude = "longitude";
  static const description = "description";
  static const avatarUrl = "avatarUrl";
}
