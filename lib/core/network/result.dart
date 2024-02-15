import '../models/blog.dart';
import '../models/category.dart';
import '../models/content.dart';

abstract class Result {}

class LoginSuccessResult extends Result {
  final String token;
  LoginSuccessResult(this.token);
}

class RegisterSuccessResult extends Result {
  final String message;
  final int status;
  RegisterSuccessResult(
    this.message,
    this.status,
  );
}

class CategoriesResult extends Result {
  final List<Category> categories;
  CategoriesResult(this.categories);
}

class BlogsResult extends Result {
  final List<Blog> blogs;
  BlogsResult(this.blogs);
}

class ContentsResult extends Result {
  final List<Content> contents;
  ContentsResult(this.contents);
}

class ErrorResult extends Result {
  final String message;
  final int status;
  ErrorResult(
    this.message,
    this.status,
  );
}

class ServerErrorResult extends Result {}
