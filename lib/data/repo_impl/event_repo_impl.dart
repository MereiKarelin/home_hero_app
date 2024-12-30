import 'package:datex/data/models/event_model.dart';
import 'package:datex/data/source/event_remote_data_source.dart';
import 'package:datex/domain/repo/event_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: EventRepo)
class EventRepoImpl implements EventRepo {
  final EventDataSource eventDataSource;

  const EventRepoImpl({
    required this.eventDataSource,
  });

  @override
  Future<List<EventModel>> getEvents() async => await eventDataSource.getEvents();
}
