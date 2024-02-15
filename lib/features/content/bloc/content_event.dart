part of 'content_bloc.dart';

abstract class ContentEvent {}

class AddContentEvent extends ContentEvent {
  final Content content;
  AddContentEvent(this.content);
}

class UpdateContentEvent extends ContentEvent {
  final Content content;
  UpdateContentEvent(this.content);
}

class DeleteContentEvent extends ContentEvent {
  final Content content;
  DeleteContentEvent(this.content);
}
