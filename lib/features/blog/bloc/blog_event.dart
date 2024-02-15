part of 'blog_bloc.dart';

abstract class BlogEvent {}

class AddBlogEvent extends BlogEvent {
  final Blog blog;
  AddBlogEvent(this.blog);
}

class UpdateBlogEvent extends BlogEvent {
  final Blog blog;
  UpdateBlogEvent(this.blog);
}

class DeleteBlogEvent extends BlogEvent {
  final Blog blog;
  DeleteBlogEvent(this.blog);
}
