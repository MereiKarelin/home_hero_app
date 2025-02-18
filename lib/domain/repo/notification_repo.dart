import 'package:homehero/data/models/app_notifiction_model.dart';

abstract class NotificationRepo {
  /// Метод для получения уведомлений с пагинацией
  /// [userId] – идентификатор пользователя;
  /// [page] – номер страницы;
  /// [size] – размер страницы.
  Future<NotificationsPageModel> getNotifications(int userId, int page, int size);
}
