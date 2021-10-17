import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'app_manager_event.dart';
part 'app_manager_state.dart';

class AppManagerBloc extends Bloc<AppManagerEvent, AppManagerState> {
  AppManagerBloc() : super(AppManagerInitialInProgress()) {
    on<AppManagerEventInitialApp>(_onAppManagerInitial);
  }

  void _onAppManagerInitial(
      AppManagerEventInitialApp event, Emitter<AppManagerState> emit) {
    emit(AppManagerStateInitialSuccess());
  }
}
