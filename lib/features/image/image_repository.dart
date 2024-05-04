import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../../core/constants/constants.dart';
import '../../core/models/content.dart';
import '../../core/utils.dart';

class ImageRepository {
  final _dio = Dio();

  final _options = Options(
    headers: {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    },
  );

  Future<int?> uploadImage(File image, String fileName, Content content) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          image.path,
          filename: fileName,
          contentType: MediaType('image', 'jpg'),
        ),
        'index': content.index,
        'bid': content.bid,
      });

      final response = await _dio.post(
        Const.imageURL,
        data: formData,
        options: _options,
      );

      return response.statusCode!;
    } on DioException catch (e) {
      return e.response!.statusCode;
    } catch (e) {
      return null;
    }
  }

  Future<int?> updateImage(File image, String fileName, Content content) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          image.path,
          filename: fileName,
          contentType: MediaType('image', 'jpg'),
        ),
        'id': content.id,
        'index': content.index,
      });

      final response = await _dio.put(
        Const.imageURL,
        data: formData,
        options: _options,
      );

      return response.statusCode!;
    } on DioException catch (e) {
      return e.response!.statusCode;
    } catch (e) {
      return null;
    }
  }
}
