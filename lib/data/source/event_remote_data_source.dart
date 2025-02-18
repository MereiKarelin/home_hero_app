import 'package:homehero/data/models/event_model.dart';
import 'package:homehero/utils/dio_client.dart';
import 'package:homehero/utils/shared_db.dart';
import 'package:injectable/injectable.dart';

abstract class EventDataSource {
  /// Получить события, которые попадают в указанный месяц.
  Future<List<EventModel>> getEventsByMonth(int year, int month);

  /// Получить события, которые попадают в указанный день.
  Future<List<EventModel>> getEventsByDay(int year, int month, int day);

  /// Создать новое событие
  Future<void> addEvent(EventModel event);

  /// Обновить существующее событие по его ID
  Future<void> updateEvent(String id, EventModel event);
}

@LazySingleton(as: EventDataSource)
class EventDataSourceImpl implements EventDataSource {
  final DioClient _dio;
  final SharedDb _sharedDb;

  EventDataSourceImpl(this._dio, this._sharedDb);

  /// ======================= GET EVENTS BY MONTH =======================
  @override
  Future<List<EventModel>> getEventsByMonth(int year, int month) async {
    final id = _sharedDb.getInt('id');
    final userType = _sharedDb.getString('userType');

    // Выбираем нужный эндпоинт
    // Лидер:   /events/leader/{leaderId}/month?year=...&month=...
    // Исполнитель: /events/following/{followingId}/month?year=...&month=...
    final path = (userType == 'LEADING') ? '/events/leader/$id/month' : '/events/following/$id/month';

    // Делаем GET-запрос с queryParameters
    final response = await _dio.get<List>(
      path,
      queryParameters: {
        'year': year,
        'month': month,
      },
    );

    final data = response.data ?? [];
    return data.cast<Map<String, dynamic>>().map((item) => EventModel.fromJson(item)).toList();
  }

  /// ======================= GET EVENTS BY DAY =======================
  @override
  Future<List<EventModel>> getEventsByDay(int year, int month, int day) async {
    final id = _sharedDb.getInt('id');
    final userType = _sharedDb.getString('userType');

    // Аналогично, но для /day
    // Лидер:   /events/leader/{leaderId}/day?year=...&month=...&day=...
    // Исполнитель: /events/following/{followingId}/day?year=...&month=...&day=...
    final path = (userType == 'LEADING') ? '/events/leader/$id/day' : '/events/following/$id/day';

    final response = await _dio.get<List>(
      path,
      queryParameters: {
        'year': year,
        'month': month,
        'day': day,
      },
    );

    final data = response.data ?? [];
    return data.cast<Map<String, dynamic>>().map((item) => EventModel.fromJson(item)).toList();
  }

  /// ========================= CREATE EVENT =========================
  @override
  Future<void> addEvent(EventModel event) async {
    final id = _sharedDb.getInt('id');
    final userType = _sharedDb.getString('userType');

    // В текущем коде создаём событие на бэке
    // POST /events/create
    // Обратите внимание: если в бэке теперь важно передавать repeatPeriod (ONCE/MONTHLY и т.д.),
    // leadingStatus, followingStatus, и т.д. — добавьте их сюда в data:
    final path = '/events/create';

    final response = await _dio.post<Map<String, dynamic>>(
      path,
      data: {
        "leaderUserId": userType == 'LEADING' ? id : event.leaderUserId,
        "followingUserId": userType == 'LEADING' ? event.followingUserId : id,
        "title": event.title,
        "description": event.description,

        // assignedDate можно взять из event.assignedDate (или DateTime.now(), если бизнес-логика требует)
        "assignedDate": event.assignedDate.toIso8601String(),

        // executionDate
        "executionDate": event.executionDate.toIso8601String(),

        // endDate (если есть)
        "endDate": event.endDate?.toIso8601String() ?? DateTime.now().toIso8601String(),

        "address": event.address,

        // eventType — зависит от userType? Или берем из event.eventType?
        "eventType": event.eventType,

        // Добавляем повторение (если нужно)
        "repeatPeriod": event.repeatPeriod, // "ONCE"/"MONTHLY"/...

        // Остальные поля, если нужны (leadingStatus, followingStatus, ...).
        "leadingStatus": event.leadingStatus,
        "followingStatus": event.followingStatus,
        "progressInfo": event.progressInfo,
        "comment": event.comment,
        "confirmed": event.confirmed,
        // imageIds, если у вас есть
        "imageIds": event.imageIds,
      },
    );

    final data = response.data;
    if (data != null) {
      print('Созданное событие: $data');
      // Можно распарсить, если нужно
      // final createdEvent = EventModel.fromJson(data);
    } else {
      print('No data received');
    }
  }

  /// ======================== UPDATE EVENT ========================
  @override
  Future<void> updateEvent(String id, EventModel event) async {
    // PUT /events/{eventId}

    final path = '/events/$id';

    final response = await _dio.put<Map<String, dynamic>>(
      path,
      data: {
        "leaderUserId": event.leaderUserId,
        "followingUserId": event.followingUserId,
        "title": event.title,
        "description": event.description,
        "assignedDate": event.assignedDate.toIso8601String(),
        "executionDate": event.executionDate.toIso8601String(),
        "endDate": event.endDate?.toIso8601String(),
        "address": event.address,
        "eventType": event.eventType, // "REGULAR"/"EMERGENCY"
        "repeatPeriod": event.repeatPeriod, // ONCE/MONTHLY/etc
        "leadingStatus": event.leadingStatus,
        "followingStatus": event.followingStatus,
        "progressInfo": event.progressInfo,
        "comment": event.comment,
        "confirmed": event.confirmed,
        "imageIds": event.imageIds,
      },
    );

    final data = response.data;
    if (data != null) {
      print('Обновлённое событие: $data');
      // final updatedEvent = EventModel.fromJson(data);
    } else {
      print('No data received');
    }
  }
}
