part of 'event_bloc.dart';

sealed class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class AddEvEvent extends EventEvent {
  final EventModel eventModel;
  const AddEvEvent({required this.eventModel});
}

class UpdateEvEvent extends EventEvent {
  final EventModel eventModel;
  const UpdateEvEvent({required this.eventModel});
}
