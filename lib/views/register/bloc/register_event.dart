part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterEventSubmit extends RegisterEvent {
  final String phoneNumber;

  const RegisterEventSubmit(this.phoneNumber);
}

class RegisterEventSMSReceived extends RegisterEvent {}
