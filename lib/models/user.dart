class User {
  static const String collection = 'users';

  String? id;
  String firstName;
  String lastName;
  DateTime dateOfBirth;
  String? identityCard;
  String? token;

  String get displayName => "$firstName $lastName";

  User(
      {String? id,
      required this.firstName,
      required this.lastName,
      required this.dateOfBirth,
      this.identityCard,
      this.token});

  Map<String, dynamic> toJsonWithoutID() {
    return toJson()..remove("id");
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};

    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['dateOfBirth'] = dateOfBirth.toIso8601String();
    map['identityCard'] = identityCard;

    return map;
  }

  User.fromJson(dynamic json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        dateOfBirth = DateTime.parse(json["dateOfBirth"]),
        identityCard = json['identityCard'];
}
