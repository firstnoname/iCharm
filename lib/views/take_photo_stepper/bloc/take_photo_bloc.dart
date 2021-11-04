import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'take_photo_event.dart';
part 'take_photo_state.dart';

class TakePhotoBloc extends Bloc<TakePhotoEvent, TakePhotoState> {
  TakePhotoBloc() : super(TakePhotoInitial()) {
    on<TakePhotoEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
