part of 'main_bloc.dart';

class MainState extends Equatable {
  final bool isLoading;
  final String? errorMessage;

  final Status status;
  final Status calendarStatus;
  final List<EventModel> events;
  final List<EventModel> todayEvents;
  final List<EventModel> todayExtraEvents;
  final UserInfoModel? userInfo;
  final List<UserInfoModel> followers;
  final String? userType;
  final String? userName;
  final String? userId;

  const MainState({
    this.calendarStatus = Status.loading,
    this.status = Status.loading,
    this.isLoading = false,
    this.errorMessage,
    this.events = const [],
    this.todayEvents = const [],
    this.todayExtraEvents = const [],
    this.userInfo,
    this.followers = const [],
    this.userType,
    this.userName,
    this.userId,
  });

  MainState copyWith({
    Status? calendarStatus,
    Status? status,
    bool? isLoading,
    String? errorMessage,
    List<EventModel>? events,
    List<EventModel>? todayEvents,
    List<EventModel>? todayExtraEvents,
    UserInfoModel? userInfo,
    List<UserInfoModel>? followers,
    String? userType,
    String? userName,
    String? userId,
  }) {
    return MainState(
      calendarStatus: calendarStatus ?? this.calendarStatus,
      status: status ?? this.status,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      events: events ?? this.events,
      todayEvents: todayEvents ?? this.todayEvents,
      todayExtraEvents: todayExtraEvents ?? this.todayExtraEvents,
      userInfo: userInfo ?? this.userInfo,
      followers: followers ?? this.followers,
      userType: userType ?? this.userType,
      userName: userName ?? this.userName,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [
        calendarStatus,
        status,
        isLoading,
        errorMessage,
        events,
        todayEvents,
        todayExtraEvents,
        userInfo,
        followers,
        userType,
        userName,
        userId,
      ];
}
