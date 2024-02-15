part of 'image_bloc.dart';

abstract class ImageEvent {}

class RemoveImageEvent extends ImageEvent {}

class PickImageEvent extends ImageEvent {}

class UploadImageEvent extends ImageEvent {
  final Content content;
  UploadImageEvent(this.content);
}

class UpdateImageEvent extends ImageEvent {
  final Content content;
  UpdateImageEvent(this.content);
}

class DeleteImageEvent extends ImageEvent {
  final Content content;
  DeleteImageEvent(this.content);
}
