import 'package:dio/dio.dart';

import '../../core/constants/constants.dart';
import '../../core/models/blog.dart';
import '../../core/utils.dart';

class BlogRepository {
  late Dio dio;

  BlogRepository() {
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

  Future<int?> addBlog(BlogModel blog) async {
    try {
      final response = await dio.post(
        Const.blogURL,
        data: {
          'title': blog.title.trim(),
          'index': int.parse(blog.index),
          'cid': int.parse(blog.cid),
        },
      );
      return response.statusCode!;
    } on DioException catch (e) {
      return e.response!.statusCode;
    } catch (e) {
      return null;
    }
  }

  Future<int?> updateBlog(BlogModel blog) async {
    try {
      final response = await dio.put(
        Const.blogURL,
        data: {
          'id': blog.id,
          'title': blog.title.trim(),
          'index': int.parse(blog.index),
          'cid': int.parse(blog.cid),
        },
      );
      return response.statusCode;
    } on DioException catch (e) {
      return e.response!.statusCode;
    } catch (e) {
      return null;
    }
  }

  Future<int?> deleteBlog(int id) async {
    try {
      final response = await dio.delete('${Const.blogURL}$id');

      return response.statusCode;
    } on DioException catch (e) {
      return e.response!.statusCode;
    } catch (e) {
      return null;
    }
  }
}
