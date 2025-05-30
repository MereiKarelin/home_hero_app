// lib/data/source/subscription_remote_data_source.dart

import 'package:homehero/data/models/subscription_model.dart';
import 'package:homehero/utils/dio_client.dart';
import 'package:injectable/injectable.dart';

abstract class SubscriptionRemoteDataSource {
  Future<SubscriptionModel> subscribe(
    int userId,
    SubscriptionTypeModel type,
    String cardNumber,
    String expiry,
    String cvv,
  );

  Future<bool> hasActiveSubscription(int userId);

  Future<int> getRemainingEvents(int userId);
}

@LazySingleton(as: SubscriptionRemoteDataSource)
class SubscriptionRemoteDataSourceImpl implements SubscriptionRemoteDataSource {
  final DioClient _dio;

  const SubscriptionRemoteDataSourceImpl(this._dio);

  @override
  Future<SubscriptionModel> subscribe(
    int userId,
    SubscriptionTypeModel type,
    String cardNumber,
    String expiry,
    String cvv,
  ) async {
    final resp = await _dio.post<Map<String, dynamic>>(
      '/subscriptions/subscribe',
      data: {
        'userId': userId,
        'type': type.toString().split('.').last,
        // Оборачиваем данные карты в объект "card"
        'card': {
          'number': cardNumber,
          'expiry': expiry,
          'cvv': cvv,
        },
      },
    );
    return SubscriptionModel.fromJson(resp.data!);
  }

  @override
  Future<bool> hasActiveSubscription(int userId) async {
    final resp = await _dio.get<bool>('/subscriptions/status/$userId');
    return resp.data ?? false;
  }

  @override
  Future<int> getRemainingEvents(int userId) async {
    final resp = await _dio.get<int>('/subscriptions/remaining/$userId');
    return resp.data ?? 0;
  }
}
