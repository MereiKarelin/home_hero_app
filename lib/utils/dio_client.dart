import 'package:datex/utils/remote_constants.dart';
import 'package:datex/utils/shared_db.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DioClient {
  final SharedDb sharedDb;
  late final Dio _dio;

  DioClient(this.sharedDb) {
    _dio = Dio(
      BaseOptions(
        baseUrl: RemoteConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? token = sharedDb.getString('token');
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          print('Запрос [${options.method}] => ${options.uri}');
          print('Заголовки: ${options.headers}');
          print('Данные: ${options.data}');

          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('Ответ [${response.statusCode}] => ${response.requestOptions.uri}');
          print('Данные ответа: ${response.data}');
          return handler.next(response);
        },
        onError: (error, handler) async {
          print('Ошибка [${error.response?.statusCode}]: $error');

          final statusCode = error.response?.statusCode;

          // Проверяем, что это именно 401 или 403, указывающие на невалидный (просроченный) токен
          if ((statusCode == 401 || statusCode == 403) && !(error.requestOptions.extra['requiresTokenRefresh'] == true)) {
            // Ставим флаг, чтобы не зациклиться
            error.requestOptions.extra['requiresTokenRefresh'] = true;

            try {
              // Попробуем обновить токен
              // final newToken = await _refreshToken();
              // if (newToken != null) {
              //   // Сохраняем токен локально
              //   await sharedDb.setString('token', newToken);

              //   // Клонируем старый запрос, чтобы повторить его
              //   final opts = Options(
              //     method: error.requestOptions.method,
              //     headers: error.requestOptions.headers,
              //   );

              //   // Обновляем заголовок Authorization
              //   opts.headers?['Authorization'] = 'Bearer $newToken';

              //   // Делаем повторный запрос с новым токеном
              //   final cloneReq = await _dio.request(
              //     error.requestOptions.path,
              //     options: opts,
              //     data: error.requestOptions.data,
              //     queryParameters: error.requestOptions.queryParameters,
              //   );
              //   return handler.resolve(cloneReq);
              // } else {
              //   // Если newToken == null, значит обновить не удалось
              //   // Можем выбросить ошибку или разлогинить пользователя
              //   return handler.next(error);
              // }
            } catch (e) {
              print('Ошибка при попытке обновить токен: $e');
              // Можно сделать logout или другую обработку
              return handler.next(error);
            }
          }

          // Если это не 401/403 или уже пытались рефрешить, пробрасываем ошибку дальше
          return handler.next(error);
        },
      ),
    );
  }

  Dio get dioInstance => _dio;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _safeRequest(() => _dio.get<T>(
          path,
          queryParameters: queryParameters,
          options: options,
        ));
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _safeRequest(() => _dio.post<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
        ));
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _safeRequest(() => _dio.put<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
        ));
  }

  Future<Response<T>> deleteRequest<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _safeRequest(() => _dio.delete<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
        ));
  }

  /// Общий метод для безопасного выполнения запроса
  Future<Response<T>> _safeRequest<T>(Future<Response<T>> Function() requestFunc) async {
    try {
      return await requestFunc();
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    } catch (e) {
      print('Неизвестная ошибка: $e');
      rethrow;
    }
  }

  void _handleDioError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout || error.type == DioExceptionType.receiveTimeout) {
      print('Ошибка таймаута: ${error.message}');
    } else if (error.type == DioExceptionType.badResponse) {
      // Можно проверить error.response?.statusCode
      print('Ошибка ответа: ${error.response?.statusCode} - ${error.message}');
    } else if (error.type == DioExceptionType.cancel) {
      print('Запрос отменён: ${error.message}');
    } else {
      print('Неизвестная ошибка Dio: ${error.message}');
    }
  }

  /// Пример метода, который обращается к вашему API, чтобы получить новый токен.
  /// Если используете real refreshToken, то тут нужно передавать и refresh-токен.
  /// Можно возвращать null, если рефреш не удался.
  Future<String?> _refreshToken() async {
    try {
      // Допустим, у нас есть refreshToken в SharedDb
      final storedRefreshToken = sharedDb.getString('token');
      if (storedRefreshToken == null || storedRefreshToken.isEmpty) {
        return null;
      }

      // Пример запроса:
      final response = await _dio.post(
        '/api/v1/auth/refreshToken',
        data: {
          "refreshToken": storedRefreshToken,
        },
      );

      // Предположим, сервер вернул JSON вида { "token": "...", "refreshToken": "..." }
      final newAccessToken = response.data['token'];
      final newRefreshToken = response.data['refreshToken'];

      // Сохраняем новый refreshToken, если приходит
      if (newRefreshToken != null) {
        await sharedDb.setString('refreshToken', newRefreshToken);
      }

      return newAccessToken; // Возвращаем сам access-токен
    } on DioException catch (e) {
      print('Ошибка при запросе нового токена: $e');
      return null;
    }
  }
}
