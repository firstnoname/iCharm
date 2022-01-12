import 'package:cloud_firestore/cloud_firestore.dart';

class UploadImage {
  String? id;
  int? alignerNumber;
  String? image01;
  String? image02;
  String? image03;
  String? image04;
  Timestamp? uploadDate;

  UploadImage(
      {this.id,
      this.alignerNumber,
      this.image01,
      this.image02,
      this.image03,
      this.image04,
      this.uploadDate});

  UploadImage.fromJson(dynamic json) {
    id = json['id'];

    image01 = json['image_url']['image_01'];
    image02 = json['image_url']['image_02'];
    image03 = json['image_url']['image_03'];
    image04 = json['image_url']['image_04'];
    uploadDate = json['upload_date'];
    alignerNumber = json['aligner_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    final Map<String, String> imagesPath = {};
    data['upload_date'] = uploadDate;
    data['aligner_number'] = alignerNumber;
    imagesPath['image_01'] = image01!;
    imagesPath['image_02'] = image02!;
    imagesPath['image_03'] = image03!;
    imagesPath['image_04'] = image04!;
    data['image_url'] = imagesPath;

    return data;
  }
}
