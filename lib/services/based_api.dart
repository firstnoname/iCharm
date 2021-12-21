import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class BasedAPI {
  final CollectionReference<Map<String, dynamic>> collection;

  BasedAPI({required String collectionName})
      : collection = FirebaseFirestore.instance.collection(collectionName);

  Future<String> uploadImages(
    String firebaseStoragePath,
    String fileName,
    String localImagePath,
  ) async {
    Uint8List imageBytes = File(localImagePath).readAsBytesSync();
    var ref = FirebaseStorage.instance.ref(firebaseStoragePath);
    var uploadTask = ref.child(fileName).putData(imageBytes);

    return await (await uploadTask).ref.getDownloadURL();
  }
}
