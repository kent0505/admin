import 'package:dio/dio.dart';

import '../../core/constants/constants.dart';
import '../../core/models/category.dart';
import '../../core/utils.dart';

class CategoryRepository {
  late Dio dio;

  CategoryRepository() {
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

  Future<int?> addCategory(CategoryModel category) async {
    try {
      final response = await dio.post(
        Const.categoryURL,
        data: {
          'title': category.title.trim(),
          'index': int.parse(category.index),
          'type': int.parse(category.type),
        },
      );
      return response.statusCode!;
    } on DioException catch (e) {
      return e.response!.statusCode;
    } catch (e) {
      return null;
    }
  }

  Future<int?> updateCategory(CategoryModel category) async {
    try {
      final response = await dio.put(
        Const.categoryURL,
        data: {
          'id': category.id,
          'title': category.title.trim(),
          'index': int.parse(category.index),
          'type': int.parse(category.type),
        },
      );
      return response.statusCode!;
    } on DioException catch (e) {
      return e.response!.statusCode;
    } catch (e) {
      return null;
    }
  }

  Future<int?> deleteCategory(int id) async {
    try {
      final response = await dio.delete('${Const.categoryURL}$id');
      return response.statusCode!;
    } on DioException catch (e) {
      return e.response!.statusCode;
    } catch (e) {
      return null;
    }
  }
}
