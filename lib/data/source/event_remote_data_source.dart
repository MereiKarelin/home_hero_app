import 'package:datex/data/models/event_model.dart';

import 'package:datex/utils/dio_client.dart';
import 'package:datex/utils/shared_db.dart';
import 'package:injectable/injectable.dart';

abstract class EventDataSource {
  Future<List<EventModel>> getEvents();
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
}
