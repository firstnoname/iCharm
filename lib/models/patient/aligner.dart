import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:i_charm/models/models.dart';

class Aligner {
  Timestamp? date;
  int? alignerNumber;
  List<AlignerHistory>? alignerHistory;
  List<UploadImage>? uploadImage;

  Aligner({
    this.alignerNumber,
    this.date,
    this.uploadImage,
    this.alignerHistory,
  });

  Aligner.fromJson(Map<String, dynamic> json) {
    alignerNumber = json['aligner_number'];
    date = json['date'];
    uploadImage = [];
    if (json['upload_image'] != null) {
      uploadImage = [];
      json['upload_image'].forEach((v) {
        uploadImage!.add(UploadImage.fromJson(v));
      });
    }
    alignerHistory = List.from(json['history']);
    if (json['history'] != null) {
      alignerHistory = [];
      json['history'].forEach((v) {
        alignerHistory!.add(AlignerHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['aligner_number'] = alignerNumber;
    map['date'] = date;
    // map['upload_image'] = uploadImage != null ? uploadImage!.toJson() : null;
    if (uploadImage != null) {
      map['upload_image'] = uploadImage!.map((v) => v.toJson()).toList();
    }
    if (alignerHistory != null) {
      map['history'] = alignerHistory!.map((v) => v.toJson()).toList();
    }

    return map;
  }
}
