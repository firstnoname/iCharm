import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_auth_event.dart';
part 'app_auth_state.dart';

class AppAuthBloc extends Bloc<AppAuthEvent, AppAuthState> {
  AppAuthBloc() : super(AppAuthState.AppAuthStateInitial()) {
    on<AppAuthEvent>((event, emit) {});
  }
}
