part of 'main_bloc.dart';

sealed class MainState extends Equatable {
  const MainState();

  @override
  List<Object> get props => [];
}

final class MainInitial extends MainState {}

final class MainLoadingState extends MainState {}

final class MainLoadedState extends MainState {
  final List<EventModel> events;
  final List<EventModel> todayEvents;
  final String userType;
  const MainLoadedState({required this.events, required this.todayEvents, required this.userType});
}

final class MainErrorState extends MainState {}
