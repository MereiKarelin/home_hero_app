part of 'following_bloc.dart';

sealed class FollowingEvent extends Equatable {
  const FollowingEvent();

  @override
  List<Object> get props => [];
}

class CreateFollowerEvent extends FollowingEvent {
  final UserInfoModel userInfoModel;
  const CreateFollowerEvent({required this.userInfoModel});
}

class GetFollowersEvent extends FollowingEvent {}
