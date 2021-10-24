part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterStateInprogress extends RegisterState {}

class RegisterStateFailure extends RegisterState {}

class RegisterStateSuccess extends RegisterState {}
