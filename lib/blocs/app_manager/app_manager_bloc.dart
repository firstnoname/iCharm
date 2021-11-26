import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:i_charm/blocs/a_bloc_observer.dart';
import 'package:i_charm/models/models.dart';
import 'package:i_charm/services/services.dart';
import 'package:meta/meta.dart';

part 'app_manager_event.dart';
part 'app_manager_state.dart';

class AppManagerBloc extends Bloc<AppManagerEvent, AppManagerState> {
  final CameraDescription firstCamera;

  late Authentication _appAuth;

  Authentication get appAuth => _appAuth;

  User? _currentUser;

  AppManagerBloc(this.firstCamera) : super(AppManagerInitialInProgress()) {
    Bloc.observer = ABlocObserver();
    _appAuth = Authentication(this);

    on<AppManagerEventInitialApp>(_onAppManagerInitial);
    on<AppManagerEventLoginSuccess>(_onAppManagerLoginSuccess);
  }

  Future<void> _onAppManagerInitial(
      AppManagerEventInitialApp event, Emitter<AppManagerState> emit) async {
    if (_appAuth.isLoggedIn()) {
      try {
        await _appAuth.checkCurrentUserProfile();
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

  void updateCurrentUserProfile(User? user) {
    if (_currentUser?.phoneNumber != user?.phoneNumber) {
      //todo: ถ้า เบอร์โทรเปลี่ยน ต้องมีการอัพเดทไปยัง auth
    }
    _currentUser = user;
  }
}
