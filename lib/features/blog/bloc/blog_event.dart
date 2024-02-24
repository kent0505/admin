part of 'blog_bloc.dart';

abstract class BlogEvent {}

class AddBlogEvent extends BlogEvent {
  final BlogModel blog;
  AddBlogEvent(this.blog);
}

class UpdateBlogEvent extends BlogEvent {
  final BlogModel blog;
  UpdateBlogEvent(this.blog);
}

class DeleteBlogEvent extends BlogEvent {
  final int id;
  DeleteBlogEvent(this.id);
}
