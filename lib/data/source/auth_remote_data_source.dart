import 'package:homehero/data/models/user_model.dart';
import 'package:homehero/features/core/auth_utils.dart';
import 'package:homehero/utils/dio_client.dart';
import 'package:homehero/utils/shared_db.dart';
import 'package:injectable/injectable.dart';

abstract class AuthDataSource {
  Future<bool> checkNumber(
    String number,
  );
  Future<void> confirmCode(String number, String code, AuthType authType);
  Future<void> login(
    String number,
  );
  Future<void> registration(String number, String name);
}

@LazySingleton(as: AuthDataSource)
class AuthDataSourceImpl implements AuthDataSource {
  final DioClient _dio;
  final SharedDb _sharedDb;

  AuthDataSourceImpl(this._dio, this._sharedDb);

  @override
  Future<bool> checkNumber(String number) async {
    // /api/v1/auth/checkNumber
    final response = await _dio.post('/auth/checkNumber', data: {'number': number});

    return response.data["message"] == "1";
  }

  @override
  Future<void> login(String number) async {
    await _dio.post('/auth/login', data: {'number': number});
  }

  @override
  Future<void> registration(String number, String name) async {
    await _dio.post('/auth/register', data: {'number': number, 'name': name});
  }

  @override
  Future<void> confirmCode(String number, String code, AuthType authType) async {
    final fcmToken = _sharedDb.getString('firebase');

    final response = authType == AuthType.login
        ? await _dio.post('/auth/login/confirm', data: {'number': number, 'code': code, 'fcmToken': fcmToken})
        : await _dio.post('/auth/confirm', data: {'number': number, 'code': code, 'fcmToken': fcmToken});

    final user = User.fromJson(response.data['user']);

    _sharedDb.setString('token', response.data['token']);
    _sharedDb.setString('userType', user.userType ?? '');
    _sharedDb.setString('name', user.name ?? '');
    _sharedDb.setString('number', user.number ?? '');
    _sharedDb.setInt('id', user.id ?? 0);
    _sharedDb.setBool('notifications', true);
  }
}
