part of 'image_bloc.dart';

abstract class ImageState {}

class ImageInitial extends ImageState {}

class ImageLoadingState extends ImageState {
  final File file;
  ImageLoadingState({required this.file});
}

class ImagePickedState extends ImageState {
  final File file;
  ImagePickedState({required this.file});
}

class ImageSuccessState extends ImageState {}

class ImageErrorState extends ImageState {}
