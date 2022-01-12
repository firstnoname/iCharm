import 'package:cloud_firestore/cloud_firestore.dart';

class AlignerHistory {
  String? id;
  Timestamp? createDate;
  int? alignerNumber;
  String? start;
  String? end;
  String? total;

  AlignerHistory({
    this.createDate,
    this.start,
    this.end,
    this.total,
  });

  AlignerHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createDate = json['create_date'];
    alignerNumber = json['aligner_number'];
    start = json['start'];
    end = json['end'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['create_date'] = createDate;
    data['aligner_number'] = alignerNumber;
    data['start'] = start;
    data['end'] = end;
    data['total'] = total;
    return data;
  }
}
