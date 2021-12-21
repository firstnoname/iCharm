class AlignerInfo {
  int? currentAligner;
  int? totalAligner;

  AlignerInfo({this.currentAligner, this.totalAligner});

  AlignerInfo.fromJson(dynamic json) {
    currentAligner = json['curernt_aligner'] ?? 1;
    totalAligner = json['total_aligner'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['current_aligner'] = currentAligner;
    map['total_aligner'] = totalAligner;

    return map;
  }
}
