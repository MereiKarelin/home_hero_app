import 'package:homehero/data/models/event_model.dart';
import 'package:homehero/data/models/user_info_model.dart';

import 'package:homehero/utils/dio_client.dart';
import 'package:homehero/utils/shared_db.dart';
import 'package:injectable/injectable.dart';

abstract class UserDataSource {
  Future<void> createFollowing(UserInfoModel userInfoModel);
  Future<void> updateUser(UserInfoModel userInfoModel);
  Future<void> setFirebaseToken(String token);
  Future<List<UserInfoModel>> getFollowers();
  Future<UserInfoModel> getUserInfo(String id);
}

@LazySingleton(as: UserDataSource)
class UserDataSourceImpl implements UserDataSource {
  final DioClient _dio;
  final SharedDb _sharedDb;

  UserDataSourceImpl(this._dio, this._sharedDb);

  @override
  Future<void> createFollowing(UserInfoModel userInfoModel) async {
    final id = _sharedDb.getInt('id');
    final path = '/user/createFollowing';

    // Здесь указываем <Map<String, dynamic>> (т.к. сервер возвращает объект).
    final response = await _dio.post<Map<String, dynamic>>(
      path,
      data: {
        "leading_id": id,
        "following_number": userInfoModel.number,
        "name": userInfoModel.name,
        "address": userInfoModel.address,
        "coordinates": userInfoModel.location,
        "image_id": userInfoModel.imageId,
      },
    );

    // Получаем объект (а не список).
    final data = response.data; // может быть null
    if (data != null) {
      // Например, можем вывести статус и сообщение
      print('status = ${data["status"]}');
      print('message = ${data["message"]}');
    }
  }

  @override
  Future<void> setFirebaseToken(String token) async {
    final id = _sharedDb.getInt('id');
    final path = '/notification/setFirebaseToken';

    // Здесь указываем <Map<String, dynamic>> (т.к. сервер возвращает объект).
    final response = await _dio.post<Map<String, dynamic>>(
      path,
      data: {
        "id": id,
        "token": token,
      },
    );

    // Получаем объект (а не список).
    final data = response.data; // может быть null
    if (data != null) {
      // Например, можем вывести статус и сообщение
      print('status = ${data["status"]}');
      print('message = ${data["message"]}');
    }
  }

  @override
  Future<void> updateUser(UserInfoModel userInfoModel) async {
    final id = _sharedDb.getInt('id');
    final path = '/user/update';

    userInfoModel.id = id ?? 0;

    // Здесь указываем <Map<String, dynamic>> (т.к. сервер возвращает объект).
    final response = await _dio.post<Map<String, dynamic>>(
      path,
      data: userInfoModel.toJson(),
    );

    // Получаем объект (а не список).
    final data = response.data; // может быть null
    if (data != null) {
      // Например, можем вывести статус и сообщение
      print('status = ${data["status"]}');
      print('message = ${data["message"]}');
    }
  }

  @override
  Future<List<UserInfoModel>> getFollowers() async {
    final id = _sharedDb.getInt('id');
    final path = '/user/getFollowers/$id';

    // Указываем, что ожидаем JSON-массив (список).
    final response = await _dio.get<List<dynamic>>(path);

    // response.data теперь будет типа List<dynamic>?
    final rawList = response.data ?? [];

    // Преобразуем каждый элемент в UserInfoModel
    final followers = rawList.map((item) => UserInfoModel.fromJson(item as Map<String, dynamic>)).toList();

    return followers;
  }

  @override
  Future<UserInfoModel> getUserInfo(String id) async {
    final id = _sharedDb.getInt('id');
    final path = '/user/getUser/$id';

    // Указываем, что ожидаем JSON-массив (список).
    final response = await _dio.get(path);

    // response.data теперь будет типа List<dynamic>?

    // Преобразуем каждый элемент в UserInfoModel

    return UserInfoModel.fromJson(response.data as Map<String, dynamic>);
  }
}
