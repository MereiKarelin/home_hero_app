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
  final List<EventModel> todayExtraEvents;
  final UserInfoModel userInfo;
  final List<UserInfoModel> followers;
  final String userType;
  final String userName;
  final String userId;

  const MainLoadedState(this.followers,
      {required this.events,
      required this.todayEvents,
      required this.userType,
      required this.userId,
      required this.userName,
      required this.todayExtraEvents,
      required this.userInfo});
}

final class MainErrorState extends MainState {}
