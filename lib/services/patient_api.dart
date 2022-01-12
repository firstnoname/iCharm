import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:i_charm/models/models.dart';
import 'package:i_charm/services/based_api.dart';

class PatientAPI extends BasedAPI {
  static const collectionName = 'patient_info';
  // static const collectionName = 'test';
  static PatientAPI? _cache;

  factory PatientAPI() {
    _cache ??= PatientAPI._();
    return _cache!;
  }

  PatientAPI._() : super(collectionName: collectionName);

  Future<String?> uploadImage({
    required String docId,
    required String fileName,
    required storagePath,
    required String imagePath,
  }) async {
    File _imageFile = File(imagePath);
    Uint8List _image = _imageFile.readAsBytesSync();
    var ref = FirebaseStorage.instance.ref(storagePath + '_' + docId);
    var uploadTask = ref.child(fileName).putData(_image);
    return await (await uploadTask).ref.getDownloadURL();
  }

  Future<PatientInfo?> addPatientUpdateImage(
      {required PatientInfo patientInfo,
      required UploadImage updateImage,
      required String docId}) async {
    // patientInfo.patientAligner![0].updateImage![0] = updateImage;
    // collection.doc(docId).update({'aligners': FieldValue.arrayUnion()});
    // collection.doc(docId).update({'aligners', FieldValue.arrayUnion(elements)});
  }

  Future<PatientInfo?> getPatientInfo({required String uid}) async {
    PatientInfo? patientInfo;

    var response =
        await collection.where('user_info.uid', isEqualTo: uid).get();

    if (response.docs.isNotEmpty) {
      return PatientInfo.fromJson(
          response.docs.first.data()..addAll({'id': response.docs.first.id}));
    } else {
      return null;
    }
  }
}
