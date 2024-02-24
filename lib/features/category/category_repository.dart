import 'package:dio/dio.dart';

import '../../core/constants/constants.dart';
import '../../core/network/dio_options.dart';
import '../../core/models/category.dart';

class CategoryRepository {
  Future<int?> addCategory(CategoryModel category) async {
    try {
      final response = await dio.post(
        Const.categoryURL,
        data: {
          'title': category.title.trim(),
          'index': int.parse(category.index),
          'type': int.parse(category.type),
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
        options: options,
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
      final response = await dio.delete(
        '${Const.categoryURL}$id',
        options: options,
      );
      return response.statusCode!;
    } on DioException catch (e) {
      return e.response!.statusCode;
    } catch (e) {
      return null;
    }
  }
}
