// lib/data/repo/subscription_repo_impl.dart

import 'package:homehero/data/models/subscription_model.dart';
import 'package:homehero/data/source/subscription_remote_data_source.dart';
import 'package:homehero/domain/repo/subscriprion_repo.dart';
// import 'package:homehero/domain/repo/subscription_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SubscriptionRepo)
class SubscriptionRepoImpl implements SubscriptionRepo {
  final SubscriptionRemoteDataSource _remote;

  const SubscriptionRepoImpl(this._remote);

  @override
  Future<SubscriptionModel> subscribe(
    int userId,
    SubscriptionTypeModel type,
    String cardNumber,
    String expiry,
    String cvv,
  ) {
    return _remote.subscribe(userId, type, cardNumber, expiry, cvv);
  }

  @override
  Future<bool> hasActiveSubscription(int userId) {
    return _remote.hasActiveSubscription(userId);
  }

  @override
  Future<int> getRemainingEvents(int userId) {
    return _remote.getRemainingEvents(userId);
  }
}
