import 'package:i_charm/models/models.dart';
import 'package:i_charm/services/base_api.dart';

class UserAPI extends BaseAPI {
  static const collectionName = "users";
  static UserAPI? _cache;

  factory UserAPI() {
    _cache ??= UserAPI._();
    return _cache!;
  }

  UserAPI._() : super(collectionName: collectionName);

  Future<void> add(User user) async {
    return collection
        .doc(user.id)
        .set(user.toJsonWithoutID())
        .catchError((error) => throw ('Fail to add a user: $error'));
  }

  Future<User?> getUserProfile(String id) async {
    var snapshot = await collection.doc(id).get();
    return (!snapshot.exists) ? null : User.fromJson(snapshot.data());
  }
}
