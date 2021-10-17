/// country : "string"
/// subArea : [{"description":"province","value":"string"}]
/// streetName : "string"
/// buildingName : "string"
/// floor : 1
/// houseNumber : "string"
/// postalCode : "string"

class Address {
  String? streetName;
  String? buildingName;
  String? floor;
  String? houseNumber;
  String? postalCode;
  Geolocation? geolocation;
  List<Area?>? subArea;

  //GeoFirePoint? geolocation;

  Address({
    this.streetName,
    this.buildingName,
    this.floor,
    this.houseNumber,
    this.postalCode,
    this.geolocation,
    this.subArea,
  });

  Address.empty() : this.fromJson({});

  Address.fromJson(dynamic json)
      : streetName = json["streetName"],
        buildingName = json["buildingName"],
        floor = json["floor"],
        houseNumber = json["houseNumber"],
        postalCode = json["postalCode"],
        geolocation = json["geoLocation"] != null
            ? Geolocation.fromJson(json["geoLocation"])
            : Geolocation.empty(),
        subArea = <Area>[] {
    if (json["subArea"] != null) {
      json["subArea"].forEach((v) {
        subArea!.add(Area.fromJson(v));
      });
    }
  }

  get isNotEmpty => !isEmpty;

  get isEmpty =>
      streetName == null &&
      buildingName == null &&
      floor == null &&
      houseNumber == null &&
      postalCode == null &&
      geolocation == null &&
      (subArea?.isEmpty ?? true);

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (streetName?.isNotEmpty ?? false) {
      map["streetName"] = streetName;
    }
    if (buildingName?.isNotEmpty ?? false) {
      map["buildingName"] = buildingName;
    }
    if (floor?.isNotEmpty ?? false) {
      map["floor"] = floor;
    }
    if (houseNumber?.isNotEmpty ?? false) {
      map["houseNumber"] = houseNumber;
    }
    if (postalCode?.isNotEmpty ?? false) {
      map["postalCode"] = postalCode;
    }
    if (geolocation?.isNotEmpty ?? false) {
      map["geoLocation"] = geolocation!.toJson();
    }
    if (subArea?.isNotEmpty ?? false || subArea?[0] != null) {
      print('object');
      map["subArea"] = subArea!.map((v) => v!.toJson()).toList();
    }
    return map;
  }
}
