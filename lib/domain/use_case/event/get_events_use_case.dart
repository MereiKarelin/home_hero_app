import 'package:datex/data/models/event_model.dart';

import 'package:datex/domain/repo/event_repo.dart';
import 'package:datex/domain/use_case/base_use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetEventsUseCase implements UseCase<List<EventModel>, NoParams> {
  final EventRepo repository;

  const GetEventsUseCase({
    required this.repository,
  });

  @override
  Future<List<EventModel>> call(NoParams params) async {
    return await repository.getEvents();
  }
}
