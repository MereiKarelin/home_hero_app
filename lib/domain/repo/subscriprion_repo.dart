// lib/domain/repo/subscription_repo.dart

import 'package:homehero/data/models/subscription_model.dart';

abstract class SubscriptionRepo {
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
