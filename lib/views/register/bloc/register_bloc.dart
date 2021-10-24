import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:i_charm/blocs/blocs.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends BaseBloc<RegisterEvent, RegisterState> {
  RegisterBloc(BuildContext context) : super(context, RegisterInitial()) {
    on<RegisterEventSubmit>(_onRegisterSubmit);
  }

  void _onRegisterSubmit(
      RegisterEventSubmit event, Emitter<RegisterState> emit) {
    emit(RegisterStateInprogress());
    try {
      // Add value to firebase.
      _verifyPhoneNumber(event.phoneNumber);
      emit(RegisterStateSuccess());
    } catch (e) {
      // Emit failure state, when add user failure.
      // emit(RegisterStateFailure());
    }
  }

  void _verifyPhoneNumber(String phoneNumber) async {
    await appManagerBloc.appAuth
        .verifyPhoneNumber(
            phoneNumber: phoneNumber,
            verificationCompleted: (phoneAuthCredential) async {
              await appManagerBloc.appAuth
                  .signInWithCredential(phoneAuthCredential);
            },
            verificationFailed: (e) => print(e.code),
            codeSent: (verificationId, resendToken) {
              // _verificationId = verificationId;
              // _resendToken = resendToken;
              print('verificationId -> $verificationId');
              add(RegisterEventSMSReceived());
            },
            codeAutoRetrievalTimeout: (verificationId) => null)
        .catchError((error) {
      print('Error');
      print('error: ${error.toString()}');
    });
  }
}
