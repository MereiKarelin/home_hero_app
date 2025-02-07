import 'package:datex/data/models/event_model.dart';
import 'package:datex/domain/repo/event_repo.dart';
import 'package:datex/domain/use_case/base_use_case.dart';
import 'package:injectable/injectable.dart';

class GetEventsByMonthParams {
  final int year;
  final int month;

  GetEventsByMonthParams({
    required this.year,
    required this.month,
  });
}

@lazySingleton
class GetEventsByMonthUseCase implements UseCase<List<EventModel>, GetEventsByMonthParams> {
  final EventRepo repository;

  const GetEventsByMonthUseCase({required this.repository});

  @override
  Future<List<EventModel>> call(GetEventsByMonthParams params) async {
    return repository.getEventsByMonth(params.year, params.month);
  }
}
