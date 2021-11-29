import 'package:firebase_auth/firebase_auth.dart' as firebase;

class User {
  static const String collection = 'users';

  String? id;
  String? firstName;
  String? lastName;
  DateTime? dateOfBirth;
  String? identityCard;
  String? phoneNumber;
  String? email;
  String? token;

  String get displayName => "$firstName $lastName";

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.dateOfBirth,
      this.identityCard,
      this.phoneNumber,
      this.email,
      this.token});

  Map<String, dynamic> toJsonWithoutID() {
    return toJson()..remove("id");
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};

    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['dateOfBirth'] = dateOfBirth?.toIso8601String();
    map['identityCard'] = identityCard;
    map['email'] = email;
    map['phoneNumber'] = phoneNumber;

    return map;
  }

  User.fromJson(dynamic json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        dateOfBirth = json["dateOfBirth"] != null
            ? DateTime.parse(json["dateOfBirth"])
            : null,
        identityCard = json['identityCard'],
        phoneNumber = json['phoneNumber'],
        email = json['email'];

  factory User.fromFirebaseUser(firebase.User user) {
    return User(
      id: user.uid,
      firstName: '',
      lastName: '',
      dateOfBirth: DateTime.now(),
    );
  }
}
