import 'package:homehero/domain/repo/notification_repo.dart';
import 'package:homehero/domain/use_case/base_use_case.dart';
import 'package:homehero/data/models/app_notifiction_model.dart';
import 'package:injectable/injectable.dart';

class GetNotificationsParams {
  final int userId;
  final int page;
  final int size;

  GetNotificationsParams({
    required this.userId,
    required this.page,
    required this.size,
  });
}

@lazySingleton
class GetNotificationsUseCase implements UseCase<NotificationsPageModel, GetNotificationsParams> {
  final NotificationRepo repository;

  const GetNotificationsUseCase({required this.repository});

  @override
  Future<NotificationsPageModel> call(GetNotificationsParams params) async {
    return repository.getNotifications(params.userId, params.page, params.size);
  }
}
