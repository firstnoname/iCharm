part of 'take_photo_bloc.dart';

abstract class TakePhotoState extends Equatable {
  const TakePhotoState();
  
  @override
  List<Object> get props => [];
}

class TakePhotoInitial extends TakePhotoState {}
