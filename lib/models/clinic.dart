import 'package:i_charm/models/location.dart';
import 'package:i_charm/models/models.dart';

class Clinic extends BasedObject {
  String? clinicName;
  String? tel;
  String? url;
  Address? address;
  Location? location;

  Clinic(
      {String? id,
      Log? log,
      this.clinicName,
      this.tel,
      this.url,
      this.address,
      this.location})
      : super(id: id, log: log);

  Clinic.fromJson(Map<String, dynamic> json)
      : clinicName = json['clinic_name'],
        tel = json['tel'],
        url = json['url'],
        address = Address.fromJson(json['address']),
        location = Location.fromJson(json['location']),
        super.fromJson(json);

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['clinic_name'] = clinicName;
    map['tel'] = tel;
    map['url'] = url;
    map['address'] = address?.toJson();
    map['location'] = location?.toJson();
    return map;
  }
}
