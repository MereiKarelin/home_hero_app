class NotificationModel {
  final int id;
  final String description;
  final bool markRead;
  final String notificationType;
  final int userId;

  NotificationModel({
    required this.id,
    required this.description,
    required this.markRead,
    required this.notificationType,
    required this.userId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int,
      description: json['description'] as String,
      markRead: json['markRead'] as bool,
      notificationType: json['notificationType'] as String,
      userId: json['userId'] as int,
    );
  }
}

class NotificationsPageModel {
  final List<NotificationModel> content;
  final int totalPages;
  final int totalElements;
  final int number; // текущий номер страницы, как возвращает сервер
  final int size;

  NotificationsPageModel({
    required this.content,
    required this.totalPages,
    required this.totalElements,
    required this.number,
    required this.size,
  });

  factory NotificationsPageModel.fromJson(Map<String, dynamic> json) {
    var list = json['content'] as List;
    List<NotificationModel> notifications = list.map((e) => NotificationModel.fromJson(e as Map<String, dynamic>)).toList();
    return NotificationsPageModel(
      content: notifications,
      totalPages: json['totalPages'] as int,
      totalElements: json['totalElements'] as int,
      number: json['number'] as int,
      size: json['size'] as int,
    );
  }
}
