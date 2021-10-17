part of 'app_auth_bloc.dart';

abstract class AppAuthEvent extends Equatable {
  const AppAuthEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusChanged extends AppAuthEvent {}

class AuthenticationLogoutRequested extends AppAuthEvent {}
