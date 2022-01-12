class Address {
  String? buildingName;
  String? addressNo;
  String? street;
  String? district;
  String? subDistrict;
  String? province;
  String? postcode;

  Address({
    this.buildingName,
    this.addressNo,
    this.street,
    this.district,
    this.subDistrict,
    this.province,
    this.postcode,
  });

  Address.empty() : this.fromJson({});

  Address.fromJson(dynamic json)
      : buildingName = json["building_name"],
        addressNo = json["address_no"],
        street = json["street"],
        district = json['district'],
        subDistrict = json['subdistrict'],
        province = json['province'],
        postcode = json["postcode"];

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['building_name'] = buildingName;
    map['address_no'] = addressNo;
    map['street'] = street;
    map['district'] = district;
    map['subdistrict'] = subDistrict;
    map['province'] = province;
    map['postcode'] = postcode;

    return map;
  }
}
