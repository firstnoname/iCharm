// ignore: implementation_imports
import 'package:geoflutterfire/geoflutterfire.dart';

class Geolocation extends GeoFirePoint {
  Geolocation({
    required double longitude,
    required double latitude,
  }) : super(latitude, longitude);

  factory Geolocation.empty() {
    return Geolocation.fromJson({});
  }

  factory Geolocation.fromJson(Map<String, dynamic> json) {
    return Geolocation(
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
    );
  }

  // factory Geolocation.fromDevicePosition(Position position) {
  //   return Geolocation(
  //     latitude: position.latitude,
  //     longitude: position.longitude,
  //   );
  // }

  bool get isEmpty => !isNotEmpty;

  bool get isNotEmpty => longitude != 0.0 || latitude != 0.0;

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["longitude"] = longitude;
    map["latitude"] = latitude;
    map["geohash"] = hash;

    return map;
  }
}
