// lib/domain/use_case/has_active_subscription_use_case.dart
// import 'package:homehero/domain/repo/subscription_repo.dart';
import 'package:homehero/domain/repo/subscriprion_repo.dart';
import 'package:homehero/domain/use_case/base_use_case.dart';
import 'package:injectable/injectable.dart';

class HasActiveSubscriptionParams {
  final int userId;
  HasActiveSubscriptionParams({required this.userId});
}

@lazySingleton
class HasActiveSubscriptionUseCase implements UseCase<bool, HasActiveSubscriptionParams> {
  final SubscriptionRepo repository;
  const HasActiveSubscriptionUseCase({required this.repository});

  @override
  Future<bool> call(HasActiveSubscriptionParams params) async {
    return repository.hasActiveSubscription(params.userId);
  }
}
