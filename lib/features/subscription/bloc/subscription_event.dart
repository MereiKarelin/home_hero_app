// lib/ui/bloc/subscription_event.dart
part of 'subscription_bloc.dart';

abstract class SubscriptionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SubmitSubscription extends SubscriptionEvent {
  final int userId;
  final SubscriptionTypeModel type;
  final String cardNumber;
  final String expiry;
  final String cvv;

  SubmitSubscription({
    required this.userId,
    required this.type,
    required this.cardNumber,
    required this.expiry,
    required this.cvv,
  });

  @override
  List<Object> get props => [userId, type, cardNumber, expiry, cvv];
}
