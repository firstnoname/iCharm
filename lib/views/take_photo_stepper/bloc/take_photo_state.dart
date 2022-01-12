part of 'take_photo_bloc.dart';

abstract class TakePhotoState extends Equatable {
  const TakePhotoState();

  @override
  List<Object> get props => [];
}

class TakePhotoInitial extends TakePhotoState {}

class TakePhotoStateInProgress extends TakePhotoState {}

class TakePhotoStateAddedImagePathSuccess extends TakePhotoState {
  final Map<int, String> imagePath;

  const TakePhotoStateAddedImagePathSuccess({required this.imagePath});
}
