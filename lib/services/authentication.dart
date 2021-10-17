import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_charm/blocs/blocs.dart';
import 'package:i_charm/services/services.dart';

class Authentication {
  final AppManagerBloc _appManagerBloc;
  static Authentication? _cache;
  final FirebaseAuth _firebaseAuth;

  factory Authentication(AppManagerBloc appManagerBloc) {
    _cache ??= Authentication._(appManagerBloc);
    return _cache!;
  }

  Authentication._(this._appManagerBloc)
      : _firebaseAuth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required PhoneVerificationCompleted verificationCompleted,
    required PhoneVerificationFailed verificationFailed,
    required PhoneCodeSent codeSent,
    required PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout,
    int? resendToken,
  }) {
    return _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      forceResendingToken: resendToken,
    );
  }

  bool isLoggedIn() {
    return _firebaseAuth.currentUser != null;
  }

  Future<void> signOut() => _firebaseAuth
      .signOut()
      .then((_) => print('Log out succeeded'))
      .catchError((e) => print('Error occurred: ${e.toString()}'));

  checkCurrentUserProfile() async {
    // UserAPI().getUserProfile(_firebaseAuth.currentUser!.uid).then((user) async {
    //   if (user == null) {
    //     // ปิด dialog
    //     _appManagerBloc.registerState = true;
    //     _appManagerBloc.updateCurrentUserProfile(
    //         life.User.fromFirebaseUser(_firebaseAuth.currentUser!));
    //     _appManagerBloc.add(AppManagerEventUserInfoRequested());
    //   } else {
    //     // มีแล้ว ก็ login เข้าไปเลย
    //     _appManagerBloc.updateCurrentUserProfile(user);
    //     // get token notification
    //     String token = await getTokenNotification();
    //     if (token != user.tokenNotification) {
    //       // จะได้ไม่ต้องยิงบ่อยๆ
    //       user.tokenNotification = token;
    //       // update ใน could firestore
    //       UserAPI().editProfile(user);
    //     }
    //     _appManagerBloc.add(AppManagerEventLoginSucceeded());
    //   }
    // });
  }
}
