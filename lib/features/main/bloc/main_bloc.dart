import 'package:bloc/bloc.dart';
import 'package:datex/data/models/event_model.dart';
import 'package:datex/domain/use_case/base_use_case.dart';
import 'package:datex/domain/use_case/event/get_events_use_case.dart';
import 'package:datex/utils/injectable/configurator.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'main_event.dart';
part 'main_state.dart';

@Injectable()
class MainBloc extends Bloc<MainEvent, MainState> {
  final GetEventsUseCase getEventsUseCase;

  MainBloc(this.getEventsUseCase) : super(MainInitial()) {
    // Регистрируем обработчик для MainStartEvent
    on<MainStartEvent>(_load);
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
      final userType = sharedDb.getString('userType');
      final userName = sharedDb.getString('name');
      final id = sharedDb.getInt('id');
      emit(MainLoadedState(
          events: data,
          todayEvents: todayEvents,
          userType: userType ?? '',
          userId: id.toString(),
          userName: userName ?? '',
          todayExtraEvents: todayExtraEvents));
    } catch (err) {
      print(err);
      emit(MainErrorState());
    }
  }
}
