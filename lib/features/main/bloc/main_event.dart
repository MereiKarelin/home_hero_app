part of 'main_bloc.dart';

sealed class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class MainStartEvent extends MainEvent {}

class UpdateUserInfoEvent extends MainEvent {
  final UserInfoModel userInfoModel;

  const UpdateUserInfoEvent({required this.userInfoModel});
}
