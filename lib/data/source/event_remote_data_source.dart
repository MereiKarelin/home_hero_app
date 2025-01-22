import 'package:datex/data/models/event_model.dart';

import 'package:datex/utils/dio_client.dart';
import 'package:datex/utils/shared_db.dart';
import 'package:injectable/injectable.dart';

abstract class EventDataSource {
  Future<List<EventModel>> getEvents();
  Future<void> addEvent(EventModel event);
  Future<void> updateEvent(String id, EventModel event);
}

@LazySingleton(as: EventDataSource)
class EventDataSourceImpl implements EventDataSource {
  final DioClient _dio;
  final SharedDb _sharedDb;

  EventDataSourceImpl(this._dio, this._sharedDb);

  @override
  Future<List<EventModel>> getEvents() async {
    final id = _sharedDb.getInt('id');
    final userType = _sharedDb.getString('userType');

    final path = (userType == 'LEADING') ? '/events/leader/$id' : '/events/following/$id';

    // Указываем <List> после get:
    final response = await _dio.get<List>(path);

    // "response.data" может быть null, поэтому подстрахуемся:
    final data = response.data ?? [];

    // Превращаем "List<dynamic>" в "List<Map<String, dynamic>>" c помощью cast(),
    // а затем мапим в EventModel.fromJson
    return data.cast<Map<String, dynamic>>().map((item) => EventModel.fromJson(item)).toList();
  }

  @override
  Future<void> addEvent(EventModel event) async {
    final id = _sharedDb.getInt('id');
    final userType = _sharedDb.getString('userType');

    final path = '/events/create';

    // Указываем <List> после get:
    final response = await _dio.post<List>(path, data: {
      "leaderUserId": id,
      "followingUserId": 7,
      "title": event.title,
      "description": event.description,
      "assignedDate": DateTime.now().toIso8601String(),
      "executionDate": event.assignedDate.toIso8601String(),
      "endDate": DateTime.now().toIso8601String(),
      "address": event.address,
      "eventType": userType == 'LEADING' ? "REGULAR" : "EMERGENCY"
    });

    // "response.data" может быть null, поэтому подстрахуемся:
    final data = response.data ?? [];
    print(data);

    // Превращаем "List<dynamic>" в "List<Map<String, dynamic>>" c помощью cast(),
    // а затем мапим в EventModel.fromJson
    // return data.cast<Map<String, dynamic>>().map((item) => EventModel.fromJson(item)).toList();
  }

  Future<void> updateEvent(String id, EventModel event) async {
    final userId = _sharedDb.getInt('id');
    final userType = _sharedDb.getString('userType');

    final path = '/events/$id';
    final response = await _dio.put<Map<String, dynamic>>(path, data: {
      "leaderUserId": event.leaderUserId,
      "followingUserId": event.followingUserId,
      "title": event.title,
      "description": event.description,
      "assignedDate": event.assignedDate.toIso8601String(),
      "executionDate": event.executionDate.toIso8601String(),
      "endDate": event.endDate.toIso8601String(),
      "address": event.address,
      "eventType": userType == 'LEADING' ? "REGULAR" : "EMERGENCY"
    });

    // Check if the response is a Map and then map it accordingly
    final data = response.data;
    if (data != null) {
      print(data); // Print the response data for debugging

      // Process the data as a Map<String, dynamic> instead of a List
      // Assuming you're returning an EventModel from this data
      final eventModel = EventModel.fromJson(data);
      // You can now work with the `eventModel`
    } else {
      print('No data received');
    }
  }
}
