import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:i_charm/models/models.dart';
import 'package:i_charm/services/services.dart';

class UserAPI extends BasedAPI {
  static const collectionName = "users";
  static UserAPI? _cache;

  factory UserAPI() {
    _cache ??= UserAPI._();
    return _cache!;
  }

  UserAPI._() : super(collectionName: collectionName);

  Future<bool> isUserIdExist({required String uId}) async {
    return await collection.doc(uId).get().then((value) {
      if (value.exists) {
        return true;
      } else {
        return false;
      }
    });
  }

  Future<User?> getUser(String? id) async {
    var snapshot = await collection.doc(id).get();
    return (!snapshot.exists)
        ? null
        : User.fromJson(
            snapshot.data()!..addAll({'uid': id}),
          );
  }

  Future<List<User>> getUserList(String filterByName) async {
    List<User> userList = [];

    // await FirebaseFirestore.instance
    //     .collection(collectionName)
    //     .get()
    //     .then((value) {
    //   userList = value.docs
    //       .map((user) => Member.fromJson(user.data()..addAll({'id': user.id})))
    //       .toList();
    // });

    return userList;
  }

  Future<User> addUser(User userInfo) async {
    try {
      print('user id -> ${userInfo.id}');
      await collection
          .doc(userInfo.id)
          .set(userInfo.toJson())
          .then((value) => print('Add member success.'))
          .catchError((e) => print('Add member failed -> $e'));
    } on FirebaseException catch (e) {
      print('add member failed -> ${e.message}');
    }
    return userInfo;
  }

  Future<User> updateUserInfo(User userInfo) async {
    await collection.doc(userInfo.id).update(userInfo.toJson());
    return userInfo;
  }

  Future<bool> changeUserStatus(
      {required String userId, required bool isAdmin}) async {
    bool isSuccess = false;

    String userStatus = isAdmin == true ? 'admin' : 'user';

    // try {
    //   await FirebaseFirestore.instance
    //       .collection(collectionName)
    //       .doc(userId)
    //       .update({'member_status': userStatus}).then(
    //           (value) => isSuccess = true);
    // } catch (e) {
    //   print('Change status failed');
    // }

    return isSuccess;
  }
}
