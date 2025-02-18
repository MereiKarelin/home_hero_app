import 'package:homehero/data/models/event_model.dart';
import 'package:homehero/domain/repo/event_repo.dart';
import 'package:homehero/domain/use_case/base_use_case.dart';
import 'package:injectable/injectable.dart';

class GetEventsByDayParams {
  final int year;
  final int month;
  final int day;

  GetEventsByDayParams({
    required this.year,
    required this.month,
    required this.day,
  });
}

@lazySingleton
class GetEventsByDayUseCase implements UseCase<List<EventModel>, GetEventsByDayParams> {
  final EventRepo repository;

  const GetEventsByDayUseCase({required this.repository});

  @override
  Future<List<EventModel>> call(GetEventsByDayParams params) async {
    return repository.getEventsByDay(params.year, params.month, params.day);
  }
}
