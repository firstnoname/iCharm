part of 'app_manager_bloc.dart';

@immutable
abstract class AppManagerState extends Equatable {
  const AppManagerState();

  @override
  List<Object> get props => [];
}

class AppManagerInitialInProgress extends AppManagerState {}

class AppManagerStateInitialSuccess extends AppManagerState {}
