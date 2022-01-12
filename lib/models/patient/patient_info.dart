import '../models.dart';

class PatientInfo extends BasedObject {
  User? userInfo;
  AlignerInfo? alignerInfo;
  Aligner? aligner;
  String? caseId;

  PatientInfo({
    String? id,
    this.userInfo,
    this.alignerInfo,
    this.caseId,
    required Log log,
  }) : super(id: id = '', log: log);

  PatientInfo.fromJson(Map<String, dynamic> json)
      : super(id: json['id'] ?? '', log: Log.fromJson(json['log'])) {
    if (json['user_info'] != null) {
      userInfo = User.fromJson(json['user_info']);
    }
    if (json['aligner_info'] != null) {
      alignerInfo = AlignerInfo.fromJson(json['aligner_info']);
    }
    if (json['aligner'] != null) {
      aligner = Aligner.fromJson(json['aligner']);
    }
    if (json['case_id'] != null) {
      caseId = json['case_id'];
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['user_info'] = userInfo != null ? userInfo!.toJson() : null;
    map['aligner'] = aligner != null ? aligner!.toJson() : null;
    map['aligner_info'] = alignerInfo?.toJson();
    map['case_id'] = caseId;
    return map;
  }
}
