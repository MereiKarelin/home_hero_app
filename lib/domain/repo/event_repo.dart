import 'package:datex/data/models/event_model.dart';

abstract class EventRepo {
  Future<List<EventModel>> getEvents();
  Future<void> addEvent(EventModel event);
  Future<void> updateEvent(String id, EventModel event);
  // Future<List<EventModel>> getEvents();
}
