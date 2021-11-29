import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_charm/blocs/app_manager/app_manager_bloc.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AppManagerBloc _appManagerBloc;

  late String _verificationId;
  int? _resendToken;

  LoginBloc(this._appManagerBloc) : super(LoginInitial()) {
    on<LoginEventSubmittedPhoneNumber>(_onSubmitPhoneNumber);
    on<LoginEventSMSReceived>(_onSMSReceived);
    on<LoginEventOTPSubmitted>(_onOTPSubmitted);
    on<LoginEventOTPViewClosed>(_onOTPViewClosed);
  }

  Future<FutureOr<void>> _onSubmitPhoneNumber(
      LoginEventSubmittedPhoneNumber event, Emitter<LoginState> emit) async {
    // Sent a phone number and waiting for sms.
    try {
      await _verifyPhoneNumber(event.phoneNumber);
      emit(LoginStateSMSReceivedSuccess(
          phoneNumber: event.phoneNumber, resendToken: _resendToken));
      print('verification -> success');
    } catch (e) {
      print('');
    }
  }

  FutureOr<void> _onSMSReceived(
      LoginEventSMSReceived event, Emitter<LoginState> emit) {}

  FutureOr<void> _onOTPSubmitted(
      LoginEventOTPSubmitted event, Emitter<LoginState> emit) async {
    try {
      await _appManagerBloc.appAuth
          .signInWithPhoneNumber(_verificationId, event.otpCode);
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'invalid-verification-code':
          message = 'otp ไม่ถูกต้อง';
          break;
        default:
          message = e.code;
      }
      emit(LoginStateFailure(message));
    }
  }

  FutureOr<void> _onOTPViewClosed(
      LoginEventOTPViewClosed event, Emitter<LoginState> emit) {
    emit(LoginStateClosedOTPView());
  }

  Future<void> _verifyPhoneNumber(String phoneNumber) {
    return _appManagerBloc.appAuth
        .verifyPhoneNumber(
      phoneNumber: '+66$phoneNumber',
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (e) => add(LoginEventFailure()),
      codeSent: (verificationId, resendToken) {
        _verificationId = verificationId;
        _resendToken = resendToken;
        print('verificationId -> $verificationId');
        // add(LoginEventSMSReceived());
      },
      codeAutoRetrievalTimeout: (verificationId) => null,
      resendToken: _resendToken,
    )
        .catchError((error) {
      print('Error');
      print('error: ${error.toString()}');
    });
  }
}
