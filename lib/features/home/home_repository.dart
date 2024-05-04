import 'package:dio/dio.dart';

import '../../core/constants/constants.dart';
import '../../core/models/category.dart';
import '../../core/models/blog.dart';
import '../../core/models/content.dart';
import '../../core/utils.dart';

class HomeRepository {
  late Dio dio;

  HomeRepository() {
    final options = BaseOptions(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    );

    dio = Dio(options);
  }

  Future<HomeResult> fetchCategories() async {
    try {
      final response = await dio.get(Const.categoryURL);

      if (response.statusCode == 200) {
        final List result = response.data['category'];
        final categories = result.map((item) {
          return Category.fromJson(item);
        }).toList();

        return HomeCategoriesResult(categories: categories);
      } else {
        return HomeErrorResult();
      }
    } catch (e) {
      print(e);
      return HomeErrorResult();
    }
  }

  Future<HomeResult> fetchBlogs() async {
    try {
      final response = await dio.get(Const.blogURL);

      if (response.statusCode == 200) {
        final List result = response.data['blog'];
        final blogs = result.map((item) {
          return Blog.fromJson(item);
        }).toList();
        return HomeBlogsResult(blogs: blogs);
      } else {
        return HomeErrorResult();
      }
    } catch (e) {
      print(e);
      return HomeErrorResult();
    }
  }

  Future<HomeResult> fetchContents() async {
    try {
      final response = await dio.get('${Const.contentURL}${0}');

      if (response.statusCode == 200) {
        final List result = response.data['content'];
        final contents = result.map((item) {
          return Content.fromJson(item);
        }).toList();
        return HomeContentsResult(contents: contents);
      } else {
        return HomeErrorResult();
      }
    } catch (e) {
      print(e);
      return HomeErrorResult();
    }
  }
}

abstract class HomeResult {}

class HomeCategoriesResult extends HomeResult {
  final List<Category> categories;
  HomeCategoriesResult({required this.categories});
}

class HomeBlogsResult extends HomeResult {
  final List<Blog> blogs;
  HomeBlogsResult({required this.blogs});
}

class HomeContentsResult extends HomeResult {
  final List<Content> contents;
  HomeContentsResult({required this.contents});
}

class HomeErrorResult extends HomeResult {}
