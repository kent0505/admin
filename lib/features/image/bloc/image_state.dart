part of 'image_bloc.dart';

abstract class ImageState {}

class ImageInitial extends ImageState {}

class ImageLoadingState extends ImageState {
  final File file;
  ImageLoadingState(this.file);
}

class ImagePickedState extends ImageState {
  final File file;
  ImagePickedState(this.file);
}

class ImageSuccessState extends ImageState {
  final String message;
  final int status;
  ImageSuccessState(
    this.message,
    this.status,
  );
}

class ImageErrorState extends ImageState {
  final String message;
  final int? status;
  ImageErrorState(
    this.message,
    this.status,
  );
}
