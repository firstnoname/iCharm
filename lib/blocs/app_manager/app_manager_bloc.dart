import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'app_manager_event.dart';
part 'app_manager_state.dart';

class AppManagerBloc extends Bloc<AppManagerEvent, AppManagerState> {
  AppManagerBloc() : super(AppManagerInitialInProgress()) {
    on<AppManagerEventInitialedApp>(_onAppManagerInitial);
  }

  void _onAppManagerInitial(
      AppManagerEventInitialedApp event, Emitter<AppManagerState> emit) {
    emit(AppManagerStateInitialSuccess());
  }
}
