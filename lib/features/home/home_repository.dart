import '../../core/constants/constants.dart';
import '../../core/network/dio_options.dart';
import '../../core/network/result.dart';
import '../../core/models/category.dart';
import '../../core/models/blog.dart';
import '../../core/models/content.dart';

class HomeRepository {
  Future<Result> fetchCategories() async {
    try {
      final response = await dio.get(
        Const.categoryURL,
        options: options,
      );
      if (response.statusCode == 200) {
        final List result = response.data['category'];
        final categories = result.map((item) {
          return Category.fromJson(item);
        }).toList();

        return CategoriesResult(categories);
      } else {
        return ErrorResult(
          response.data['detail'],
          response.statusCode!,
        );
      }
    } catch (e) {
      print(e);
      return ServerErrorResult();
    }
  }

  Future<Result> fetchBlogs() async {
    try {
      final response = await dio.get(
        Const.blogURL,
        options: options,
      );
      if (response.statusCode == 200) {
        final List result = response.data['blog'];
        final blogs = result.map((item) {
          return Blog.fromJson(item);
        }).toList();
        return BlogsResult(blogs);
      } else {
        return ErrorResult(
          response.data['detail'],
          response.statusCode!,
        );
      }
    } catch (e) {
      print(e);
      return ServerErrorResult();
    }
  }

  Future<Result> fetchContents() async {
    try {
      final response = await dio.get(
        '${Const.contentURL}${0}',
        options: options,
      );
      if (response.statusCode == 200) {
        final List result = response.data['content'];
        final contents = result.map((item) {
          return Content.fromJson(item);
        }).toList();
        return ContentsResult(contents);
      } else {
        return ErrorResult(
          response.data['detail'],
          response.statusCode!,
        );
      }
    } catch (e) {
      print(e);
      return ServerErrorResult();
    }
  }
}
