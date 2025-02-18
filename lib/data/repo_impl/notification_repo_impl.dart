import 'package:homehero/data/models/app_notifiction_model.dart';
import 'package:homehero/data/source/notification_remote_data_source.dart';
import 'package:homehero/domain/repo/notification_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: NotificationRepo)
class NotificationRepoImpl implements NotificationRepo {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepoImpl({required this.remoteDataSource});

  @override
  Future<NotificationsPageModel> getNotifications(int userId, int page, int size) async {
    return await remoteDataSource.fetchNotifications(userId, page, size);
  }
}
