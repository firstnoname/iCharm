class User {
  static const String collection = 'users';

  String? id;
  String firstName;
  String lastName;
  DateTime dateOfBirth;
  String? identityCard;

  String get displayName => "$firstName $lastName";

  User(
      {String? id,
      required this.firstName,
      required this.lastName,
      required this.dateOfBirth,
      this.identityCard});
}
