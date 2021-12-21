import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:i_charm/models/patient/update_image.dart';
import 'package:i_charm/services/services.dart';

class ImageAPI extends BasedAPI {
  static const collectionName = 'upload_image';
  static ImageAPI? _cache;

  factory ImageAPI() {
    _cache ??= ImageAPI._();
    return _cache!;
  }

  ImageAPI._() : super(collectionName: collectionName);

  Future<List<UploadImage>> getUploadImages(
      {required String docId, required int alignerNumber}) async {
    List<UploadImage> uploadImages = [];
    var response = await FirebaseFirestore.instance
        .collection(PatientAPI.collectionName)
        .doc(docId)
        .collection(ImageAPI.collectionName)
        .where('aligner_number', isEqualTo: alignerNumber)
        .get();

    for (var uploadImage in response.docs) {
      uploadImages.add(UploadImage.fromJson(
          uploadImage.data()..addAll({'id': uploadImage.id})));
    }

    return uploadImages;
  }

  Future<UploadImage> addImages({
    required String pateintInfoId,
    required List<String> uploadImage,
    required int alignerNumber,
  }) async {
    UploadImage updateImage = UploadImage(
      alignerNumber: alignerNumber,
      uploadDate: Timestamp.now(),
      image01: uploadImage[0],
      image02: uploadImage[1],
      image03: uploadImage[2],
      image04: uploadImage[3],
    );
    await FirebaseFirestore.instance
        .collection(PatientAPI.collectionName)
        .doc(pateintInfoId)
        .collection(ImageAPI.collectionName)
        .add(updateImage.toJson()..remove('image_url'))
        .then((value) => updateImage.id = value.id)
        .catchError((e) {
      print('upload image failure -> ${e.toString()}');
    });

    if (updateImage.id != null) {
      List<String> pathsOnFirebase = [];
      for (int i = 0; i < uploadImage.length; i++) {
        var firebaseStoragePath = "patient_aligner_images/${updateImage.id}";
        pathsOnFirebase.add(await uploadImages(
            firebaseStoragePath, i.toString(), uploadImage[i]));
      }
      updateImage.image01 = pathsOnFirebase[0];
      updateImage.image02 = pathsOnFirebase[1];
      updateImage.image03 = pathsOnFirebase[2];
      updateImage.image04 = pathsOnFirebase[3];
    }
    // update to upload_image collection.
    await FirebaseFirestore.instance
        .collection(PatientAPI.collectionName)
        .doc(pateintInfoId)
        .collection(ImageAPI.collectionName)
        .doc(updateImage.id)
        .update(updateImage.toJson());

    return updateImage;
  }
}
