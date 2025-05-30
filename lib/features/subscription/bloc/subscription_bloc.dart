// lib/ui/bloc/subscription_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:homehero/domain/use_case/subscriprion/subscribe_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:homehero/data/models/subscription_model.dart';
// import 'package:homehero/domain/use_case/subscribe_use_case.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

@injectable
class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final SubscribeUseCase _subscribeUC;

  SubscriptionBloc(this._subscribeUC) : super(SubscriptionInitial()) {
    on<SubmitSubscription>(_onSubmit);
  }

  Future<void> _onSubmit(
    SubmitSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionLoading());
    try {
      final sub = await _subscribeUC.call(
        SubscribeParams(
          userId: event.userId,
          type: event.type,
          cardNumber: event.cardNumber,
          expiry: event.expiry,
          cvv: event.cvv,
        ),
      );
      emit(SubscriptionSuccess(sub));
    } catch (e) {
      emit(SubscriptionFailure(e.toString()));
    }
  }
}
