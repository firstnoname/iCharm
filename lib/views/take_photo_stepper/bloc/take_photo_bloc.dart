import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'take_photo_event.dart';
part 'take_photo_state.dart';

class TakePhotoBloc extends Bloc<TakePhotoEvent, TakePhotoState> {
  TakePhotoBloc() : super(TakePhotoInitial()) {
    on<TakePhotoEventAddedImagePath>(_onAddedImagePath);
  }

  final Map<int, String> _rawImagePath = {};
  Map<int, String> get imagesPath => _rawImagePath;

  // final String _img01 = '';
  // String get img01 => _img01;
  // final String _img02 = '';
  // String get img02 => _img02;
  // final String _img03 = '';
  // String get img03 => _img03;
  // final String _img04 = '';
  // String get img04 => _img04;

  FutureOr<void> _onAddedImagePath(
      TakePhotoEventAddedImagePath event, Emitter<TakePhotoState> emit) {
    _rawImagePath[event.index] = event.imagePath;
    var mapEntries = _rawImagePath.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    _rawImagePath
      ..clear()
      ..addEntries(mapEntries);

    emit(TakePhotoStateAddedImagePathSuccess(imagePath: _rawImagePath));
  }
}
