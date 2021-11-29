part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginStateFailure extends LoginState {
  final String failureReason;

  const LoginStateFailure(this.failureReason);
}

class LoginStateSMSReceivedSuccess extends LoginState {
  final String phoneNumber;
  final int? resendToken;

  const LoginStateSMSReceivedSuccess(
      {required this.phoneNumber, required this.resendToken});
}

class LoginStateClosedOTPView extends LoginState {}
