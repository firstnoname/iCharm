import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_charm/blocs/blocs.dart';
import 'package:i_charm/services/services.dart';
import 'package:i_charm/models/models.dart' as hexa;

class Authentication {
  final AppManagerBloc _appManagerBloc;
  static Authentication? _cache;
  final FirebaseAuth _firebaseAuth;

  User? get firebaseCurrentUser => _firebaseAuth.currentUser;

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

  Future<void> signInWithPhoneNumber(
    String verificationId,
    String smsCode,
  ) async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    await signInWithCredential(phoneAuthCredential);
  }

  Future<void> signInWithCredential(AuthCredential credential) async {
    await _firebaseAuth.signInWithCredential(credential);
    await checkCurrentUserProfile();
  }

  checkCurrentUserProfile() async {
    UserAPI().getUser(_firebaseAuth.currentUser!.uid).then((user) async {
      if (user == null) {
        // _appManagerBloc.registerState = true;
        _appManagerBloc.updateCurrentUserProfile(
            hexa.User.fromFirebaseUser(_firebaseAuth.currentUser!));
        _appManagerBloc.add(AppManagerEventShowUserPolicy());
      } else {
        print('user not null ');
        _appManagerBloc.updateCurrentUserProfile(user);
        _appManagerBloc.add(AppManagerEventLoginSuccess());
      }
    });
  }
}
