// lib/ui/bloc/subscription_state.dart
part of 'subscription_bloc.dart';

abstract class SubscriptionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubscriptionInitial extends SubscriptionState {}

class SubscriptionLoading extends SubscriptionState {}

class SubscriptionSuccess extends SubscriptionState {
  final SubscriptionModel subscription;
  SubscriptionSuccess(this.subscription);
  @override
  List<Object?> get props => [subscription];
}

class SubscriptionFailure extends SubscriptionState {
  final String error;
  SubscriptionFailure(this.error);
  @override
  List<Object?> get props => [error];
}
