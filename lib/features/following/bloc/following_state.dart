part of 'following_bloc.dart';

sealed class FollowingState extends Equatable {
  const FollowingState();

  @override
  List<Object> get props => [];
}

final class FollowingInitial extends FollowingState {}

final class FollowerCreatedState extends FollowingState {}

final class FollowersLoadedState extends FollowingState {
  final List<UserInfoModel> followers;
  const FollowersLoadedState({required this.followers});
}

final class FollowingErrorState extends FollowingState {
  final String error;

  const FollowingErrorState({required this.error});
}
