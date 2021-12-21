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
  String? userName;
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

    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['date_of_birth'] = dateOfBirth?.toIso8601String();
    map['identity_card'] = identityCard;
    map['email'] = email;
    map['username'] = userName;
    map['phone_number'] = phoneNumber;

    return map;
  }

  User.fromJson(dynamic json)
      : id = json['uid'],
        firstName = json['first_name'],
        lastName = json['last_name'],
        dateOfBirth = json["date_of_birth"] != null
            ? DateTime.parse(json["date_of_birth"])
            : null,
        identityCard = json['identity_card'],
        phoneNumber = json['phone_number'],
        userName = json['username'],
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
