import 'log.dart';

abstract class BasedObject {
  final String? id;
  final Log? log;

  BasedObject({required this.id, required this.log});

  BasedObject.fromJson(dynamic json)
      : this(id: json['id'], log: Log.fromJson(json['log']));

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['log'] = log?.toJson();
    return map;
  }
}
