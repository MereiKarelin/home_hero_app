import 'package:datex/data/models/app_notifiction_model.dart';
import 'package:datex/data/source/notification_remote_data_source.dart';
import 'package:datex/domain/repo/notification_repo.dart';
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
