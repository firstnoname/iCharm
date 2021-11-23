import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
  }

  FutureOr<void> _onSubmitPhoneNumber(
      LoginEventSubmittedPhoneNumber event, Emitter<LoginState> emit) {
    // Sent a phone number and waiting for sms.
    try {
      _verifyPhoneNumber(event.phoneNumber);
      emit(LoginStateSMSReceivedSuccess(
          phoneNumber: event.phoneNumber, resendToken: _resendToken));
      print('verification -> success');
    } catch (e) {
      print('');
    }
  }

  FutureOr<void> _onSMSReceived(
      LoginEventSMSReceived event, Emitter<LoginState> emit) {}

  void _verifyPhoneNumber(String phoneNumber) async {
    await _appManagerBloc.appAuth
        .verifyPhoneNumber(
      phoneNumber: '+66$phoneNumber',
      verificationCompleted: (phoneAuthCredential) async {
        await _appManagerBloc.appAuth.signInWithCredential(phoneAuthCredential);
      },
      verificationFailed: (e) => print(e.code),
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