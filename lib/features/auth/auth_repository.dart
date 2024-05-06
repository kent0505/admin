import 'package:dio/dio.dart';

import '../../core/constants/constants.dart';
import '../../core/utils.dart';

class AuthRepository {
  late Dio dio;

  AuthRepository() {
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

  Future<AuthResult> login(
    String username,
    String password,
  ) async {
    try {
      final response = await dio.post(
        Const.loginURL,
        data: {
          'username': username,
          'password': password,
          'fcmtoken': fcmToken,
        },
        options: Options(
          validateStatus: (_) => true,
        ),
      );

      if (response.statusCode == 200) {
        return AuthLoginSuccessResult(token: response.data['access_token']);
      } else {
        return ErrorResult();
      }
    } catch (e) {
      return ErrorResult();
    }
  }

  Future<AuthResult> register(String username, String password) async {
    try {
      final response = await dio.post(
        Const.registerURL,
        data: {
          'username': username,
          'password': password,
          'fcmtoken': fcmToken,
        },
        options: Options(
          validateStatus: (_) => true,
        ),
      );

      if (response.statusCode == 200) {
        return AuthRegisterSuccessResult();
      } else {
        return ErrorResult();
      }
    } catch (e) {
      return ErrorResult();
    }
  }
}

abstract class AuthResult {}

class AuthLoginSuccessResult extends AuthResult {
  final String token;
  AuthLoginSuccessResult({required this.token});
}

class AuthRegisterSuccessResult extends AuthResult {}

class ErrorResult extends AuthResult {}
