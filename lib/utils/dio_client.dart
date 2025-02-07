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

          // Проверяем, что это именно 401 или 403 (просроченный токен)
          if ((statusCode == 401 || statusCode == 403) && !(error.requestOptions.extra['requiresTokenRefresh'] == true)) {
            // Флаг, чтобы не зациклиться
            error.requestOptions.extra['requiresTokenRefresh'] = true;

            try {
              // Если нужно реализовать рефреш токена, раскомментируйте:
              // final newToken = await _refreshToken();
              // if (newToken != null) {
              //   await sharedDb.setString('token', newToken);
              //   final opts = Options(
              //     method: error.requestOptions.method,
              //     headers: error.requestOptions.headers,
              //   );
              //   opts.headers?['Authorization'] = 'Bearer $newToken';
              //
              //   final cloneReq = await _dio.request(
              //     error.requestOptions.path,
              //     options: opts,
              //     data: error.requestOptions.data,
              //     queryParameters: error.requestOptions.queryParameters,
              //   );
              //   return handler.resolve(cloneReq);
              // } else {
              //   return handler.next(error);
              // }
            } catch (e) {
              print('Ошибка при попытке обновить токен: $e');
              return handler.next(error);
            }
          }

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
    return _safeRequest(
      () => _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _safeRequest(
      () => _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _safeRequest(
      () => _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  Future<Response<T>> deleteRequest<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _safeRequest(
      () => _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  /// Общий метод для безопасного выполнения запроса
  Future<Response<T>> _safeRequest<T>(
    Future<Response<T>> Function() requestFunc,
  ) async {
    try {
      return await requestFunc();
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    } on FormatException catch (e, st) {
      // Если где-то при парсинге JSON упадёт FormatException
      print('Ошибка парсинга: $e\n$st');
      rethrow;
    } catch (e, st) {
      print('Неизвестная ошибка: $e');
      print('StackTrace: $st');
      rethrow;
    }
  }

  void _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        print('Ошибка таймаута: ${error.message}');
        break;

      case DioExceptionType.badResponse:
        // Можно проверить error.response?.statusCode
        print('Ошибка ответа: ${error.response?.statusCode} - ${error.message}');
        break;

      case DioExceptionType.cancel:
        print('Запрос отменён: ${error.message}');
        break;

      case DioExceptionType.unknown:
        // Обычно сюда попадают ошибки вроде FormatException и т.п.
        print('Неизвестная ошибка Dio (type=unknown).');
        print('Сообщение: ${error.message}');
        print('error: ${error.error}');
        print('StackTrace: ${error.stackTrace}');
        break;

      default:
        // На всякий случай обработаем остальные типы
        print('Ошибка Dio: ${error.type}, сообщение: ${error.message}');
        break;
    }
  }

  /// Пример метода рефреша токена (если нужно)
  Future<String?> _refreshToken() async {
    try {
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

      if (newRefreshToken != null) {
        await sharedDb.setString('refreshToken', newRefreshToken);
      }

      return newAccessToken;
    } on DioException catch (e) {
      print('Ошибка при запросе нового токена: $e');
      return null;
    }
  }
}
