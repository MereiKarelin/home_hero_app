import 'package:bloc/bloc.dart';
import 'package:homehero/data/models/event_model.dart';
import 'package:homehero/data/models/user_info_model.dart';
import 'package:homehero/domain/use_case/base_use_case.dart';
import 'package:homehero/domain/use_case/event/assign_leader_params.dart';
import 'package:homehero/domain/use_case/event/get_events_by_mounth_use_case.dart';
import 'package:homehero/domain/use_case/event/get_unassigned_events_use_case.dart';
import 'package:homehero/domain/use_case/user/get_followers_use_case.dart';
import 'package:homehero/domain/use_case/user/get_user_info_use_case.dart';
import 'package:homehero/domain/use_case/user/set_firebase_token_use_case.dart';
import 'package:homehero/domain/use_case/user/update_user_use_case.dart';
import 'package:homehero/utils/bloc_utils.dart';
import 'package:homehero/utils/firebase_service.dart';
import 'package:homehero/utils/injectable/configurator.dart';
import 'package:equatable/equatable.dart';

import 'package:injectable/injectable.dart';

part 'main_event.dart';
part 'main_state.dart';

@Injectable()
class MainBloc extends Bloc<MainEvent, MainState> {
  final GetEventsByMonthUseCase getEventsByMounthUseCase;
  final GetFollowersUseCase getFollowersUseCase;
  final GetUserUseCase getUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final SetFirebaseToken setFirebaseToken;
  final GetUnassignedEventsUseCase getUnassignedEventsUseCase;
  final AssignLeaderUseCase assignLeaderUseCase;

  MainBloc(this.getEventsByMounthUseCase, this.getFollowersUseCase, this.getUserUseCase, this.updateUserUseCase, this.setFirebaseToken,
      this.getUnassignedEventsUseCase, this.assignLeaderUseCase)
      : super(MainState()) {
    // Регистрируем обработчик для MainStartEvent
    on<MainStartEvent>(_load);
    on<UpdateUserInfoEvent>(_updateUser);
    on<SearchByDateEvent>(_searchByDate);
    on<AssignLeader>(_assignLeader);
  }

  Future<void> _load(MainStartEvent event, Emitter<MainState> emit) async {
    try {
      emit(state.copyWith(
        status: Status.loading,
      ));

      final today = DateTime.now();

      final userType = sharedDb.getString('userType');
      List<EventModel> data = [];
      if (userType == 'FOLLOWING') {
        data = await getEventsByMounthUseCase(GetEventsByMonthParams(year: today.year, month: today.month));
      } else {
        data = await getUnassignedEventsUseCase(GetUnassignedEventsParams());
      }
      final todayEvents = data.where((event) {
        // Преобразуем строку в DateTime
        final dt = event.executionDate;
        final now = DateTime.now();

        // Сравниваем только Год, Месяц и День (без учёта часов/минут)
        return dt.year == now.year && dt.month == now.month && dt.day == now.day;
      }).toList();
      final todayExtraEvents = data.where((event) {
        // Преобразуем строку в DateTime
        final dt = event.executionDate;
        final now = DateTime.now();

        // Сравниваем только Год, Месяц и День (без учёта часов/минут)
        return dt.year == now.year && dt.month == now.month && dt.day == now.day && event.eventType == 'EMERGENCY';
      }).toList();
      List<UserInfoModel> followers = [];

      // final userType = sharedDb.getString('userType');

      final userName = sharedDb.getString('name');
      final id = sharedDb.getInt('id');
      final user = await getUserUseCase(GetUserUseCaseParams(id: id.toString()));
      emit(state.copyWith(
          calendarStatus: Status.success,
          status: Status.success,
          followers: followers,
          events: data,
          todayEvents: todayEvents,
          userType: userType ?? '',
          userId: id.toString(),
          userName: userName ?? '',
          todayExtraEvents: todayExtraEvents,
          userInfo: user));

      // NotificationService firebaseMessaging = NotificationService();
      // final token = await firebaseMessaging.getFcmToken();
      // await setFirebaseToken(SetFirebaseTokenParams(token: token));
    } catch (err) {
      print(err);
      emit(state.copyWith(
        status: Status.error,
      ));
    }
  }

  Future<void> _searchByDate(SearchByDateEvent event, Emitter<MainState> emit) async {
    try {
      emit(state.copyWith(calendarStatus: Status.loading));

      final data = await getEventsByMounthUseCase(GetEventsByMonthParams(year: event.year, month: event.mouth));

      emit(state.copyWith(
        calendarStatus: Status.success,
        events: data,
      ));
    } catch (err) {
      print(err);
      emit(state.copyWith(
        status: Status.error,
      ));
    }
  }

  Future<void> _assignLeader(AssignLeader event, Emitter<MainState> emit) async {
    try {
      emit(state.copyWith(calendarStatus: Status.loading));
      final id = sharedDb.getInt('id');

      await assignLeaderUseCase(AssignLeaderParams(eventId: event.eventId, leaderId: id ?? 0));

      emit(state.copyWith(
        calendarStatus: Status.success,
        // events: ,
      ));
    } catch (err) {
      print(err);
      emit(state.copyWith(
        status: Status.error,
      ));
    }
  }

  Future<void> _updateUser(UpdateUserInfoEvent event, Emitter<MainState> emit) async {
    try {
      emit(state.copyWith(
        status: Status.loading,
      ));

      final userName = sharedDb.getString('name');
      final id = sharedDb.getInt('id');
      final user = await getUserUseCase(GetUserUseCaseParams(id: id.toString()));

      emit(state.copyWith(status: Status.success, userId: id.toString(), userName: userName ?? '', userInfo: user));
    } catch (err) {
      print(err);
      emit(state.copyWith(
        status: Status.error,
      ));
    }
  }
}
