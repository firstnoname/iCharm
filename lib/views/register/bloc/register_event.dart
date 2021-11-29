part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterEventSubmit extends RegisterEvent {
  final User userInfo;

  const RegisterEventSubmit({required this.userInfo});
}

class RegisterEventSMSReceived extends RegisterEvent {}
