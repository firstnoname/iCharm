part of 'app_manager_bloc.dart';

@immutable
abstract class AppManagerEvent extends Equatable {
  const AppManagerEvent();

  @override
  List<Object> get props => [];
}

class AppManagerEventInitialedApp extends AppManagerEvent {}
