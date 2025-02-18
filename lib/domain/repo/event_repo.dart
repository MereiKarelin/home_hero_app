import 'package:homehero/data/models/event_model.dart';

abstract class EventRepo {
  Future<List<EventModel>> getEventsByMonth(int year, int month);
  Future<List<EventModel>> getEventsByDay(int year, int month, int day);
  Future<void> addEvent(EventModel event);
  Future<void> updateEvent(String id, EventModel event);
}
