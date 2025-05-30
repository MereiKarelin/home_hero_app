// lib/domain/use_case/get_unassigned_events_use_case.dart

import 'package:homehero/data/models/event_model.dart';
import 'package:homehero/domain/repo/event_repo.dart';
import 'package:homehero/domain/use_case/base_use_case.dart';
import 'package:injectable/injectable.dart';

/// Пустой класс-параметр (вместо void)
class GetUnassignedEventsParams {}

@lazySingleton
class GetUnassignedEventsUseCase implements UseCase<List<EventModel>, GetUnassignedEventsParams> {
  final EventRepo repository;

  const GetUnassignedEventsUseCase({
    required this.repository,
  });

  @override
  Future<List<EventModel>> call(GetUnassignedEventsParams params) {
    return repository.getUnassignedEvents();
  }
}
