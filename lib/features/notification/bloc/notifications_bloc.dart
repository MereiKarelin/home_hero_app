import 'package:bloc/bloc.dart';
import 'package:datex/data/models/app_notifiction_model.dart';
import 'package:datex/domain/use_case/notification/get_notification_use_case.dart';
import 'package:datex/utils/injectable/configurator.dart';
import 'package:equatable/equatable.dart';

import 'package:injectable/injectable.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

@injectable
class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  int userId = 0;
  final int pageSize = 20;

  NotificationsBloc({
    required this.getNotificationsUseCase,
  }) : super(const NotificationsState()) {
    on<NotificationsFetched>(_onNotificationsFetched);
    on<NotificationsRefreshed>(_onNotificationsRefreshed);
  }

  Future<void> _onNotificationsFetched(NotificationsFetched event, Emitter<NotificationsState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == NotificationStatus.initial) {
        userId = sharedDb.getInt('id') ?? 0;
        final response = await getNotificationsUseCase(
          GetNotificationsParams(userId: userId, page: 0, size: pageSize),
        );
        emit(state.copyWith(
          status: NotificationStatus.success,
          notifications: response.content,
          currentPage: 1,
          totalPages: response.totalPages,
          hasReachedMax: response.number + 1 >= response.totalPages,
        ));
      } else {
        final response = await getNotificationsUseCase(
          GetNotificationsParams(userId: userId, page: state.currentPage, size: pageSize),
        );
        emit(state.copyWith(
          status: NotificationStatus.success,
          notifications: List.of(state.notifications)..addAll(response.content),
          currentPage: state.currentPage + 1,
          totalPages: response.totalPages,
          hasReachedMax: state.currentPage + 1 >= response.totalPages,
        ));
      }
    } catch (e) {
      emit(state.copyWith(status: NotificationStatus.failure));
    }
  }

  Future<void> _onNotificationsRefreshed(NotificationsRefreshed event, Emitter<NotificationsState> emit) async {
    try {
      final response = await getNotificationsUseCase(
        GetNotificationsParams(userId: userId, page: 0, size: pageSize),
      );
      emit(state.copyWith(
        status: NotificationStatus.success,
        notifications: response.content,
        currentPage: 1,
        totalPages: response.totalPages,
        hasReachedMax: response.number + 1 >= response.totalPages,
      ));
    } catch (e) {
      emit(state.copyWith(status: NotificationStatus.failure));
    }
  }
}
