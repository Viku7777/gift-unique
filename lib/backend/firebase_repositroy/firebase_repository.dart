import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore fcloud = FirebaseFirestore.instance;

class FirebaseRepository {
  Future<void> putData(
      DocumentReference reference, Map<String, dynamic> data) async {
    try {
      return await reference.set(data);
    } on FirebaseException catch (e) {
      throw e.message!;
    }
  }

  Future<QuerySnapshot> getCollectionData(String collection) async {
    try {
      return await fcloud.collection(collection).get();
    } on FirebaseException catch (e) {
      throw e.message!;
    }
  }

  Future<DocumentSnapshot> getDocumentData(
      String collection, String document) async {
    try {
      return await fcloud.collection(collection).doc(document).get();
    } on FirebaseException catch (e) {
      throw e.message!;
    }
  }

  Future<void> updateData(
      DocumentReference reference, Map<String, dynamic> data) async {
    try {
      return await reference.update(data);
    } on FirebaseException catch (e) {
      throw e.message!;
    }
  }
}
