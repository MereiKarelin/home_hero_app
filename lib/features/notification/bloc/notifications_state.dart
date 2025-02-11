part of 'notifications_bloc.dart';

enum NotificationStatus { initial, success, failure }

class NotificationsState extends Equatable {
  final NotificationStatus status;
  final List<NotificationModel> notifications;
  final bool hasReachedMax;
  final int currentPage;
  final int totalPages;

  const NotificationsState({
    this.status = NotificationStatus.initial,
    this.notifications = const <NotificationModel>[],
    this.hasReachedMax = false,
    this.currentPage = 0,
    this.totalPages = 1,
  });

  NotificationsState copyWith({
    NotificationStatus? status,
    List<NotificationModel>? notifications,
    bool? hasReachedMax,
    int? currentPage,
    int? totalPages,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  @override
  List<Object> get props => [status, notifications, hasReachedMax, currentPage, totalPages];
}
