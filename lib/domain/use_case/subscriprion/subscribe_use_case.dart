// lib/domain/use_case/subscribe_use_case.dart
import 'package:homehero/data/models/subscription_model.dart';
import 'package:homehero/domain/repo/subscriprion_repo.dart';
// import 'package:homehero/domain/repo/subscription_repo.dart';
import 'package:homehero/domain/use_case/base_use_case.dart';
import 'package:injectable/injectable.dart';

class SubscribeParams {
  final int userId;
  final SubscriptionTypeModel type;
  final String cardNumber;
  final String expiry;
  final String cvv;

  SubscribeParams({
    required this.userId,
    required this.type,
    required this.cardNumber,
    required this.expiry,
    required this.cvv,
  });
}

@lazySingleton
class SubscribeUseCase implements UseCase<SubscriptionModel, SubscribeParams> {
  final SubscriptionRepo repository;
  const SubscribeUseCase({required this.repository});

  @override
  Future<SubscriptionModel> call(SubscribeParams params) async {
    return repository.subscribe(
      params.userId,
      params.type,
      params.cardNumber,
      params.expiry,
      params.cvv,
    );
  }
}
