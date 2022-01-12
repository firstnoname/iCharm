class Location {
  String? geohash;
  double? latitude;
  double? longitude;

  Location({this.geohash, this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    geohash = json['geohash'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['geohash'] = geohash;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    return map;
  }
}
