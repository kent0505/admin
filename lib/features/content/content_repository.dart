import 'package:dio/dio.dart';

import '../../core/constants/constants.dart';
import '../../core/models/content.dart';
import '../../core/utils.dart';

class ContentRepository {
  late Dio dio;

  ContentRepository() {
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

  Future<int?> addContent(Content content) async {
    try {
      final response = await dio.post(
        Const.contentURL,
        data: {
          'title': content.title,
          'index': content.index,
          'bid': content.bid,
        },
      );
      return response.statusCode!;
    } on DioException catch (e) {
      return e.response!.statusCode;
    } catch (e) {
      return null;
    }
  }

  Future<int?> updateContent(Content content) async {
    try {
      final response = await dio.put(
        Const.contentURL,
        data: {
          'id': content.id,
          'title': content.title,
          'index': content.index,
        },
      );
      return response.statusCode!;
    } on DioException catch (e) {
      return e.response!.statusCode;
    } catch (e) {
      return null;
    }
  }

  Future<int?> deleteContent(Content content) async {
    try {
      final response = await dio.delete('${Const.contentURL}${content.id}');
      return response.statusCode!;
    } on DioException catch (e) {
      return e.response!.statusCode;
    } catch (e) {
      return null;
    }
  }
}
