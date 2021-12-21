part of 'take_photo_bloc.dart';

abstract class TakePhotoEvent extends Equatable {
  const TakePhotoEvent();

  @override
  List<Object> get props => [];
}

class TakePhotoEventAddedImagePath extends TakePhotoEvent {
  final String imagePath;
  final int index;

  const TakePhotoEventAddedImagePath(this.imagePath, this.index);
}
