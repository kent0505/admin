part of 'content_bloc.dart';

abstract class ContentEvent {}

class AddContentEvent extends ContentEvent {
  final Content content;
  AddContentEvent({required this.content});
}

class UpdateContentEvent extends ContentEvent {
  final Content content;
  UpdateContentEvent({required this.content});
}

class DeleteContentEvent extends ContentEvent {
  final Content content;
  DeleteContentEvent({required this.content});
}
