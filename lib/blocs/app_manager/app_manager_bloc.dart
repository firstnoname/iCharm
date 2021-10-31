import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:i_charm/blocs/a_bloc_observer.dart';
import 'package:i_charm/services/services.dart';
import 'package:meta/meta.dart';

part 'app_manager_event.dart';
part 'app_manager_state.dart';

class AppManagerBloc extends Bloc<AppManagerEvent, AppManagerState> {
  final CameraDescription firstCamera;

  late Authentication _appAuth;
  Authentication get appAuth => _appAuth;

  AppManagerBloc(this.firstCamera) : super(AppManagerInitialInProgress()) {
    Bloc.observer = ABlocObserver();
    _appAuth = Authentication(this);

    on<AppManagerEventInitialApp>(_onAppManagerInitial);
    on<AppManagerEventLoginSuccess>(_onAppManagerLoginSuccess);
  }

  void _onAppManagerInitial(
      AppManagerEventInitialApp event, Emitter<AppManagerState> emit) {
    if (_appAuth.isLoggedIn()) {
      try {
        _appAuth.checkCurrentUserProfile();
      } catch (e) {
        print(e.toString());

        // yield await _logoutProcess();
      }
    } else {
      print('No persistent user data');
      emit(AppManagerStateUnauthenticated());
      // yield AppManagerStateUnauthenticated();
    }
    emit(AppManagerStateInitialSuccess());
  }

  void _onAppManagerLoginSuccess(
      AppManagerEventLoginSuccess event, Emitter<AppManagerState> emit) {}
}
