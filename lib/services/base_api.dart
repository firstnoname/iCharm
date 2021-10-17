import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseAPI {
  final CollectionReference<Map<String, dynamic>> collection;

  BaseAPI({
    required String collectionName,
  }) : collection = FirebaseFirestore.instance.collection(collectionName);
}
