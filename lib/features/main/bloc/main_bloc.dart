import 'package:bloc/bloc.dart';
import 'package:datex/data/models/event_model.dart';
import 'package:datex/data/models/user_info_model.dart';
import 'package:datex/domain/use_case/base_use_case.dart';
import 'package:datex/domain/use_case/event/get_events_use_case.dart';
import 'package:datex/domain/use_case/user/get_followers_use_case.dart';
import 'package:datex/domain/use_case/user/get_user_info_use_case.dart';
import 'package:datex/domain/use_case/user/update_user_use_case.dart';
import 'package:datex/utils/injectable/configurator.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'main_event.dart';
part 'main_state.dart';

@Injectable()
class MainBloc extends Bloc<MainEvent, MainState> {
  final GetEventsUseCase getEventsUseCase;
  final GetFollowersUseCase getFollowersUseCase;
  final GetUserUseCase getUserUseCase;
  final UpdateUserUseCase updateUserUseCase;

  MainBloc(this.getEventsUseCase, this.getFollowersUseCase, this.getUserUseCase, this.updateUserUseCase) : super(MainInitial()) {
    // Регистрируем обработчик для MainStartEvent
    on<MainStartEvent>(_load);
    on<UpdateUserInfoEvent>(_updateUser);
  }

  Future<void> _load(MainStartEvent event, Emitter<MainState> emit) async {
    try {
      emit(MainLoadingState());

      final data = await getEventsUseCase(NoParams());
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

      final userType = sharedDb.getString('userType');
      if (userType == "LEADING") {
        followers = await getFollowersUseCase(NoParams());
      }
      final userName = sharedDb.getString('name');
      final id = sharedDb.getInt('id');
      final user = await getUserUseCase(GetUserUseCaseParams(id: id.toString()));
      emit(MainLoadedState(followers,
          events: data,
          todayEvents: todayEvents,
          userType: userType ?? '',
          userId: id.toString(),
          userName: userName ?? '',
          todayExtraEvents: todayExtraEvents,
          userInfo: user));
    } catch (err) {
      print(err);
      emit(MainErrorState());
    }
  }

  Future<void> _updateUser(UpdateUserInfoEvent event, Emitter<MainState> emit) async {
    try {
      emit(MainLoadingState());

      await updateUserUseCase(UpdateUserUseCaseParams(userInfoModel: event.userInfoModel));

      final data = await getEventsUseCase(NoParams());
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

      final userType = sharedDb.getString('userType');
      if (userType == "LEADING") {
        followers = await getFollowersUseCase(NoParams());
      }
      final userName = sharedDb.getString('name');
      final id = sharedDb.getInt('id');
      final user = await getUserUseCase(GetUserUseCaseParams(id: id.toString()));
      emit(MainLoadedState(followers,
          events: data,
          todayEvents: todayEvents,
          userType: userType ?? '',
          userId: id.toString(),
          userName: userName ?? '',
          todayExtraEvents: todayExtraEvents,
          userInfo: user));
    } catch (err) {
      print(err);
      emit(MainErrorState());
    }
  }
}
