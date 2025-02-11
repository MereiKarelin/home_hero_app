import 'package:datex/data/models/app_notifiction_model.dart';
import 'package:datex/utils/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class NotificationRemoteDataSource {
  Future<NotificationsPageModel> fetchNotifications(int userId, int page, int size);
}

@LazySingleton(as: NotificationRemoteDataSource)
class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final DioClient dio;

  NotificationRemoteDataSourceImpl(this.dio);

  @override
  Future<NotificationsPageModel> fetchNotifications(int userId, int page, int size) async {
    final response = await dio.get(
      '/notification/get/$userId',
      queryParameters: {
        'page': page,
        'size': size,
      },
    );
    // Предполагается, что сервер возвращает JSON-объект
    return NotificationsPageModel.fromJson(response.data);
  }
}
