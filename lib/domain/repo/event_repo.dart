import 'package:datex/data/models/event_model.dart';

abstract class EventRepo {
  Future<List<EventModel>> getEvents();
}
