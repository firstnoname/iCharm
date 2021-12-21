import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/models.dart';

class Log {
  final Timestamp? createDate;
  final User? createBy;

  Log({
    this.createDate,
    this.createBy,
  });

  Log.fromJson(dynamic json)
      : createDate = json['create_date'],
        createBy = User.fromJson(json['create_by']);

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (createDate != null) map['create_date'] = createDate;
    if (createBy != null) map['create_by'] = createBy!.toJson();
    return map;
  }
}
