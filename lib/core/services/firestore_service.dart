import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/core/services/database_service.dart';

class FirestoreService implements DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? docuementId,
  }) async {
    if (docuementId != null) {
      await firestore.collection(path).doc(docuementId).set(data);
    } else {
      await firestore.collection(path).add(data);
    }
  }

  @override
  Future<Map<String, dynamic>> getData({
    required String path,
    required String docuementId,
  }) async {
    var data = await firestore.collection(path).doc(docuementId).get();

    return data.data() as Map<String, dynamic>;
  }

  @override
  Future<bool> checkIfDataExists({
    required String path,
    required String docuementId,
  }) async {
    var data = await firestore.collection(path).doc(docuementId).get();
    return data.exists;
  }
}
