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

    // Указываем <List> после get, так как сервер возвращает массив событий:
    final response = await _dio.get<List>(path);

    // response.data может быть null, поэтому подстраховываемся:
    final data = response.data ?? [];

    // Превращаем List<dynamic> в List<Map<String, dynamic>> c помощью cast(),
    // а затем мапим в EventModel.fromJson.
    return data.cast<Map<String, dynamic>>().map((item) => EventModel.fromJson(item)).toList();
  }

  @override
  Future<void> addEvent(EventModel event) async {
    final id = _sharedDb.getInt('id');
    final userType = _sharedDb.getString('userType');

    final path = '/events/create';

    // Указываем <Map<String, dynamic>>, чтобы ожидать от сервера объект, а не список:
    final response = await _dio.post<Map<String, dynamic>>(
      path,
      data: {
        "leaderUserId": id,
        "followingUserId": event.followingUserId,
        "title": event.title,
        "description": event.description,
        "assignedDate": DateTime.now().toIso8601String(),
        "executionDate": event.assignedDate.toIso8601String(),
        "endDate": DateTime.now().toIso8601String(),
        "address": event.address,
        "eventType": userType == 'LEADING' ? "REGULAR" : "EMERGENCY"
      },
    );

    final data = response.data;
    if (data != null) {
      print('Созданное событие: $data');

      // Если нужно распарсить в модель:
      // final createdEvent = EventModel.fromJson(data);
      // ... Дальше можно работать с `createdEvent`
    } else {
      print('No data received');
    }
  }

  @override
  Future<void> updateEvent(String id, EventModel event) async {
    final userId = _sharedDb.getInt('id');
    final userType = _sharedDb.getString('userType');

    final path = '/events/$id';

    // Указываем <Map<String, dynamic>>, так как сервер возвращает одиночный объект события:
    final response = await _dio.put<Map<String, dynamic>>(
      path,
      data: {
        "leaderUserId": event.leaderUserId,
        "followingUserId": event.followingUserId,
        "title": event.title,
        "description": event.description,
        "assignedDate": event.assignedDate.toIso8601String(),
        "executionDate": event.executionDate.toIso8601String(),
        "endDate": event.endDate.toIso8601String(),
        "address": event.address,
        "eventType": userType == 'LEADING' ? "REGULAR" : "EMERGENCY"
      },
    );

    final data = response.data;
    if (data != null) {
      print('Обновлённое событие: $data');

      // Преобразуем Map<String, dynamic> в модель EventModel:
      final updatedEvent = EventModel.fromJson(data);
      // Теперь можно работать с `updatedEvent`, если это необходимо
    } else {
      print('No data received');
    }
  }
}
