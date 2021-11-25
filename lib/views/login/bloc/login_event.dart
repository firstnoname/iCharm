part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEventFailure extends LoginEvent {}

class LoginEventInProgress extends LoginEvent {}

class LoginEventSubmittedPhoneNumber extends LoginEvent {
  final String phoneNumber;

  const LoginEventSubmittedPhoneNumber(this.phoneNumber);
}

class LoginEventSMSReceived extends LoginEvent {}

class LoginEventOTPSubmitted extends LoginEvent {
  final String otpCode;

  const LoginEventOTPSubmitted({required this.otpCode});
}
