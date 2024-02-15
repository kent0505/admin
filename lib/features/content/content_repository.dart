import 'package:dio/dio.dart';

import '../../core/constants/constants.dart';
import '../../core/network/dio_options.dart';
import '../../core/models/content.dart';

class ContentRepository {
  Future<int?> addContent(Content content) async {
    try {
      final response = await dio.post(
        Const.contentURL,
        data: {
          'title': content.title,
          'index': content.index,
          'bid': content.bid,
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

  Future<int?> updateContent(Content content) async {
    try {
      final response = await dio.put(
        Const.contentURL,
        data: {
          'id': content.id,
          'title': content.title,
          'index': content.index,
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

  Future<int?> deleteContent(Content content) async {
    try {
      final response = await dio.delete(
        '${Const.contentURL}${content.id}',
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
