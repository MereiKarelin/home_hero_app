import 'package:homehero/data/models/event_model.dart';
import 'package:homehero/data/source/event_remote_data_source.dart';
import 'package:homehero/domain/repo/event_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: EventRepo)
class EventRepoImpl implements EventRepo {
  final EventDataSource eventDataSource;

  const EventRepoImpl({
    required this.eventDataSource,
  });

  @override
  Future<List<EventModel>> getEventsByMonth(int year, int month) {
    return eventDataSource.getEventsByMonth(year, month);
  }

  @override
  Future<List<EventModel>> getEventsByDay(int year, int month, int day) {
    return eventDataSource.getEventsByDay(year, month, day);
  }

  @override
  Future<void> addEvent(EventModel event) {
    return eventDataSource.addEvent(event);
  }

  @override
  Future<void> updateEvent(String id, EventModel event) {
    return eventDataSource.updateEvent(id, event);
  }
}
