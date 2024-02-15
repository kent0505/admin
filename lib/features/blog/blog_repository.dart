import 'package:dio/dio.dart';

import '../../core/constants/constants.dart';
import '../../core/network/dio_options.dart';
import '../../core/models/blog.dart';

class BlogRepository {
  Future<int?> addBlog(Blog blog) async {
    try {
      final response = await dio.post(
        Const.blogURL,
        data: {
          'title': blog.title,
          'index': blog.index,
          'cid': blog.cid,
        },
        options: options,
      );
      return response.statusCode!;
    } on DioException catch (e) {
      return e.response!.statusCode;
    } catch (e) {
      return null;
    }
  }

  Future<int?> updateBlog(Blog blog) async {
    try {
      final response = await dio.put(
        Const.blogURL,
        data: {
          'id': blog.id,
          'title': blog.title,
          'index': blog.index,
          'cid': blog.cid,
        },
        options: options,
      );
      return response.statusCode;
    } on DioException catch (e) {
      return e.response!.statusCode;
    } catch (e) {
      return null;
    }
  }

  Future<int?> deleteBlog(Blog blog) async {
    try {
      final response = await dio.delete(
        '${Const.blogURL}${blog.id}',
        options: options,
      );
      return response.statusCode;
    } on DioException catch (e) {
      return e.response!.statusCode;
    } catch (e) {
      return null;
    }
  }
}
